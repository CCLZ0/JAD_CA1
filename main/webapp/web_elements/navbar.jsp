<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/user/index.jsp" id="icon">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="icon" id="webicon">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link nav_item dropdown-toggle" href="#" id="servicesDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Services
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="servicesDropdown">
                        <p>No categories available</p>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link nav_item" href="../login/login.jsp" id="userLink">Login/Sign Up</a>
                    <ul class="dropdown-menu" id="userDropdownMenu">
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>
	<script>
		const contextPath = '<%= request.getContextPath() %>';
        console.log(contextPath);
    </script>
	<script src="${pageContext.request.contextPath}/js/loadNavbar.js"></script>
</body>
</html>