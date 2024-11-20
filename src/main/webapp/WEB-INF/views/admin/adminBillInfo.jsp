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
    <link rel="icon" type="image/png" href="https://d-themes.com/html/riode/images/icons/favicon.png">

    <link href="<c:url value='/resources/home/dist/css/reset.css' />" rel="stylesheet">
	<link href="<c:url value='/resources/home/dist/css/adminAccount.css' />" rel="stylesheet">
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
		}
		.btnRed{
			background-color: red;
			outline: 3px red solid;
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
	
	</style>
</head>
<body>
    
    <aside class="aside">
        <a href="admin/adminHome.htm" class="admin">
            <div class="logo">
                <i class="fa-solid fa-a"></i>
            </div>
            Admin
        </a>

        <ul class="functions">
            <li class="function">
                <a href="admin/adminAccount.htm">
                    <div class="icon">
                        <i class="fa-solid fa-users"></i>
                    </div>
                    Account 
                </a>
            </li>

            <li class="function">
                <a href="admin/adminBill.htm"  class="active">
                    <div class="icon">
                        <i class="fa-solid fa-receipt"></i>

                    </div>
                    Bill 
                </a>
            </li>

            <li class="function">
                <a href="admin/adminProducts.htm">
                    <div class="icon">
                        <i class="fa-solid fa-shirt"></i>
                    </div>
                    Products 
                </a>
            </li>

            
        </ul>

        <button class="btn-log-out"><a href="user/logout.htm">Log out</a></button>
    </aside>

    <!-- Main -->
    <main class="main">

        <!-- Map  -->
        <div class="main-header">
            <div class="header-left">
                <h2>Bill Details</h2>

                <div class="map">
                    <a href="home/index.htm">Home</a>
                    /
                    <a href="admin/adminHome.htm">Admin</a>
                    /
                    <a href="admin/adminBill.htm">Bill </a>
                </div>
            </div>

            <div class="header-right">
                
            </div>
        </div>

        <div class="bill-data">
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
        <div class="main-content">
            <div class="table-container">
                <table>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                    </tr>
    
                    <div class="scroll"></div>
                    	<c:forEach var="dt" items="${order.details}" varStatus="status">
                        <tr>
                            <td>${dt.prod.idProduct}</td>
                            <td>${dt.prod.name }</td>
                            <td>$${dt.prod.price}</td>
                            <td>${dt.quantity}</td>
                        </tr>
                        </c:forEach>
                    </div>
                   
                </table>
            </div>
			<div class="status-actions">
        <c:choose>
            <c:when test="${order.status == 0}">
                <!-- Trạng thái 0: Đơn hàng đang chờ duyệt -->
                <form action="admin/handleOrder.htm" method="POST">
                    <input type="hidden" name="orderId" value="${order.id_order}" />
                    <div class = "row">
                    	<div class = "col-8"></div>
                    	<div class = "col-4">
                    		<button class="button btnRed" type="submit" name="action" value="reject">
	                    		<p class="text">Reject</p>
	                    	</button>
                    		<button class="button" type="submit" name="action" value="approve">
  								<p class="text">Browse order</p>
							</button>
                    	</div>
                    </div>
                </form>
            </c:when>

            <c:when test="${order.status == 1}">
                <!-- Trạng thái 1: Đơn hàng đang chuẩn bị -->
                <form action="admin/handleOrder.htm" method="POST">
                    <input type="hidden" name="orderId" value="${order.id_order}" />
                    <div class = "row">
                    	<div class = "col-8"></div>
                    	<div class = "col-4">
                    		<button class="button" type="submit" name="action" value="prepare_done">
  								<p class="text">Prepared</p>
							</button>
                    	</div>
                    </div>
                </form>
            </c:when>

            <c:when test="${order.status == 2}">
                <!-- Trạng thái 2: Đơn hàng đang giao -->
                <form action="admin/handleOrder.htm" method="POST">
                    <input type="hidden" name="orderId" value="${order.id_order}" />
                    <div class = "row">
                    	<div class = "col-8"></div>
                    	<div class = "col-4">
                    		<button class="button" type="submit" name="action" value="delivered">
  								<p class="text">Delivered</p>
							</button>
                    	</div>
                    </div>
                </form>
            </c:when>

            <c:when test="${order.status == 3}">
                <!-- Trạng thái 3: Đơn hàng đã hoàn thành -->
                <p>Order has been completed</p>
            </c:when>

            <c:when test="${order.status == -1}">
                <!-- Trạng thái -1: Đơn hàng đã bị huỷ -->
                <p class="red">Order has been cancelled</p>
            </c:when>
        	</c:choose>
    	</div>

        </div>
        
    </main>

  

</body>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
	<script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
</html>