<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- <!DOCTYPE html> -->
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Riode - Show products</title>
    <base href="${pageContext.servletContext.contextPath}/">

	<link rel="icon" type="image/png"
	href="https://d-themes.com/html/riode/images/icons/favicon.png">
    <link href="<c:url value='/resources/home/dist/css/reset.css' />"
	rel="stylesheet">
	<link href="<c:url value='/resources/home/dist/css/detail.css' />" rel="stylesheet">
	<link href="<c:url value='/resources/home/dist/css/owl.carousel.css' />" rel="stylesheet">
	<link href="<c:url value='/resources/home/dist/css/owl.theme.default.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style type="text/css">
		.radio-inputs {
		  position: relative;
		  display: flex;
		  flex-wrap: wrap;
		  border-radius: 0.5rem;
		  background-color: #EEE;
		  box-sizing: border-box;
		  box-shadow: 0 0 0px 1px rgba(0, 0, 0, 0.06);
		  padding: 0.25rem;
		  width: 300px;
		  font-size: 14px;
		}
		
		.radio-inputs .radio {
		  flex: 1 1 auto;
		  text-align: center;
		}
		
		.radio-inputs .radio input {
		  display: none;
		}
		
		.radio-inputs .radio .name {
		  display: flex;
		  cursor: pointer;
		  align-items: center;
		  justify-content: center;
		  border-radius: 0.5rem;
		  border: none;
		  padding: .5rem 0;
		  color: rgba(51, 65, 85, 1);
		  transition: all .15s ease-in-out;
		}
		
		.radio-inputs .radio input:checked + .name {
		  background-color: #fff;
		  font-weight: 600;
		}
		
		button {
		  padding: 13.5px 60px;
		  border: 0;
		  border-radius: 100px;
		  background-color: #2ba8fb;
		  color: #ffffff;
		  font-size: 15px;
		  font-weight: Bold;
		  transition: all 0.5s;
		  -webkit-transition: all 0.5s;
		}
		
		button:hover {
		  background-color: #6fc5ff;
		  box-shadow: 0 0 20px #6fc5ff50;
		  transform: scale(1.1);
		}
		
		button:active {
		  background-color: #3d94cf;
		  transition: all 0.25s;
		  -webkit-transition: all 0.25s;
		  box-shadow: none;
		  transform: scale(0.98);
		}
		button:disabled {
		    background-color: #cccccc; /* Màu xám */
		    color: #666666; /* Màu chữ xám nhạt */
		    cursor: not-allowed; /* Hiển thị con trỏ không được phép */
		    box-shadow: none; /* Bỏ hiệu ứng bóng */
		    transform: none; /* Không thay đổi kích thước */
		}
		.mt{
			margin-top: 30px;
		}
		.mr{
			margin-right: 15px;
		}
    	.large-input {
		    width: 150px; /* Tăng chiều rộng */
		    height: 35px; /* Tăng chiều cao */
		    font-size: 18px; /* Tăng kích thước chữ */
		    padding: 10px; /* Thêm khoảng cách bên trong */
		    border: 2px solid #ccc; /* Viền */
		    border-radius: 5px; /* Bo góc */
		}
		.red{
			color: red;
		}
    </style>
</head>
<body>
     
     
     <%@include file="/WEB-INF/views/header.jsp"%>
     

    <main class="main">
        <div class="container">
            <div class="product">
                
                
                
            </div>

            <div class="desc">
                <h2 class="title">${product.name }</h2>

                <div class="row desc-main">
                    <div class="col-6 features">
                        <h5 class="desc-title">Features</h5>
                        <p>Praesent id enim sit amet.Tdio vulputate eleifend in in tortor. ellus massa. siti iMassa ristique sit amet condim vel, facilisis quimequistiqutiqu amet condim Dilisis Facilisis quis sapien. Praesent id enim sit amet.</p>
                        <ul>
                            <li><i class="fa-solid fa-check"></i>Praesent id enim sit amet.Tdio vulputate</li>
                            <li><i class="fa-solid fa-check"></i>Eleifend in in tortor. ellus massa.Dristique sitii</li>
                            <li><i class="fa-solid fa-check"></i>Massa ristique sit amet condim vel</li>
                            <li><i class="fa-solid fa-check"></i>Dilisis Facilisis quis sapien. Praesent id enim sit amet</li>
                        </ul>

                        <h5 class="desc-title">Specifications</h5>
                        <table>
                            <tr>
                                <th>Price</th>
                                <td>${product.price }</td>

                            </tr>
                            <tr>
                                <th>Brand</th>
                                <td>${product.brand }</td>

                            </tr>
                            <tr>
                                <th>Gender</th>
                                <c:if test="${p.gender }"><td>Male</td></c:if>
								<c:if test="${!p.gender }"><td>Female</td></c:if>
                            </tr>
                            <tr>
                                <th>Release time</th>
                                <td>${product.releaseTime }</td>

                            </tr>
                            <tr>
                                <th>Material</th>
                                <td>${product.material }</td>

                            </tr>
                        </table>
                    </div>

                    <div class="col-6 video-desc">
                        <h5 class="desc-title">Image</h5>

                        <div class="video">
                            <img src="${product.image }" alt="">
                        </div>

                        <div class="row benefits">
                            <div class="col-6 icon-box">
                                <div class="icon-box-icon">
                                    <i class="fa-solid fa-lock"></i>
                                </div>

                                <div class="icon-box-content">
                                    <h4>2 year warranty</h4>
                                    <p>Guarantee with no doubt</p>
                                </div>
                            </div>

                            <div class="col-6 icon-box">
                                <div class="icon-box-icon">
                                    <i class="fa-solid fa-truck-fast"></i>
                                </div>

                                <div class="icon-box-content">
                                    <h4>free shipping</h4>
                                    <p>On orders over $50.00</p>
                                </div>
                            </div>
                        </div>
                       	<c:choose>
						    <c:when test="${empty product.sizeAndColors}">
						        <p class="out-of-stock mt red">The product is out of stock</p>
						    </c:when>
						    <c:otherwise>
								<form action="cart/addToCart/${product.idProduct}.htm" method="post">
								    <div class="product-options mt">
								        <label class="mt">Choose color:</label>
								        <div class="color-options">
										    <div class="radio-inputs">
										        <c:forEach var="sizeAndColor" items="${product.sizeAndColors}">
										            <label class="radio">
										                <input type="radio" name="color" value="${sizeAndColor.pk.color}">
										                <span class="name">${sizeAndColor.pk.color}</span>
										            </label>
										        </c:forEach>
										    </div>
										</div>
										<div class="mt"></div>
								        <label class="mt">Choose size:</label>
								        <div class="size-options">
										    <div class="radio-inputs">
										        <c:forEach var="sizeAndColor" items="${product.sizeAndColors}">
										            <label class="radio">
										                <input type="radio" name="size" value="${sizeAndColor.pk.size}">
										                <span class="name">${sizeAndColor.pk.size}</span>
										            </label>
										        </c:forEach>
										    </div>
										</div>
										<div class="row mt">
											<div class="col-6">
												<label class="mr" for="quantity">Quantity:</label>
								        		<input type="number" id="quantity" name="quantity" min="1" value="1" required class="large-input">
											</div>
											
								        	<div class="col-6">
								        		<p class="mr">(${product.sizeAndColors[0].quantity} products available)</p>
								        	</div>
								        	
										</div>
								        
								        <div class="action-buttons mt">
										    <button type="submit" class="mr" id="addToCartBtn" disabled>
										        Add to cart
										    </button>
										    <button type="button" id="buyNowBtn" class="mr" disabled>
										        Buy now
										    </button>
										</div>
								    </div>
								</form>

						    </c:otherwise>
						</c:choose>
                    </div>
                </div>
            </div>
            
            <section class="show-products" style="padding-bottom: 50px;">
                <div class="container">
    
                    <h4 class="title">
                        Related Products
                        <a href="home/products.htm" class="more hover-p-color">VIEW MORE <i class="fa-solid fa-arrow-right"></i></a>
                    </h4>
                    <label for="sort-type">Order: </label>
					<select id="sort-type">
						<option value=""></option>
						<option value="asc">Ascending by price</option>
						<option value="dsc">Descending by price</option>
					</select>
                    <div class="owl-carousel owl-theme">
					<c:forEach var="p" items="${relatedProducts}" begin="0" end="7" step="1">
						<div class="col-4 product">
							<div class="product-image">
								<img
									src="${p.image }"
									alt="">

								<div class="new">NEW</div>

								<a href="home/detail/${p.idProduct}.htm?history=${history.id }" class="btn-view">VIEW DETAILS</a> <a
									href="" class="btn-add"> <i
									class="fa-solid fa-bag-shopping"></i>
								</a>
							</div>

							<div class="product-content">
								<a href="" class="product-category hover-p-color">${p.getProductCategory().nameCategory }</a>

								<h2>
									<a href="home/detail/${p.idProduct}.htm?history=${history.id }" class="product-name hover-p-color">${p.name }</a>
								</h2>

								<p class="product-price">${p.price }</p>

								<div class="review">
									<ul class="list-stars">
										<li class="active"><i class="fa-solid fa-star"></i></li>
										<li class="active"><i class="fa-solid fa-star"></i></li>
										<li class="active"><i class="fa-solid fa-star"></i></li>
										<li><i class="fa-solid fa-star"></i></li>
										<li><i class="fa-solid fa-star"></i></li>
									</ul>

									( 6 Reviews )
								</div>
							</div>
						</div>
					</c:forEach>
     
    
                        
                       
                    </div>
                </div>
            </section>
        </div>
    </main>

     <%@include file="/WEB-INF/views/footer.jsp"%>

</body>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
    <script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
    <script type="text/javascript">
		$('#sort-type')
				.change(
						function() {
							const sortValue = $(this).val();
							var list = document.querySelector('.owl-stage')
							var nodesToSort = list
									.querySelectorAll('.owl-item');
							if (sortValue === 'asc') {
								Array.prototype.map
										.call(
												nodesToSort,
												function(node) {
													return {
														node : node,
														relevantText : parseFloat(node
																.querySelector('.product-price').textContent)
													};
												}).sort(
												function(a, b) {
													return a.relevantText
															- b.relevantText;
												}).forEach(function(item) {
											list.appendChild(item.node);
										});
							} else if (sortValue === 'dsc') {
								Array.prototype.map
										.call(
												nodesToSort,
												function(node) {
													return {
														node : node,
														relevantText : parseFloat(node
																.querySelector('.product-price').textContent)
													};
												}).sort(
												function(a, b) {
													return b.relevantText
															- a.relevantText;
												}).forEach(function(item) {
											list.appendChild(item.node);
										});
							}
						})
	document.addEventListener('DOMContentLoaded', () => {
	    const colorInputs = document.querySelectorAll('input[name="color"]');
	    const sizeInputs = document.querySelectorAll('input[name="size"]');
	    const quantityInput = document.getElementById('quantity');
	    const addToCartBtn = document.getElementById('addToCartBtn');
	    const buyNowBtn = document.getElementById('buyNowBtn');
	
	    const updateButtonState = () => {
	        const isColorSelected = Array.from(colorInputs).some(input => input.checked);
	        const isSizeSelected = Array.from(sizeInputs).some(input => input.checked);
	        const isQuantityValid = quantityInput.value > 0;
	
	        // Cập nhật trạng thái của các nút dựa trên điều kiện
	        const isFormValid = isColorSelected && isSizeSelected && isQuantityValid;
	        addToCartBtn.disabled = !isFormValid;
	        buyNowBtn.disabled = !isFormValid;
	    };
	
	    // Gắn sự kiện cho các trường nhập liệu
	    colorInputs.forEach(input => input.addEventListener('change', updateButtonState));
	    sizeInputs.forEach(input => input.addEventListener('change', updateButtonState));
	    quantityInput.addEventListener('input', updateButtonState);
	
	    // Cập nhật trạng thái nút khi trang được tải
	    updateButtonState();
	});
	</script>
</html>
