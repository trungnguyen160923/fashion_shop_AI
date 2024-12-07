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
    <link rel="icon" type="image/png" href="https://d-themes.com/html/riode/images/icons/favicon.png">
    <title>HardMode - Order Complete</title>
    <base href="${pageContext.servletContext.contextPath}/">

    <link href="<c:url value='/resources/home/dist/css/reset.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/orderComplete.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>
     
    <!-- Header -->
     
   <%@include file="/WEB-INF/views/header.jsp"%>

    <!-- Main -->
    <main class="main">
        <div class="page-content">
            <div class="step-by">
                <h3 class="title-step  ">1. SHOPPING CART</h3>
                <i class="fa-solid fa-angle-right"></i>
                <h3 class="title-step ">2. CHECKOUT</h3>
                <i class="fa-solid fa-angle-right"></i>
                <h3 class="title-step active">3. ORDER COMPLETE</h3>

            </div>

            <div class="container">
                <div class="order-message">
                    <div class="icon">
                        <i class="fa-solid fa-circle-check"></i>
                    </div>
                    <div class="message">
                        <h4>THANK YOU!</h4>
                        <p>Your order has been received</p>
                    </div>
                </div>
                <div class="order-results">
                    <div class="overview-item">
                        <div class="overview-name">
                            ORDER NUMBER:
                        </div>
                        <div class="overview-value">
                            ${order.id_order}
                        </div>
                    </div>
                    
                   

                    <div class="overview-item">
                        <div class="overview-name">
                            STATUS:
                        </div>
                        <div class="overview-value">
                            Waiting for confirmation
                        </div>
                    </div>

                    <div class="overview-item">
                        <div class="overview-name">
                            DATE:
                        </div>
                        <div class="overview-value">
                            ${order.order_date}
                        </div>
                    </div>

                    <div class="overview-item">
                        <div class="overview-name">
                            EMAIL:
                        </div>
                        <div class="overview-value">
                            ${order.cusEmail }
                        </div>
                    </div>

                    <div class="overview-item">
                        <div class="overview-name">
                            TOTAL:
                        </div>
                        <div class="overview-value">
                            ${order.totalPrice}
                        </div>
                    </div>

                    <div class="overview-item">
                        <div class="overview-name">
                            PAYMENT METHOD:
                        </div>
                        <div class="overview-value">
                            ${paymentMethod}
                        </div>
                    </div>
                </div>
                <div class="title">ORDER DETAILS</div>
                <div class="order-details">
                    <table>
                        <tr class="table-cat">
                            <th class="table-title">Product</th>
                            <td></td>
                        </tr>
						<c:forEach var="dt" items="${order.details}">
                        <tr class="prod">
                            <td>
                                ${dt.prod.name } x <span class="quantity">${dt.quantity}</span>
                            </td>

                            <td>${dt.price }</td>
                        </tr>
                        </c:forEach>
                        <tr class="table-cat">
                            <td class="table-title">Subtotal:</td>
                            <td class="table-value">${order.totalPrice - shippingValue}</td>
                        </tr>

                        <tr class="table-cat">
                            <td class="table-title">Shipping:</td>
                            <td class="table-value">${shippingMethod}</td>
                        </tr>

                        <tr class="table-cat">
                            <td class="table-title">Payment method:</td>
                            <td class="table-value">${paymentMethod}</td>
                        </tr>

                        <tr class="table-cat">
                            <td class="table-title">Total:</td>
                            <td class="table-value bold">${order.totalPrice}</td>
                        </tr>
                    </table>
                </div>
                <div class="title" style="margin-top: 50px;">Billing Address</div>
                <div class="order-info">
                    <ul>
                        <li>${acc.fullname }</li>
                        <li>${order.cusAddress }</li>
                        <li>${order.phone }</li>
                        <li>${order.cusEmail}</li>
                      
                    </ul>
                </div>

                <a href="home/index.htm" class="btn-back-home">Back To Home</a>
            </div>
        </div>
    </main>


    <!-- Footer  -->
    <%@include file="/WEB-INF/views/footer.jsp"%>

</body>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
    <script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
</html>