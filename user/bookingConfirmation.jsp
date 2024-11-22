<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking Confirmation</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="../web_elements/navbar.jsp" %>
<%  
	if (userId == null) {
        response.sendRedirect("../login/login.jsp?error=notLoggedIn");
	}else{
%>
<div class="container mt-5">
    <h1>Booking Confirmation</h1>
    <div class="alert alert-success">
        Your booking has been successfully created! Your booking status is "Incomplete".
    </div>
    <a href="index.jsp" class="btn btn-primary">Return to Home</a>
</div>
<% } %>
<%@ include file="../web_elements/footer.html"%>
</body>
</html>