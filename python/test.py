import os
import numpy as np

from kmodes.util.dissim import matching_dissim

# Lấy đường dẫn tuyệt đối của file hiện tại
current_file_path = os.path.abspath(__file__)

# Lấy thư mục của file hiện tại
current_directory = os.path.dirname(current_file_path)

# Ví dụ tạo đường dẫn tương đối tới một file trong cùng thư mục
relative_path = os.path.join(current_directory, "ten_file_moi.txt")

print(current_directory)
print("Đường dẫn tuyệt đối của file hiện tại:", current_file_path)
print("Đường dẫn tương đối tới file cần lưu:", relative_path)

# with open(current_directory+"/model.pkl","wb") as f:
#     print("Hello world")

a = np.array([['1', 'Cartier', 'True', 'Jacket', 'Linen']])
b = np.array([['1', 'Cartier', 'False', 'Jacket', 'Linen']])
c = matching_dissim(
                a,  # Lấy đúng chỉ số danh mục
                b
            )
print(c)
