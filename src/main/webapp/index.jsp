<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png"
	href="https://d-themes.com/html/riode/images/icons/favicon.png">
<title>HardMode</title>
<base href="${pageContext.servletContext.contextPath}/">

<link href="<c:url value='/resources/home/dist/css/reset.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/home/dist/css/home.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/home/dist/css/owl.carousel.css' />"
	rel="stylesheet">
<link
	href="<c:url value='/resources/home/dist/css/owl.theme.default.css' />"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<%@include file="/WEB-INF/views/header.jsp"%>
	
	
	<!-- Main -->
	<main class="main">
      
		<!-- Slider -->
		<section class="slider">
			<div class="container">
				<div class="row">

					<!-- Item -->
					<div class="col-6 h-2 owl-carousel owl-theme">
						<div class="col-item">
							<div class="img">
								<img
									src="https://i.pinimg.com/236x/58/80/4d/58804dab17f3425416a8894351c8f2e3.jpg"
									alt="">

							</div>

							<div class="text-content">
								<h5>New Arrivals</h5>
								<h2>
									Biometric<br>Fingerprints<br>Padlock
								</h2>
								<a href="home/products.htm">SHOP NOW <i
									class="fa-solid fa-arrow-right"></i></a>

							</div>
						</div>

						<div class="col-item">
							<div class="img">
								<img
									src="https://d-themes.com/html/riode/images/demos/demo4/slides/2.jpg"
									alt="">

							</div>

							<div class="text-content">
								<h5>NEW COLLECTION</h5>
								<h2
									style="color: #222; font-size: 40px; line-height: 36px; margin-bottom: 30px; letter-spacing: -1.12px;">
									Fashionable<br>partner
								</h2>
								<a class="black" style="color: #222;" href="home/products.htm">SHOP NOW <i
									class="fa-solid fa-arrow-right"></i></a>
							</div>
						</div>
					</div>

					<!-- Item -->
					<div class="col-6 h-2">
						<div class="row">
							<a href="home/products.htm" class="col-6 h-1">
								<div class="img">
									<img
										src="https://images.unsplash.com/photo-1528543606781-2f6e6857f318?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzh8fHJ1bm5pbmd8ZW58MHx8MHx8fDA%3D"
										alt="">

								</div>
s
								<h5 class="title" style="color: lightyellow;">For Fitness</h5>
							</a> <a href="home/products.htm" class="col-6 h-1">
								<div class="img">
									<img
										src="https://d-themes.com/html/riode/images/demos/demo4/categories/2.jpg"
										alt="">

								</div>

								<h5 class="title">Brand Sale</h5>
							</a> <a href="home/products.htm" class="col-6 h-1">
								<div class="img">
									<img
										src=https://sc04.alicdn.com/kf/H54c0b5b77c8047fdb5f1402941ad7a05k/230335687/H54c0b5b77c8047fdb5f1402941ad7a05k.jpg
										alt="">

								</div>

								<h5 class="title white" style="color: Yellow">Top watches</h5>
							</a> <a href="home/products.htm" class="col-6 h-1">
								<div class="img">
									<img
										src="https://product.hstatic.net/1000308345/product/img_7469_5de48ff7060f49f7949adbf37f0729f4_master.jpg"
										alt="">

								</div>

								<h5 class="title" style="color: navy">Sneakers</h5>
							</a>
						</div>
					</div>

					<!-- Item -->
					<div class="col-6 h-1">
						<div class="img">
							<img
								src="	https://d-themes.com/html/riode/images/demos/demo4/categories/5.jpg"
								alt="">
						</div>

						<div class="text-content-1">
							<h5>Springwear Sale</h5>
							<p>
								Our vision is to supply the best <br>equipment & expertise
								within the arb <br>most importantly, to keep our <br>customers
								at the heart of all we do.
							</p>
						</div>
					</div>

					<!-- Item -->
					<a href="home/products.htm" class="col-3 h-1">
						<div class="img">
							<img
								src="	https://d-themes.com/html/riode/images/demos/demo4/categories/6.jpg"
								alt="">
						</div>

						<h5 class="title">For Kids</h5>
					</a>

					<!-- Item -->
					<div class="col-3 h-1">
						<div class="img">
							<img
								src="	https://d-themes.com/html/riode/images/demos/demo4/categories/7.jpg"
								alt="">
						</div>

						<div class="text-content-2">
							<h5>HEY!</h5>
							<p>
								Spend $60 and get FREE US <br> mainland delivery* <br>
								(Order under $60 only /$4.75)
							</p>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Show Products -->
		<section class="show-products">
			<div class="container">

				<!-- Title  -->
				<h4 class="title">
					New Arrivals <a href="home/products.htm" class="more hover-p-color">VIEW
						MORE <i class="fa-solid fa-arrow-right"></i>
					</a>
				</h4>

				<!-- List Product Show -->
				<div class="owl-carousel owl-theme">

					<!-- A product  -->
					<c:forEach var="p" items="${prods}" begin="10" end="15" step="1">
						<div class="col-4 product">
							<div class="product-image">
								<img
									src="${p.image }"
									alt="">

								<div class="new">NEW</div>

								<a href="home/detail/${p.idProduct}.htm" class="btn-view">VIEW DETAILS</a>
								<a
									href="cart/{idProduct}.htm" class="btn-add"> 
									<i class="fa-solid fa-bag-shopping">Test123</i>
								</a>
							</div>

							<div class="product-content">
								<a href="home/products.htm"
									class="product-category hover-p-color">${p.getProductCategory().nameCategory }</a>

								<h2>
									<a href="home/detail/${p.idProduct}.htm" class="product-name hover-p-color">${p.name }</a>
								</h2>

								<p class="product-price">$${p.price }</p>

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

		<!-- Categories section  -->
		<section class="category-section">
			<div class="container">
				<div class="row">
					<a href="home/products.htm" class="cat-gender col-4">
						<div class="col-item">
							<img
								src="https://d-themes.com/html/riode/images/demos/demo4/categories/8.jpg"
								alt="">

							<h3>Shop Men</h3>
						</div>
					</a>

					<div class="cat col-4">
						<div class="col-item">
							<div class="img">
								<img
									src="https://d-themes.com/html/riode/images/demos/demo4/categories/9.jpg"
									alt="">

							</div>

							<div class="content">
								<h2>Black Friday Sale</h2>
								<h3>UP TO 70% OFF</h3>
								<h4>EVERYTHING</h4>
								<a href="home/products.htm">SHOP NOW</a>
							</div>
						</div>
					</div>

					<a href="home/products.htm" class="cat-gender col-4">
						<div class="col-item">
							<img
								src="https://d-themes.com/html/riode/images/demos/demo4/categories/10.jpg"
								alt="">

							<h3>Shop Women</h3>
						</div>
					</a>
				</div>
			</div>
		</section>


		<section class="show-products" style="padding-bottom: 50px;">
			<div class="container">

				<!-- Title  -->
				<h4 class="title">
					Our Featured <a href="home/products.htm" class="more hover-p-color">VIEW
						MORE <i class="fa-solid fa-arrow-right"></i>
					</a>
				</h4>

				<!-- List Product Show -->
				<div class="owl-carousel owl-theme">

					<!-- A product  -->
					<c:forEach var="p" items="${prods}" begin="5" end="10" step="1">
						<div class="col-4 product">
							<div class="product-image">
								<img
									src="${p.image }"
									alt="">

								<div class="new">NEW</div>

								<a href="home/detail/${p.idProduct}.htm" class="btn-view">VIEW DETAILS</a> <a
									href="" class="btn-add"> <i
									class="fa-solid fa-bag-shopping"></i>
								</a>
							</div>

							<div class="product-content">
								<a href="" class="product-category hover-p-color">${p.getProductCategory().nameCategory }</a>

								<h2>
									<a href="home/detail/${p.idProduct}.htm" class="product-name hover-p-color">${p.name }</a>
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
	</main>

	<%@include file="/WEB-INF/views/footer.jsp"%>

</body>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
<script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
</html>
