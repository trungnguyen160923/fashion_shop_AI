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
    <title>HardMode - User home</title>
    <base href="${pageContext.servletContext.contextPath}/">
    <link rel="icon" type="image/png" href="https://d-themes.com/html/riode/images/icons/favicon.png">

    <link href="<c:url value='/resources/home/dist/css/reset.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/userHome.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>
    
    <aside class="aside">
        <a href="user/userHome.htm" class="admin">
            <div class="logo">
                <i class="fa-solid fa-t"></i>
            </div>
            ${acc.getFullname() }
        </a>

        <ul class="functions">
            <li class="function">
                <a href="user/userHome.htm" class=" active">
                    <div class="icon">
                        <i class="fa-solid fa-user"></i>
                    </div>
                    Information 
                </a>
            </li>

            <li class="function">
                <a href="user/changepassword/{acc}.htm" class="">
                    <div class="icon">
                        <i class="fa-solid fa-key"></i>
                    </div>
                    Change password 
                </a>
            </li>

            <li class="function">
                <a href="user/purchaseOrder.htm">
                    <div class="icon">
                        <i class="fa-solid fa-receipt"></i>

                    </div>
                    Shopping History 
                </a>
            </li>

        

            
        </ul>

        <form>
        	<button class="btn-log-out"><a href="user/logout.htm">Log out</a></button>
        </form>
    </aside>

    <!-- Main -->
    <main class="main">
        <div class="main-header">
            <h2>Welcome our customer!</h2>

            <div class="map">
                <a href="home/index.htm">Home</a>
                /
                <a href="user/userHome.htm">${acc.getFullname() }</a>
            </div>
        </div>

        <div class="main-content">
 <form method="post">
    <div class="row">
        <div class="col-4">
            <div class="logo">
                <i class="fa-solid fa-t"></i>
            </div>
        </div>

        <div class="col-4">
			<div>
	            <label for="username">Username:</label>
	            <input type="text" placeholder="Username" name="username" value="${acc.getUser_name() }" readonly>
			</div>
			
            <div>
	            <label for="name">Full name:</label>
	            <input type="text" placeholder="FullName" name="name" value="${acc.getFullname() }">
	                <c:if test="${not empty nameError}">
	               		<span class="error">${nameError}</span>
	            	</c:if>
            </div>
 
            <div>
	            <label for="email">Email:</label>
	            <input type="email" placeholder="Email" value="${acc.getEmail() }" readonly>
			</div>
			
			<div>
	            <label for="gender">Gender:</label>
	            <select name="gender">
	                <option value="true" ${acc.gender ? 'selected' : ''}>Male</option>
	                <option value="false" ${!acc.gender ? 'selected' : ''}>Female</option>
	            </select>
            </div>
        </div>

        <div class="col-4">
            <div>
            <label for="birthday">Birthday:</label>
            <input type="date" placeholder="Birthday" name="birthday" value="${acc.getBirthday() }">

                 <c:if test="${not empty birthdayError}">
                	<span class="error">${birthdayError}</span>
            	 </c:if>
            </div>


	        <div>
            <label for="phone">Number:</label>
            <input type="number" placeholder="PhoneNumber" name="phone" value="${acc.getPhone() }">

	            <c:if test="${not empty phoneError}">
	                <span class="error">${phoneError}</span>
	            </c:if>
			</div>   

            <div>
            <label for="address">Address:</label>
            <input type="text" placeholder="Address" name="address" value="${acc.getAddress() }">

	            <c:if test="${not empty addressError}">
	                <span class="error">${addressError}</span>
	            </c:if>
	        </div>
        </div>
    </div>

    <button class="btn" type="submit">Save changes</button>
</form>

			
		
        </div>
    </main>

  

</body>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
	<script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
	<style>
    .error {
        color: red;
        font-size: 1.2em;
        margin-top: 5px;
        display: block;
    }
</style>
	
</html>
