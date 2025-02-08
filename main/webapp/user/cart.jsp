<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="../web_elements/navbar.jsp" %>
<%
    // Check if user is logged in
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        // Redirect to login page if not logged in
        response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=notLoggedIn");
        return;
    }
%>
<div class="container mt-5">
    <h2>Cart</h2>
    <div id="cartItems">
        <!-- Cart items will be loaded here by JavaScript -->
    </div>
</div>
<script>
	contextPath = '<%= request.getContextPath() %>';
</script>
<script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>
</html>