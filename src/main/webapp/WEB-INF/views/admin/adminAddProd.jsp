<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Riode - Bill Report</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="icon" type="image/png"
	href="https://d-themes.com/html/riode/images/icons/favicon.png">

<link href="<c:url value='/resources/home/dist/css/reset.css' />"
	rel="stylesheet">
<link
	href="<c:url value='/resources/home/dist/css/adminEditProd.css' />"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>
	<!-- Sidebar -->
	<aside class="aside">
		<a href="admin/adminHome.htm" class="admin">
			<div class="logo">
				<i class="fa-solid fa-a"></i>
			</div> Admin
		</a>

		<ul class="functions">
			<li class="function"><a href="admin/adminAccount.htm">
					<div class="icon">
						<i class="fa-solid fa-users"></i>
					</div> Account
			</a></li>

			<li class="function"><a href="admin/adminBill.htm">
					<div class="icon">
						<i class="fa-solid fa-receipt"></i>
					</div> Bill
			</a></li>

			<li class="function"><a href="admin/adminProducts.htm"
				class="active">
					<div class="icon">
						<i class="fa-solid fa-shirt"></i>
					</div> Products
			</a></li>
		</ul>

		<button class="btn-log-out">
			<a href="user/logout.htm">Log out</a>
		</button>
	</aside>

	<!-- Main content -->
	<main class="main">

		<!-- Header -->
		<div class="main-header">
			<div class="header-left">
				<h2>Manage Products</h2>

				<div class="map">
					<a href="admin/home.htm">Home</a> / <a href="admin/adminHome.htm">Admin</a>
					/ <a href="admin/adminAddProd.htm">Add Product</a>
				</div>
			</div>
		</div>

		<!-- Form to Add Product -->
		<div class="main-content">
			<form method="post">
				<div class="row">
					<div class="col-4 image">
						<label for="image">Image Source:</label> <input type="text"
							id="image" name="image" placeholder="Enter image URL here..."
							oninput="previewImage()" required>
					</div>
					<div class="col-4 image-preview">
						<img id="imagePreview" src="" alt="Image Preview"
							style="display: none; max-width: 200px; margin-top: 10px;">
					</div>
					<div class="col-8">
						<div class="row info">
							<div class="col-6 field id">
								<label for="id">Product ID:</label> <input type="text" name="id"
									id="product-id" placeholder="Enter product ID..." required>
								<span id="idError" style="color: red; display: none;">Product
									ID cannot be empty.</span>
							</div>

							<div class="col-6 field name">
								<label for="cat">Category:</label>
								<div class="product-form">
									<select name="cat" id="cat" required>
										<c:forEach var="c" items="${listCats}">
											<option value="${c.idCategory}">${c.nameCategory}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="col-6 field name">
								<label for="name">Product Name:</label> <input type="text"
									id="name" name="name" placeholder="Enter product name..."
									required oninput="checkName()"> <span id="nameError"
									style="color: red; display: none;">Product name cannot
									be empty.</span>
							</div>

							<div class="col-6 field price">
								<label for="price">Price:</label> <input type="number"
									id="price" name="price" placeholder="Enter price..." required
									oninput="checkPrice()"> <span id="priceError"
									style="color: red; display: none;">Price must be greater
									than 0.</span>
							</div>

							<div class="col-6 field brand">
								<label for="brand">Brand:</label> <input type="text" id="brand"
									name="brand" placeholder="Enter brand name..." required
									oninput="checkBrand()"> <span id="brandError"
									style="color: red; display: none;">Brand cannot be
									empty.</span>
							</div>

							<div class="col-6 field">
								<label for="gender">Gender:</label>
								<div class="product-form">
									<select name="gender" id="gender" required>
										<option value="-1">None</option>
										<option value="1">Male</option>
										<option value="0">Female</option>
									</select>
								</div>
							</div>

							<div class="col-6 field">
								<label for="releaseTime">Release Time:</label> <input
									type="number" name="releaseTime" id="reTime"
									placeholder="Enter release time..." required
									oninput="checkreleaseTime()"> <span
									id="releaseTimeError" style="color: red; display: none;">Release
									Time cannot be empty.</span>
							</div>

							<div class="col-6 field">
								<label for="productType">Product Type:</label> <input
									type="text" name="productType" id="proType"
									placeholder="Enter product type..." required
									oninput="checkproductType()"> <span
									id="productTypeError" style="color: red; display: none;">Product
									Type cannot be empty.</span>
							</div>

							<div class="col-6 field" style="position: relative;">
								<label for="material">Product Material:</label> <input
									type="text" name="material" id="material"
									placeholder="Enter material type..." required
									oninput="checkMaterial()"> <span id="materialError"
									style="color: red; display: none;">Material cannot be
									empty.</span>
							</div>
						</div>
					</div>
				</div>

				<div class="form-actions">
					<a href="admin/adminProducts.htm" class="btn cancel-btn">Cancel</a>
					<button class="btn save-btn">Save Product</button>
				</div>
			</form>
		</div>
	</main>
	<script>
		function previewImage() {
			// Lấy giá trị người dùng nhập vào ô Image Source
			var imagePath = document.getElementById('image').value;
			var imagePreview = document.getElementById('imagePreview');

			// Kiểm tra xem đường dẫn có hợp lệ không
			if (imagePath) {
				imagePreview.src = imagePath; // Cập nhật đường dẫn ảnh
				imagePreview.style.display = 'block'; // Hiển thị ảnh
			} else {
				imagePreview.style.display = 'none'; // Ẩn ảnh nếu không có đường dẫn
			}
		}
		function checkPrice() {
			const priceInput = document.getElementById('price');
			const priceError = document.getElementById('priceError');

			if (priceInput.value <= 0) {
				priceError.style.display = 'inline';
			} else {
				priceError.style.display = 'none';
			}
		}

		function checkName() {
			const nameInput = document.getElementById('name');
			const nameError = document.getElementById('nameError');

			if (nameInput.value.trim() === "") {
				nameError.style.display = 'inline';
			} else {
				nameError.style.display = 'none';
			}
		}
		function checkBrand() {
			const nameInput = document.getElementById('brand');
			const nameError = document.getElementById('brandError');

			if (nameInput.value.trim() === "") {
				nameError.style.display = 'inline';
			} else {
				nameError.style.display = 'none';
			}
		}
		function checkreleaseTime() {
			const nameInput = document.getElementById('reTime');
			const nameError = document.getElementById('releaseTimeError');

			if (nameInput.value.trim() === "") {
				nameError.style.display = 'inline';
			} else {
				nameError.style.display = 'none';
			}
		}
		function checkproductType() {
			const nameInput = document.getElementById('proType');
			const nameError = document.getElementById('productTypeError');

			if (nameInput.value.trim() === "") {
				nameError.style.display = 'inline';
			} else {
				nameError.style.display = 'none';
			}
		}
		function checkMaterial() {
			const nameInput = document.getElementById('material');
			const nameError = document.getElementById('materialError');

			if (nameInput.value.trim() === "") {
				nameError.style.display = 'inline';
			} else {
				nameError.style.display = 'none';
			}
		}
		document.getElementById('product-id').addEventListener('input', function() {
		    const productId = this.value;
		    const idError = document.getElementById('idError');

		    // Kiểm tra nếu ID trống hoặc không phải là chữ số
		    if (productId === '') {
		        idError.style.display = 'inline';
		        idError.textContent = 'Product ID cannot be empty.';
		    } else if (!/^\d+$/.test(productId)) {  // Kiểm tra nếu ID không phải là chữ số
		        idError.style.display = 'inline';
		        idError.textContent = 'Product ID must be numeric.';
		    } else {
		        // Gửi yêu cầu AJAX để kiểm tra Product ID tồn tại hay không
		        checkProductIdExists(productId);
		    }
		});

		function checkProductIdExists(productId) {
		    const idError = document.getElementById('idError');

		    // Gửi yêu cầu AJAX tới controller để kiểm tra Product ID
		    fetch('/checkProductIdExists', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/json'
		        },
		        body: JSON.stringify({ productId: productId })
		    })
		    .then(response => response.json())
		    .then(data => {
		        // Kiểm tra kết quả từ server
		        if (data.exists) {
		            idError.style.display = 'inline';
		            idError.textContent = 'Product ID already exists.';
		        } else {
		            idError.style.display = 'none';  // Ẩn thông báo lỗi nếu Product ID không tồn tại
		        }
		    })
		}

		function validateForm() {
			// Kiểm tra các điều kiện tổng quát khi nhấn nút Save
			checkPrice();
			checkName();
			const idError = document.getElementById('idError').style.display;
			const priceError = document.getElementById('priceError').style.display;
			const nameError = document.getElementById('nameError').style.display;
			const brandError = document.getElementById('brandError').style.display;
			const releaseTimeError = document.getElementById('releaseTimeError').style.display;
			const productTypeError = document.getElementById('productTypeError').style.display;
			const materialError = document.getElementById('materialError').style.display;
			// Ngăn form submit nếu có lỗi
			return !(idError === 'inline' || priceError === 'inline' || nameError === 'inline' || brandError === 'inline' || releaseTimeError === 'inline' || productTypeError === 'inline' || materialError === 'inline');
		}
	</script>
</body>


<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
<script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
</html>
