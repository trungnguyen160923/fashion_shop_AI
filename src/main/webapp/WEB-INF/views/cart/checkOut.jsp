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
    <link rel="icon" type="image/png" href="https://d-themes.com/html/riode/images/icons/favicon.png">
    <title>Riode - Check Out</title>
    <base href="${pageContext.servletContext.contextPath}/">

    <link href="<c:url value='/resources/home/dist/css/reset.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/checkOut.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

	<style type="text/css">
		#product-quantity {
			width: 70px;
		}
		.mt{
			margin-top: 35px;
		}
		.checkbox-wrapper-46 input[type="checkbox"] {
		  display: none;
		  visibility: hidden;
		}
		
		.checkbox-wrapper-46 .cbx {
		  margin: auto;
		  -webkit-user-select: none;
		  user-select: none;
		  cursor: pointer;
		}
		.checkbox-wrapper-46 .cbx span {
		  display: inline-block;
		  vertical-align: middle;
		  transform: translate3d(0, 0, 0);
		}
		.checkbox-wrapper-46 .cbx span:first-child {
		  position: relative;
		  width: 18px;
		  height: 18px;
		  border-radius: 3px;
		  transform: scale(1);
		  vertical-align: middle;
		  border: 1px solid #9098a9;
		  transition: all 0.2s ease;
		}
		.checkbox-wrapper-46 .cbx span:first-child svg {
		  position: absolute;
		  top: 3px;
		  left: 2px;
		  fill: none;
		  stroke: #ffffff;
		  stroke-width: 2;
		  stroke-linecap: round;
		  stroke-linejoin: round;
		  stroke-dasharray: 16px;
		  stroke-dashoffset: 16px;
		  transition: all 0.3s ease;
		  transition-delay: 0.1s;
		  transform: translate3d(0, 0, 0);
		}
		.checkbox-wrapper-46 .cbx span:first-child:before {
		  content: "";
		  width: 100%;
		  height: 100%;
		  background: #506eec;
		  display: block;
		  transform: scale(0);
		  opacity: 1;
		  border-radius: 50%;
		}
		.checkbox-wrapper-46 .cbx span:last-child {
		  padding-left: 8px;
		}
		.checkbox-wrapper-46 .cbx:hover span:first-child {
		  border-color: #506eec;
		}
		
		.checkbox-wrapper-46 .inp-cbx:checked + .cbx span:first-child {
		  background: #506eec;
		  border-color: #506eec;
		  animation: wave-46 0.4s ease;
		}
		.checkbox-wrapper-46 .inp-cbx:checked + .cbx span:first-child svg {
		  stroke-dashoffset: 0;
		}
		.checkbox-wrapper-46 .inp-cbx:checked + .cbx span:first-child:before {
		  transform: scale(3.5);
		  opacity: 0;
		  transition: all 0.6s ease;
		}
		.btn-check-out.disabled {
		    pointer-events: none !important; /* Ngăn click */
		    background-color: #cccccc !important; /* Màu xám */
		    color: #666666 !important; /* Chữ mờ hơn */
		    cursor: not-allowed !important; /* Hiệu ứng không được phép */
		}
		
		@keyframes wave-46 {
		  50% {
		    transform: scale(0.9);
		  }
		}
		

	</style>
</head>
<body>
     
    <%@include file="/WEB-INF/views/header.jsp"%>
	
	


    <!-- Main -->
    <main class="main">
        <div class="page-content">
            <div class="step-by">
                <h3 class="title-step  ">1. SHOPPING CART</h3>
                <i class="fa-solid fa-angle-right"></i>
                <h3 class="title-step active">2. CHECKOUT</h3>
                <i class="fa-solid fa-angle-right"></i>
                <h3 class="title-step ">3. ORDER COMPLETE</h3>

            </div>

            <c:choose>
			    <c:when test="${emptyCart eq 1}">
			    	<div class="container">
				    	<div class = "row">
				    			<h2 style="justify-content: center;">Your cart is empty</h2>
				    	</div>
		    			<div class="row cart-action mt">
                            <a href="home/products.htm" class="btn-back-home"><i class="fa-solid fa-arrow-left"></i>CONTINUE SHOPPING</a>
                        </div>
			    	</div>
			    </c:when>    
			    <c:otherwise>

			        <div class="container">
			        	<form action="cart/orderComplete.htm" method="post">
		                <div class="row">
		                    <div class="col-8">
		                        <table class="shop-table">
		                            <thead>
		                                <tr>
		                                	<th></th>
		                                    <th><span>PRODUCT</span></th>
		                                    <th></th>
		                                    <th><span>PRICE</span></th>
		                                    <th><span>QUANTITY</span></th>
		                                    <th><span>SUBTOTAL</span></th>

		                                </tr>
		                            </thead>
		                            <tbody>
		                            	<c:forEach var="pd" items="${carts}">
										    <tr class="product">
										        <td>
										            <div class="checkbox-wrapper-46">
										                <input 
										                    type="checkbox" 
										                    id="cbx-46-${pd.id}" 
										                    class="inp-cbx subtotal-checkbox" 
										                    name="selectedProducts" 
                    										value="${pd.id}"
										                    data-value="${pd.product.price * pd.quantity}" />
										                <label for="cbx-46-${pd.id}" class="cbx">
										                    <span>
										                        <svg viewBox="0 0 12 10" height="10px" width="12px">
										                            <polyline points="1.5 6 4.5 9 10.5 1"></polyline>
										                        </svg>
										                    </span>
										                </label>
										            </div>
										        </td>
										        <td class="product-thumbnail">
										            <img src="${pd.product.image}" alt="">
										        </td>
										        
										        <td class="product-name">${pd.product.name}
										        	<input type="hidden" name="names" value="${pd.product.name}" />
										        </td>
										        <td class="product-subtotal">
										            <fmt:formatNumber type="currency" currencySymbol="$" value="${pd.product.price}" />
										            <input type="hidden" name="prices" value="${pd.product.price}" />
										        </td>
										        <td class="product-quantity">
										            <div class="form-control">
										                <button class="quantity-minus"><i class="fa-solid fa-minus"></i></button>
										                <input id="product-quantity" name="quantities" type="number" value="${pd.quantity}">
										                <button class="quantity-plus"><i class="fa-solid fa-plus"></i></button>
										            </div>
										        </td>
										        <td class="product-price subtotal-value">
										            <fmt:formatNumber value="${pd.product.price * pd.quantity}" pattern="0.00" /> $
										        </td>
										        <td class="product-close">
										            <span class="btn-remove"><i class="fa-solid fa-xmark"></i></span>
										        </td>
										    </tr>
										</c:forEach>

		                            			                                		                               
		                            </tbody>
		                        </table>

		                        <div class="cart-action">
		                            <a href="home/products.htm" class="btn-back-home"><i class="fa-solid fa-arrow-left"></i>CONTINUE SHOPPING</a>
		                        </div>
		                    </div>

		                    <div class="col-4">
		                        <div class="sidebar">
		                            <h3 class="title">Cart Totals</h3>

		                            <div class="shipping useless">
		                                <h3>Calculate Shipping</h3>
		                                <ul>
										    <li>
									            <input name="ship" type="radio" class="shipping-option" id="rate" value="1">
									            <label for="rate">Flat rate (1$)</label>
									        </li>
									        <li>
									            <input name="ship" type="radio" class="shipping-option" id="free" value="0">
									            <label for="free">Free shipping (0$)</label>
									        </li>
									        <li>
									            <input name="ship" type="radio" class="shipping-option" id="local" value="3">
									            <label for="local">Local pickup (3$)</label>
									        </li>
										</ul>
		                            </div>

		                            <div class="total">
									    <label for="">Total</label>
									   <span class="price"  id="total">$<span id="totalValue">0.00</span></span>
									   <input type="hidden" id="totalValueInput" name="totalValue" value="0.00">
									</div>

		                            <div class="payment useless">
		                                <h3>Payment Methods</h3>
		                                <ul>
		                                    <li>
		                                        <input type="radio" name="payment" value = "Check payments" id="check">
		                                        <label for="check">Check payments</label>

		                                    </li>

		                                    <li> 
		                                        <input type="radio" name="payment" value = "Cash on delivery" id="cash"> 
		                                        <label for="cash">Cash on delivery</label>
		                                    </li>
		                                </ul>
		                            </div>
									<button type="submit" class="btn-check-out disabled" id="placeOrder">PLACE ORDER</button>
		                        </div>
		                    </div>
		                </div> 
		                </form>               
		            </div>

			    </c:otherwise>
			</c:choose>
        </div>
    </main>

	
	
	<!-- FOOTER -->
    <%@include file="/WEB-INF/views/footer.jsp"%>

</body>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
    <script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
    <script type="text/javascript">
    
    document.addEventListener('DOMContentLoaded', function () {
        const placeOrderButton = document.getElementById('placeOrder');
        const shippingOptions = document.querySelectorAll('input[name="ship"]');
        const paymentOptions = document.querySelectorAll('input[name="payment"]');
        const checkboxes = document.querySelectorAll('.subtotal-checkbox');
        
        
        function updatePlaceOrderButton() {
            // Kiểm tra nếu có ít nhất một sản phẩm được chọn
            const isItemSelected = Array.from(checkboxes).some(checkbox => checkbox.checked);
            // Kiểm tra nếu một kiểu ship được chọn
            const isShippingSelected = Array.from(shippingOptions).some(option => option.checked);
            // Kiểm tra nếu một phương thức thanh toán được chọn
            const isPaymentSelected = Array.from(paymentOptions).some(option => option.checked);

            // Kích hoạt nút nếu tất cả điều kiện thỏa mãn
            if (isItemSelected && isShippingSelected && isPaymentSelected) {
                placeOrderButton.classList.remove('disabled');
                placeOrderButton.removeAttribute('disabled');
            } else {
                placeOrderButton.classList.add('disabled');
                placeOrderButton.setAttribute('disabled', true);
            }
        }

        // Lắng nghe các thay đổi
        checkboxes.forEach(checkbox => checkbox.addEventListener('change', updatePlaceOrderButton));
        shippingOptions.forEach(option => option.addEventListener('change', updatePlaceOrderButton));
        paymentOptions.forEach(option => option.addEventListener('change', updatePlaceOrderButton));

        // Kiểm tra ban đầu
        updatePlaceOrderButton();
    });
	 // Hàm tính toán tổng
	    function calculateTotal() {
	        let subtotalSum = 0;
	
	        // Tính tổng giá trị của các checkbox được chọn
	        const checkedCheckboxes = document.querySelectorAll('.subtotal-checkbox:checked');
	        checkedCheckboxes.forEach(checkbox => {
	            subtotalSum += parseFloat(checkbox.getAttribute('data-value')) || 0;
	            
	        });
	        
	
	        // Lấy giá trị phí shipping
	        const selectedShipping = document.querySelector('input[name="ship"]:checked');
	        const shippingCost = selectedShipping ? parseFloat(selectedShipping.value) : 0;
	
	        // Tính tổng
	        const total = subtotalSum + shippingCost;
	        console.log(total);
	
	        // Hiển thị tổng trong phần Total
	        document.getElementById('totalValue').textContent = total.toFixed(2);
	        document.getElementById('totalValueInput').value = total.toFixed(2);

	    }
	
	    // Lắng nghe sự kiện thay đổi trên các checkbox Subtotal
	    const subtotalCheckboxes = document.querySelectorAll('.subtotal-checkbox');
	    subtotalCheckboxes.forEach(checkbox => {
	        checkbox.addEventListener('change', calculateTotal);
	    });
	
	    // Lắng nghe sự kiện thay đổi trên các radio Shipping
	    const shippingOptions = document.querySelectorAll('.shipping-option');
	    shippingOptions.forEach(option => {
	        option.addEventListener('change', calculateTotal);
	    });
	
	    // Tính toán ban đầu khi trang được tải
	    calculateTotal();
	    
	    

    </script>
</html>