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
                <h2>Bill Report</h2>

                <div class="map">
                    <a href="home/index.htm">Home</a>
                    /
                    <a href="admin/adminHome.htm">Admin</a>
                    /
                    <a href="admin/adminBill.htm">Bill</a>
                </div>
            </div>

            <div class="header-right">
                <div class="date">
                    <label for="">Date From</label>
                    <input type="date">
                </div>

                <div class="date">
                    <label for="">Date To</label>
                    <input type="date">
                </div>

                <button class="btn-filter">Filter <i class="fa-solid fa-filter"></i></button>
            </div>
        </div>
		<div class="container">
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
			        <input type="radio" id="canceled" name="frameworks" onclick="filterOrders(-1)" 
			            ${currentStatus == -1 ? 'checked="checked"' : ''} />
			        <label for="canceled">Canceled</label>
			    </div>
			</fieldset>

	     </div>
		</div>
        <!-- Main talbe data  -->
        <div class="main-content mt">
        	
            <div class="table-container" id="ordersTable">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Date</th>
                        <th>Username</th>
                        <th>Total Price</th>
                        <th>View More</th>
                    </tr>
    
                    <div class="scroll">
                        <c:forEach var="od" items="${orders}" varStatus="status">
                        <tr>
                            <td>${od.id_order }</td>
                            <td>${od.order_date }</td>
                            <td>${names[status.index]}</td>
                            <td>$${od.totalPrice }</td>
                            <td><a href="admin/adminBillInfo/${od.id_order}.htm" class="icon"><i class="fa-solid fa-info"></i></a></td>
                        </tr>
                        </c:forEach>
                    </div>
                </table>
            </div>


        </div>
    </main>

  

</body>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
	<script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
	<script type="text/javascript">
	function filterOrders(status) {
		console.log("status"+ status);
	    $.ajax({
	        url: 'admin/adminBill.htm',
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