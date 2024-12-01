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
    <title>Riode - History Order</title>
    <base href="${pageContext.servletContext.contextPath}/">
    <link rel="icon" type="image/png" href="https://d-themes.com/html/riode/images/icons/favicon.png">

    <link href="<c:url value='/resources/home/dist/css/reset.css' />" rel="stylesheet">
	<link href="<c:url value='/resources/home/dist/css/checkOut.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<style type="text/css">
		.button-group {
		  flex-grow: 1;
		  margin: auto;
		}
		
		.button-group input[type="radio"] {
		  display: none;
		}
		
		.button-group label {
		  display: inline-block;
		  padding: 8px 8px;
		  cursor: pointer;
		  border: 1px solid #2b426d;
		  background-color: #385c7e;
		  color: white;
		  border-radius: 15px;
		  transition: all ease 0.2s;
		  text-align: center;
		  flex-grow: 1;
		  flex-basis: 0;
		  width: 90px;
		  font-size: 13px;
		  margin: 5px;
		  box-shadow: 0px 0px 50px -15px #000000;
		}
		
		.button-group input[type="radio"]:checked + label {
		  background-color: white;
		  color: #02375a;
		  border: 1px solid #2b426d;
		}
		
		fieldset {
		  border: 0;
		  display: flex;
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
		
	
	</style>
</head>
<body>
     <%@include file="/WEB-INF/views/header.jsp"%>

    <!-- Main -->
    <main class="main">

        <!-- Map  -->
        <div class = "container">
        
        <div class="">
            <div class="header-left">
                <h2>Purchase Order</h2>

                <div class="map mt">
                    <a href="home/index.htm">Home</a>
                    /
                    <a href="user/userHome.htm">User</a>
                    /
                    <a href="home/purchaseOrder.htm">Purchase Order</a>
                </div>
            </div>
        </div>
        </div>
		<div class="container mt">
	     <div class="row">
	     	<fieldset>
			    <div class="button-group">
			        <input type="radio" id="confirming" name="frameworks" onclick="filterOrders(0)" 
			            ${currentStatus == 0 ? 'checked="checked"' : ''} />
			        <label for="confirming"">Confirming</label>
			    </div>
			    <div class="button-group">
			        <input type="radio" id="preparing" name="frameworks" onclick="filterOrders(1)" 
			            ${currentStatus == 1 ? 'checked="checked"' : ''} />
			        <label for="preparing">Preparing</label>
			    </div>
			    <div class="button-group">
			        <input type="radio" id="delivering" name="frameworks" onclick="filterOrders(2)" 
			            ${currentStatus == 2 ? 'checked="checked"' : ''} />
			        <label for="delivering">Delivering</label>
			    </div>
			    <div class="button-group">
			        <input type="radio" id="completed" name="frameworks" onclick="filterOrders(3)" 
			            ${currentStatus == 3 ? 'checked="checked"' : ''} />
			        <label for="completed">Completed</label>
			    </div>
			    <div class="button-group">
			        <input type="radio" id="rating" name="frameworks" onclick="filterOrders(4)" 
			            ${currentStatus == 4 ? 'checked="checked"' : ''} />
			        <label for="rating">Rating</label>
			    </div>
			    <div class="button-group">
			        <input type="radio" id="canceled" name="frameworks" onclick="filterOrders(-1)" 
			            ${currentStatus == -1 ? 'checked="checked"' : ''} />
			        <label for="canceled">Canceled</label>
			    </div>
			</fieldset>

	     </div>
		</div>
        <!-- Main talbe data  -->
        <div class="container main-content mt">
        	
            <div class="table-container" id="ordersTable">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Date</th>
                        <th>Address</th>
                        <th>Total Price</th>
                        <th>View Detail</th>
                    </tr>
    
                    <div class="scroll">
                        <c:forEach var="od" items="${orders}" varStatus="status">
                        <tr>
                            <td>${od.id_order }</td>
                            <td>${od.order_date }</td>
                            <td>${od.cusAddress}</td>
                            <td>$${od.totalPrice }</td>
                            <td><a href="user/purchaseOrder/${od.id_order}.htm" class="icon"><i class="fa-solid fa-info"></i></a></td>
                        </tr>
                        </c:forEach>
                    </div>
                </table>
            </div>


        </div>
    </main>

  <!-- FOOTER -->
    <%@include file="/WEB-INF/views/footer.jsp"%>

</body>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
	<script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
	<script type="text/javascript">
	function filterOrders(status) {
		console.log("status"+ status);
	    $.ajax({
	        url: 'user/purchaseOrder.htm',
	        type: 'GET',
	        data: { status: status },
	        success: function(response) {
	            // Lấy nội dung bảng từ phản hồi
	            const updatedTable = $(response).find('#ordersTable').html();
	            $('#ordersTable').html(updatedTable);

	        },
	        error: function(xhr, status, error) {
	            console.error('Failed to fetch orders:', error);
	        }
	    });
	}


	</script>
</html>