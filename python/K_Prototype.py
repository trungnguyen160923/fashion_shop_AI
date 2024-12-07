import os
import pickle

import pandas as pd
import numpy as np
from fastapi import FastAPI
from sklearn.metrics import silhouette_score
from kmodes.util.dissim import matching_dissim
from kmodes.kprototypes import KPrototypes
from sklearn.preprocessing import MinMaxScaler
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL
from config import SERVER, DATABASE, USERNAME, PASSWORD

# Kết nối đến cơ sở dữ liệu
connection_string = "DRIVER={ODBC Driver 17 for SQL Server};SERVER=" + SERVER + ";DATABASE=" + DATABASE + ";UID=" + USERNAME + ";PWD=" + PASSWORD
connection_url = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})
engine = create_engine(connection_url)

app = FastAPI()


# Hàm chuẩn hóa dữ liệu liên tục
def preprocess_data(df, categorical_columns):
    # Chuẩn hóa dữ liệu liên tục
    continuous_columns = [col for col in df.columns if col not in categorical_columns]
    scaler = MinMaxScaler()
    df[continuous_columns] = scaler.fit_transform(df[continuous_columns])
    return df


# Hàm áp dụng K-Prototypes
def k_prototypes_clustering(df, categorical_columns, n_clusters):
    kproto = KPrototypes(n_clusters=n_clusters, init='Huang', random_state=42)
    clusters = kproto.fit_predict(df, categorical=[df.columns.get_loc(col) for col in categorical_columns])
    return clusters, kproto


# Truy vấn dữ liệu từ database
def get_data():
    query = """
        SELECT ID, IDCategory, Price, Brand, Gender, ReleaseTime, ProductType, ProductMaterial
        FROM Product
    """
    df = pd.read_sql(query, engine)
    return df

from kmodes.kprototypes import KPrototypes
import matplotlib.pyplot as plt

def find_optimal_k_prototypes(data, categorical_indices, max_clusters=10):
    """
    Tìm số cụm tối ưu cho K-Prototypes bằng phương pháp Elbow.

    Args:
        data (DataFrame or np.array): Dữ liệu hỗn hợp đã được chuẩn bị.
        categorical_indices (list): Danh sách chỉ số các cột danh mục.
        max_clusters (int): Số cụm tối đa để kiểm tra.

    Returns:
        int: Số cụm tối ưu.
    """
    distortions = []  # Lưu tổng chi phí cho mỗi K
    K = range(15, max_clusters + 1)  # Các giá trị K cần thử

    for k in K:
        kproto = KPrototypes(n_clusters=k, init='Cao', random_state=42)
        kproto.fit_predict(data, categorical=categorical_indices)
        distortions.append(kproto.cost_)

        print(f"K = {k}, Cost = {kproto.cost_}")

    # Vẽ biểu đồ Elbow
    plt.figure(figsize=(8, 5))
    plt.plot(K, distortions, marker='o', linestyle='-')
    plt.xlabel('Number of Clusters (K)')
    plt.ylabel('Cost')
    plt.title('Elbow Method for Optimal K (K-Prototypes)')
    plt.grid()
    plt.show()

    # Xác định điểm Elbow (nếu cần, bạn có thể thêm thuật toán KneeLocator)
    elbow_k = distortions.index(min(distortions)) + 1
    print(f"Optimal K found at: {elbow_k}")
    return elbow_k


def compute_silhouette_score(data, categorical_indices, clusters):
    """
    Tính Silhouette Score cho dữ liệu hỗn hợp phân cụm với K-Prototypes.

    Args:
        data (np.array): Dữ liệu đã được chuẩn bị.
        categorical_indices (list): Danh sách chỉ số của các cột danh mục.
        clusters (array): Kết quả phân cụm.

    Returns:
        float: Silhouette Score.
    """
    # Đảm bảo data là mảng 2D
    if len(data.shape) != 2:
        raise ValueError("Input data must be a 2D array")

    # Tạo ma trận khoảng cách hỗn hợp
        # Tạo ma trận khoảng cách hỗn hợp (dissimilarity)
        dissimilarity_matrix = pairwise_distances(
            data[:, categorical_indices].astype(str),  # Lấy dữ liệu danh mục
            metric=matching_dissim
        )
    score = silhouette_score(dissimilarity_matrix, clusters, metric="precomputed")
    return scores


@app.get("/")
def index():
    return {
        "hello":"Hello world"
    }
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

        categorical_columns = ['IDCategory', 'Brand', 'Gender', 'ProductType', 'ProductMaterial']
        processed_data = preprocess_data(df,categorical_columns)

        # Xác định các cột danh mục (ví dụ: dựa trên cấu trúc dữ liệu)
        categorical_indices = [df.columns.get_loc(col) for col in categorical_columns]

        # Tìm số cụm tối ưu
        # optimal_k = find_optimal_k_prototypes(processed_data.to_numpy(), categorical_indices, max_clusters=10)
        optimal_k = 16
        print(f"Optimal number of clusters: {optimal_k}")

        # Áp dụng K-Prototypes
        kproto = KPrototypes(n_clusters=optimal_k, init='Cao', random_state=42)
        cluster_list = kproto.fit_predict(processed_data.to_numpy(), categorical=categorical_indices)

        # Tính Silhouette Score
        score = compute_silhouette_score(processed_data.to_numpy(), categorical_indices, cluster_list)
        print(f"Silhouette Score: {score}")

        # Lưu mô hình
        current_directory = os.getcwd()
        with open(os.path.join(current_directory, "kproto_model.pkl"), "wb") as f:
            pickle.dump(kproto, f)

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

        return {"code": 200, "message": f"Clustering completed successfully with Silhouette Score: {0.0}"}
    except Exception as e:
        print(f"Error in /cluster: {e}")
        return {"code": 500, "message": f"Failed: {str(e)}"}

@app.get("/get-history-cluster/{session_id}")
def predict_similar_products(session_id: str):
    """Dự đoán các sản phẩm tương tự dựa trên session ID của người dùng"""
    try:
        # Kết nối DB
        engine = create_engine(connection_url)

        # Truy vấn các sản phẩm người dùng đã xem
        history_query = f"""
            SELECT Product.ID, Product.IDCategory, Product.Price, Product.Brand, Product.Gender,
                   Product.ReleaseTime, Product.ProductType, Product.ProductMaterial
            FROM History 
            INNER JOIN Product ON Product.ID = History.ProductID
            WHERE History.SessionID = '{session_id}'
        """
        df_history = pd.read_sql(history_query, engine)

        if df_history.empty:
            return {"code": 404, "message": "No history found for this session"}

        # Tiền xử lý dữ liệu cho các sản phẩm đã xem
        list_ID = df_history["ID"].tolist()
        df_history.drop(columns=["ID"], inplace=True)
        categorical_columns = ['IDCategory', 'Brand', 'Gender', 'ProductType', 'ProductMaterial']
        df_history_processed = preprocess_data(df_history, categorical_columns)

        # Áp dụng mô hình K-Prototypes để dự đoán cụm cho các sản phẩm đã xem
        with open(os.path.join(os.getcwd(), "kproto_model.pkl"), "rb") as f:
            kproto = pickle.load(f)

        categorical_indices = [df_history.columns.get_loc(col) for col in categorical_columns]
        clusters_history = kproto.predict(df_history_processed.to_numpy(), categorical=categorical_indices)

        print(clusters_history)
        return {"code": 200, "cluster": int(clusters_history)}

    except Exception as e:
        print(f"Error in /predict-similar-products: {e}")
        return {"code": 500, "message": f"Failed: {str(e)}"}



# Main function
# def main():
#     try:
#         # Lấy dữ liệu
#         df = get_data()
#         list_ID = df["ID"].tolist()  # Lưu ID để cập nhật
#         df.drop(columns=["ID"], inplace=True)  # Loại bỏ cột ID khỏi phân cụm
#
#         # Định nghĩa các cột danh mục
#         categorical_columns = ['IDCategory', 'Brand', 'Gender', 'ProductType', 'ProductMaterial']
#
#         # Tiền xử lý dữ liệu
#         df_processed = preprocess_data(df, categorical_columns)
#
#         # Áp dụng K-Prototypes
#         optimal_k = 3  # Bạn có thể điều chỉnh số cụm tối ưu
#         clusters, kproto = k_prototypes_clustering(df_processed, categorical_columns, optimal_k)
#
#         # Thêm kết quả phân cụm vào DataFrame
#         df["Cluster"] = clusters
#         df["ID"] = list_ID  # Thêm lại ID để phục vụ cập nhật
#
#         # Batch update vào database
#         update_data = [{"cluster": int(cluster), "product_id": int(product_id)}
#                        for cluster, product_id in zip(df["Cluster"], df["ID"])]
#
#         with engine.connect() as connection:
#             print("Updating database...")
#             with connection.begin():
#                 update_statement = text("""
#                     UPDATE Product SET ProductCluster = :cluster WHERE Product.ID = :product_id
#                 """)
#                 for data in update_data:
#                     connection.execute(update_statement, data)
#
#         print("Clustering completed successfully!")
#     except Exception as e:
#         print(f"Error: {e}")
#
#
# if __name__ == "__main__":
#     engine = create_engine(connection_url)
#     query = "SELECT ID, IDCategory, Price, Brand, Gender, ReleaseTime, ProductType, ProductMaterial FROM Product"
#     df = pd.read_sql(query, engine)
#
#     # Tiền xử lý
#     list_ID = df["ID"].tolist()
#     df.drop(columns=["ID"], inplace=True)
#
#     categorical_columns = ['IDCategory', 'Brand', 'Gender', 'ProductType', 'ProductMaterial']
#     processed_data = preprocess_data(df, categorical_columns)
#
#
#     # Xác định các cột danh mục (ví dụ: dựa trên cấu trúc dữ liệu)
#     categorical_indices = [df.columns.get_loc(col) for col in categorical_columns]
#
#     # Tìm số cụm tối ưu
#     optimal_k = find_optimal_k_prototypes(processed_data.to_numpy(), categorical_indices,30)
#     print(f"Optimal number of clusters: {optimal_k}")
#     #main()
