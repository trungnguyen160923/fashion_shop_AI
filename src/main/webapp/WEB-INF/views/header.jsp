<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
	<!-- Header -->
	<header class="header">
		<section class="header-top">
			<div class="container d-flex jc-space-between ai-center">
				<div class="header-left">
					<p>Welcome to HardMode store message or remove it!</p>
				</div>

				<div class="header-right">
					<a class="hover-p-color" href=""> <i
						class="fa-solid fa-location-dot"></i>Contact Us
					</a> <a class="hover-p-color" href=""> <i
						class="fa-solid fa-circle-info"></i>Need help
					</a>
				</div>
			</div>
		</section>

		<section class="header-middle">
			<div class="container d-flex jc-space-between ai-center">
				<div class="header-left  d-flex jc-space-between ai-center">
					<div class="logo">
						<a href="home/index.htm"><img
							src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAbIXMWqGU_HT9XebFegSh4ZTYBpv-HNt7ww&s"
							alt=""></a>
					</div>

					<ul class="menu  d-flex jc-space-between ai-center">
						<li><a href="home/index.htm">Home</a></li>
						<li><a href="home/products.htm">Products</a></li>
						<li><a href="">Sale</a></li>
						<li><a href="">About</a></li>
						<li><a href="user/purchaseOrder.htm">Purchase Order</a></li>
						<li class="search d-flex ai-center">
						<form action="search.htm" method="get">
					        <input type="text" name="query" placeholder="Search..." value="${param.query}">
					        <button type="submit">
					            <i class="fa-solid fa-magnifying-glass"></i>
					        </button>
					    </form>
						</li>
					</ul>
				</div>

				<ul class="header-right  d-flex jc-space-between ai-center">
		<!-- getSession -->
					<c:if test="${acc != null}">
						<c:if test="${acc.getrole().getIdRole() == 2}">
							<li><a href="user/userHome.htm " class="user-area"> <span
									class="user-name">${acc.getFullname() }</span>
									<div class="user-thumbnail">
										<c:if test="${!acc.getImage().toString().equals(null)}">
											<img src="${acc.getImage() }" alt="">
										</c:if>
									</div>
							</a></li>
						</c:if>
						<c:if test="${acc.getrole().getIdRole() == 1}">
							<li><a href="admin/adminHome.htm " class="user-area"> <span
									class="user-name">${acc.getFullname() }</span>
									<div class="user-thumbnail">
										<c:if test="${!acc.getImage().toString().equals(null)}">
											<img src="${acc.getImage() }" alt="">
										</c:if>
									</div>
							</a></li>
						</c:if>
					</c:if>

					<c:if test="${acc == null}">
						<li><a href="user/login.htm"><i class="fa-solid fa-user"></i></a></li>
					</c:if>
					
					
					<!-- Cart-Shopping  -->
                    <li class="cart-group"> 
					    <a href="cart/checkout.htm">
					        <i class="fa-solid fa-bag-shopping"></i>
					        <c:set var="totalQuantity" value="0" />
					        <c:forEach var="cart" items="${sessionScope.carts}">
					            <c:set var="totalQuantity" value="${totalQuantity + 1}" />
					        </c:forEach>
					        <c:if test="${not empty sessionScope.carts}">
					            <span class="prod-quantity">${totalQuantity}</span>
					        </c:if>
					    </a>
					    
					    <c:choose>
					        <c:when test="${not empty sessionScope.carts}">
					            <div class="cart">
					                <div class="show-prods">
					                    <c:forEach var="cart" items="${sessionScope.carts}">
					                        <div class="prod">
					                            <div class="prod-image">
					                                <img src="${cart.product.image}" alt="">
					                            </div>
					                            <div class="prod-info">
					                                <div class="prod-content">
					                                    <h3><a href="home/detail/${cart.product.idProduct }.htm" class="prod-name">${cart.product.name}</a></h3>
					                                    <p>
					                                        <span class="quantity">${cart.quantity}</span> 
					                                        x 
					                                        <span class="price">$${cart.product.price}</span>
					                                    </p>
					                                </div>
					                            </div>
					                            <div class="btn-remove">
					                                <span class="icon"><i class="fa-solid fa-xmark"></i></span>
					                            </div>
					                        </div>
					                    </c:forEach>
					                    
					                </div>
					
					                <div class="subtotal">
					                    <c:set var="totalPrice" value="0" />
					                    <c:forEach var="cart" items="${sessionScope.carts}">
					                        <c:set var="totalPrice" value="${totalPrice + (cart.product.price * cart.quantity)}" />
					                    </c:forEach>
					                    <label for="">Subtotal:</label>
					                    <span class="total-price">$${totalPrice}</span>
					                </div>
					
					                <div class="action">
					                    <a href="cart/checkout.htm" class="btn-check-out">GO TO CHECK OUT</a>
					                </div>
					            </div>
					        </c:when>
					        <c:otherwise>
					            <!-- <p>Your cart is empty.</p> -->
					        </c:otherwise>
					    </c:choose>
					</li>

				</ul>
			</div>
		</section>

		<div class="header-support"></div>

	</header>