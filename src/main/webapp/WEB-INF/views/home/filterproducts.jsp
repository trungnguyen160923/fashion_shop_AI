<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="https://d-themes.com/html/riode/images/icons/favicon.png">
    <title>Filter Products</title>
    <base href="${pageContext.servletContext.contextPath}/">

    <!-- External CSS files -->
    <link href="<c:url value='/resources/home/dist/css/reset.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/home.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/owl.carousel.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/owl.theme.default.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
</head>

<body>
    <%@ include file="/WEB-INF/views/header.jsp" %>

    <main class="main">
        <!-- Filter Section -->
        <section class="filter-section">
            <div class="container">
                <h2>Filter Products</h2>

                <!-- Filter Form -->
                <form action="${pageContext.request.contextPath}/home/filterproducts" method="get">

                    <!-- Search by keyword -->
                    <div class="filter-group">
                        <label for="keyword">Search:</label>
                        <input type="text" id="keyword" name="keyword" value="${keyword}" placeholder="Search products...">
                    </div>

                    <!-- Filter by Color -->
                    <div class="filter-group">
                        <label for="color">Color:</label>
                        <select name="color" id="color">
                            <option value="">Select Color</option>
                            <c:forEach var="color" items="${colorList}">
                                <option value="${color}" 
                                    <c:if test="${color == selectedColor}">selected</c:if>>${color}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Filter by Size -->
                    <div class="filter-group">
                        <label for="size">Size:</label>
                        <select name="size" id="size">
                            <option value="">Select Size</option>
                            <c:forEach var="size" items="${sizeList}">
                                <option value="${size}" 
                                    <c:if test="${size == selectedSize}">selected</c:if>>${size}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Apply Filter Button -->
                    <div class="filter-group">
                        <button type="submit" class="btn-filter">Apply Filter</button>
                    </div>
                </form>
            </div>
        </section>

        <!-- Product Results -->
        <section class="search-results">
            <div class="container">
                <h1>Search Results for: "${keyword}"</h1>

                <!-- No products found -->
                <c:if test="${empty products}">
                    <p>No products found for your search.</p>
                </c:if>

                <!-- Show products -->
                <c:if test="${not empty products}">
                    <div class="row">
                        <c:forEach var="p" items="${products}">
                            <div class="col-4 product">
                                <div class="product-image">
                                    <img src="${p.image}" alt="${p.name}">
                                    <div class="new">NEW</div>
                                    <a href="home/detail/${p.idProduct}.htm" class="btn-view">VIEW DETAILS</a>
                                    <a href="#" class="btn-add">
                                        <i class="fa-solid fa-bag-shopping"></i>
                                    </a>
                                </div>

                                <div class="product-content">
                                    <a href="home/products/${p.productCategory.idCategory}.htm"
                                        class="product-category">${p.productCategory.name}</a>
                                    <h2>
                                        <a href="home/detail/${p.idProduct}.htm" class="product-name">${p.name}</a>
                                    </h2>
                                    <p class="product-price">$${p.price}</p>
                                    <div class="review">
                                        <ul class="list-stars">
                                            <li class="active"><i class="fa-solid fa-star"></i></li>
                                            <li class="active"><i class="fa-solid fa-star"></i></li>
                                            <li class="active"><i class="fa-solid fa-star"></i></li>
                                            <li><i class="fa-solid fa-star"></i></li>
                                            <li><i class="fa-solid fa-star"></i></li>
                                        </ul>
                                        (6 Reviews)
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </section>
    </main>

    <%@ include file="/WEB-INF/views/footer.jsp" %>

    <!-- External JS files -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
    <script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
</body>

</html>
