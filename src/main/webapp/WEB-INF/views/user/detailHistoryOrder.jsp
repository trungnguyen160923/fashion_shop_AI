<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Riode - Purchase Detail</title>
    <base href="${pageContext.servletContext.contextPath}/">
    <link rel="icon" type="image/png" href="https://d-themes.com/html/riode/images/icons/favicon.png">

    <link href="<c:url value='/resources/home/dist/css/reset.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/checkOut.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<style type="text/css">
		.button {
		  justify-content: center;
		  align-items: center;
		  padding: 20px 50px;
		  gap: 15px;
		  background-color: #007ACC;
		  outline: 3px #007ACC solid;
		  outline-offset: -3px;
		  border-radius: 5px;
		  border: none;
		  cursor: pointer;
		  transition: 400ms;
		  font-size: 15px;
		}
		.btnRed{
			background-color: red;
			outline: 3px red solid;
			font-size: 15px;
		}
		
		.button .text {
		  color: white;
		  font-weight: 700;
		  font-size: 1em;
		  transition: 400ms;
		}
		
		.button:hover {
		  background-color: transparent;
		}
		
		.button:hover .text {
		  color: #007ACC;
		}
		
		.btnRed:hover .text {
		  color: red;
		}
		.red{
			color: red;
		}
		.mt{
			margin-top: 20px;
		}
		.main-content .table-container {
		  width: 100%;
		  height: 520px;
		  overflow: auto;
		}
		
		.main-content .table-container table {
		  width: 100%;
		  border-collapse: collapse;
		}
		
		.main-content .table-container table th {
		  border-right: 1px solid;
		  background-color: #3498db;
		  color: white;
		}
		
		.main-content .table-container table tr {
		  border-bottom: 1px solid #ccc;
		}
		
		.main-content .table-container table th,
		.main-content .table-container table td {
		  text-align: center;
		  padding: 8px 20px;
		}
		
		.main-content .table-container table th img,
		.main-content .table-container table td img {
		  width: 120px;
		}
		
		.main-content .table-container table a {
		  font-size: 20px;
		}
		
		.main-content .table-container table a:hover {
		  opacity: 0.9;
		}
		
		.main-content .table-container table .icon {
		  display: block;
		  color: #333;
		  font-size: 24px;
		}
		
		.main-content .table-container table .icon:hover {
		  color: #1e90ff;
		}
		.main .bill-data {
		  margin-bottom: 20px;
		  display: -webkit-box;
		  display: -ms-flexbox;
		  display: flex;
		  -ms-flex-pack: distribute;
		      justify-content: space-around;
		  width: 100%;
		}
		
		.main .bill-data label {
		  font-size: 14px;
		  color: #666;
		  text-transform: uppercase;
		}
		
		.main .bill-data .value {
		  font-size: 18px;
		  font-weight: 600;
		  color: #333;
		}
		.header-right {
		    display: flex;
		    justify-content: flex-end; /* Đẩy nội dung sang phải */
		    align-items: center; /* Căn giữa theo chiều dọc */
		}
		
		.row.justify-end {
		    display: flex;
		    justify-content: flex-end; /* Đẩy các nút sang phải */
		}
		/* From Uiverse.io by andrew-demchenk0 */ 
	.rating:not(:checked) > input {
	  position: absolute;
	  appearance: none;
	}
	
	.rating:not(:checked) > label {
	  float: right;
	  cursor: pointer;
	  font-size: 30px;
	  color: #666;
	}
	
	.rating:not(:checked) > label:before {
	  content: '★';
	}
	
	.rating > input:checked + label:hover,
	.rating > input:checked + label:hover ~ label,
	.rating > input:checked ~ label:hover,
	.rating > input:checked ~ label:hover ~ label,
	.rating > label:hover ~ input:checked ~ label {
	  color: #e58e09;
	}
	
	.rating:not(:checked) > label:hover,
	.rating:not(:checked) > label:hover ~ label {
	  color: #ff9e0b;
	}
	
	.rating > input:checked ~ label {
	  color: #ffa723;
	}



		
	
	</style>
</head>
<body>
    
	<%@include file="/WEB-INF/views/header.jsp"%>
    <!-- Main -->
    <main class="main">

        <!-- Map  -->
        <div class="container main-header">
            <div class="row">
            	<div class="col-6 header-left">
	                <h2>Order Details</h2>
	
	                <div class="map mt">
	                    <a href="home/index.htm">Home</a>
	                    /
	                    <a href="user/purchaseOrder.htm">Purchase Order</a>
	                    /
	                    <a href="user/purchaseOrder/${order.id_order}.htm">Detail</a>
	                </div>
            	</div>

            	<div class="col-6 header-right">
				    <c:choose>
				        <c:when test="${order.status == 0}">
				            <!-- Trạng thái 0: Đơn hàng đang chờ duyệt -->
				            <form action="user/handleOrder.htm" method="POST">
				                <input type="hidden" name="orderId" value="${order.id_order}" />
				                <div class="row justify-end">
				                    <button class="button btnRed" type="submit" name="action" value="cancelOrder">
				                        <p class="text">Cancel Order</p>
				                    </button>
				                </div>
				            </form>
				        </c:when>
				        <c:when test="${order.status == 3}">
				            <!-- Trạng thái 3: Đơn hàng đang chờ đánh giá -->
				            <form action="user/rating.htm" method="POST">
				                <input type="hidden" name="orderId" value="${order.id_order}" />
				                <div class="row justify-end">
				                    <button class="button" type="submit" name="action" value="cancelOrder">
				                        <p class="text">Rate Product</p>
				                    </button>
				                </div>
				            </form>
				        </c:when>
				    </c:choose>
				</div>

            </div>
        </div>

        <div class="bill-data mt">
            <div class="data">
                <label for="">ID</label>
                <p class="value">${order.id_order }</p>
            </div>

            <div class="data">
                <label for="">Date</label>
                <p class="value">${order.order_date }</p>
            </div>

            <div class="data">
                <label for="">Username</label>
                <p class="value">${accUser.fullname }</p>
            </div>

            <div class="data">
                <label for="">Total Price</label>
                <p class="value">$${order.totalPrice }</p>
            </div>
           
        </div>

        <!-- Main talbe data  -->
        <div class="container main-content mt">
            <div class="table-container">
                <table>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <td>Rating</td>
                    </tr>
    
                    <div class="scroll"></div>
                    	<c:forEach var="dt" items="${order.details}" varStatus="status">
                        <tr>
                            <td>${dt.prod.idProduct}</td>
                            <td>${dt.prod.name }</td>
                            <td>$${dt.prod.price}</td>
                            <td>${dt.quantity}</td>
                            <td>
                            	 <div class="rating">
									  <input value="5" name="rate" id="star5" type="radio">
									  <label title="text" for="star5"></label>
									  <input value="4" name="rate" id="star4" type="radio">
									  <label title="text" for="star4"></label>
									  <input value="3" name="rate" id="star3" type="radio">
									  <label title="text" for="star3"></label>
									  <input value="2" name="rate" id="star2" type="radio">
									  <label title="text" for="star2"></label>
									  <input value="1" name="rate" id="star1" type="radio">
									  <label title="text" for="star1"></label>
								</div>
                            </td>
                        </tr>
                        </c:forEach>
                    </div>
                   
                </table>
            </div>

        </div>
        
        
    </main>
	<%@include file="/WEB-INF/views/footer.jsp"%>
  

</body>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
	<script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
</html>