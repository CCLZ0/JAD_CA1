<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/navbar.css">
</head>
<body>
<%  %>
		<header>
			<nav class="navbar navbar-expand-lg">		        
		            <!-- Logo on the left -->
		            <a class="navbar-brand" href="index.jsp" id="icon">
		                <img src="../img/logo.png" alt="icon" id="webicon">
		            </a>

		            <!-- Hamburger menu for mobile view -->
		            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
		                <span class="navbar-toggler-icon"></span>
		            </button>
		
		            <!-- Links on the right -->
		            <div class="collapse navbar-collapse" id="navbarNav">
		                <ul class="navbar-nav ms-auto"> <!-- ms-auto pushes items to the right -->
		                    <li class="nav-item">
		                        <a class="nav-link nav_item" href="services.jsp">Services</a>
		                    </li>
		                    <li class="nav-item">
		                        <a class="nav-link nav_item" href="bookings.jsp">Bookings</a>
		                    </li>
		                    <li class="nav-item">
		                        <a class="nav-link nav_item" href="../login/login.jsp">Login/Sign up</a>
		                    </li>
		                </ul>
		            </div>
		    </nav>
		</header>	
</body>
</html>