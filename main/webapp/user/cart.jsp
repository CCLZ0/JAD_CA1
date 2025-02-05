<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.CartItem" %>
<%@ page import="models.User" %>
<%@ page import="java.util.List"%>
<%@ include file="../web_elements/navbar.jsp"%>
<%-- <%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=notLoggedIn");
        return;
    }

    /* List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems"); */
%> --%>
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


<div class="container mt-5">
    <h2>Your Cart</h2>
    <div id="cartItems">
        <!-- Cart items will be loaded here by JavaScript -->
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>
</html>