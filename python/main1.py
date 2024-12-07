from sklearn.metrics import silhouette_score
from sqlalchemy import create_engine, text
from sklearn.preprocessing import LabelEncoder, MinMaxScaler
from sklearn.cluster import KMeans
from kneed import KneeLocator
import pandas as pd
import numpy as np
import pickle
import os

from sqlalchemy.engine import URL
from sqlalchemy import create_engine
from sqlalchemy import text
from config import SERVER, DATABASE, USERNAME, PASSWORD
from fastapi import FastAPI

connection_string = "DRIVER={ODBC Driver 17 for SQL Server};SERVER="+SERVER+";DATABASE="+DATABASE+";UID="+USERNAME+";PWD="+PASSWORD
connection_url = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})
# Tạo engine
try:
    engine = create_engine(connection_url)
    with engine.connect() as connection:
        print("Kết nối thành công!")
except Exception as e:
    print("Kết nối thất bại:", e)

# Lấy đường dẫn tuyệt đối của file hiện tại
current_file_path = os.path.abspath(__file__)
# Lấy thư mục của file hiện tại
current_directory = os.path.dirname(current_file_path)




app = FastAPI()


# Hàm xử lý chung
def preprocess_data(df):
    """Tiền xử lý dữ liệu từ DataFrame"""
    # Replace NaN
    df.fillna(0, inplace=True)

    # Encode Brand với mapping cụ thể
    custom_brand_mapping = {
        'Nike': 10, 'Louis Vuitton': 9, 'GUCCI': 8, 'Chanel': 7,
        'Adidas': 6, 'Hermes': 5, 'ZARA': 4, 'H&M': 3,
        'Cartier': 2, 'UNIQLO': 1
    }
    df['Brand'] = df['Brand'].map(custom_brand_mapping).fillna(0).astype(int)

    # Encode các cột còn lại
    label_cols = ['ProductType', 'Gender', 'ProductMaterial']
    le = LabelEncoder()
    for col in label_cols:
        df[col] = le.fit_transform(df[col])

    # Phân loại Price
    price_min, price_max = df['Price'].min(), df['Price'].max()
    delta = (price_max - price_min) / 3
    bins = [-np.inf, price_min + delta, price_max - delta, np.inf]
    df['Price'] = pd.cut(df['Price'], bins=bins, labels=[0, 1, 2]).astype(int)

    # Chuẩn hóa dữ liệu
    scaler = MinMaxScaler()
    scaled_X = scaler.fit_transform(df)
    return pd.DataFrame(scaled_X, columns=df.columns)


# Hàm tìm số cụm tối ưu
def find_K(data):
    distortions = []
    K = range(1, 11)
    for k in K:
        kmeans = KMeans(n_clusters=k, random_state=42, init='k-means++')
        kmeans.fit(data)
        distortions.append(kmeans.inertia_)

    kn = KneeLocator(K, distortions, curve="convex", direction="decreasing")
    return kn.knee or 3


@app.get("/cluster")
def cluster():
    """Thực hiện phân cụm dữ liệu sản phẩm"""
    try:
        # Kết nối DB
        engine = create_engine(connection_url)
        query = "SELECT ID, IDCategory, Price, Brand, Gender, ReleaseTime, ProductType, ProductMaterial FROM Product"
        df = pd.read_sql(query, engine)

        # Tiền xử lý
        list_ID = df["ID"].tolist()
        df.drop(columns=["ID"], inplace=True)
        processed_data = preprocess_data(df)

        # Xác định số cụm
        optimal_k = find_K(processed_data)
        print(f"Optimal number of clusters: {optimal_k}")

        # Áp dụng KMeans
        kmeans = KMeans(n_clusters=optimal_k, random_state=42)
        cluster_list = kmeans.fit_predict(processed_data)

        # Tính Silhouette Score
        silhouette = silhouette_score(processed_data, cluster_list)
        print(f"Silhouette Score: {silhouette}")

        # Lưu mô hình
        current_directory = os.getcwd()
        with open(os.path.join(current_directory, "model.pkl"), "wb") as f:
            pickle.dump(kmeans, f)

        # Batch update vào database
        update_data = [
            {"cluster": int(cluster), "product_id": int(product_id)}
            for cluster, product_id in zip(cluster_list, list_ID)
        ]

        with engine.connect() as connection:
            print("Running update statement...")

            # Tạo transaction
            with connection.begin():
                update_statement = text("""
                    UPDATE Product SET ProductCluster = :cluster WHERE Product.ID = :product_id
                """)

                # Lặp qua dữ liệu và thực thi lệnh
                for data in update_data:
                    connection.execute(update_statement, {"cluster": data["cluster"], "product_id": data["product_id"]})

        return {"code": 200, "message": "Clustering completed successfully", "silhouette_score": silhouette}
    except Exception as e:
        print(f"Error in /cluster: {e}")
        return {"code": 500, "message": f"Failed: {str(e)}"}


@app.get("/get-history-cluster/{session_id}")
def get_history_cluster(session_id: str):
    """Lấy cluster của lịch sử dựa trên session_id"""
    try:
        # Kết nối DB
        engine = create_engine(connection_url)
        history_query = text("""
            SELECT Product.ID, IDCategory, Price, Brand, Gender, ReleaseTime, ProductType, ProductMaterial 
            FROM (SELECT * FROM History WHERE SessionID = :session_id) AS H 
            INNER JOIN Product ON Product.ID = H.ProductID
        """)
        query = "SELECT ID, IDCategory, Price, Brand, Gender, ReleaseTime, ProductType, ProductMaterial FROM Product"

        # Lấy dữ liệu
        df_history = pd.read_sql(history_query, engine, params={"session_id": session_id})
        df = pd.read_sql(query, engine)
        df_combined = pd.concat([df, df_history], ignore_index=True)
        df_combined.drop(columns=["ID"], inplace=True)

        # Tiền xử lý
        processed_data = preprocess_data(df_combined)


        # Lấy phần lịch sử
        processed_history = processed_data.tail(len(df_history))
        history_mean = processed_history.mean(axis=0)

        # Tải mô hình KMeans
        current_directory = os.getcwd()
        with open(os.path.join(current_directory, "model.pkl"), "rb") as f:
            kmeans = pickle.load(f)

        # Chuyển đổi thành DataFrame với tên cột
        feature_names = processed_data.columns  # Tên cột từ dữ liệu đã xử lý
        input_data = pd.DataFrame([history_mean.tolist()], columns=feature_names)

        print(kmeans.predict(input_data))

        # Dự đoán cluster
        cluster_id = kmeans.predict(input_data)[0]
        print(cluster_id)
        return {"code": 200, "cluster": int(cluster_id)}
    except Exception as e:
        print(f"Error in /get-history-cluster: {e}")
        return {"code": 500, "message": f"Failed: {str(e)}"}
