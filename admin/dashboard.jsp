<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Administrator Dashboard</title>
<link
	href="https://fonts.googleapis.com/css2?family=Recursive&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%@ include file="../web_elements/navbar.jsp"%>
	<div class="dashboard-container">
		<h1>Administrator Dashboard</h1>
		<ul class="menu">
			<li><a href="manageService.jsp">Manage Services (CRUD)</a></li>
			<!--  <li><a href="manageUser.jsp">Manage Users (CRUD)</a></li> -->
		</ul>
	</div>
</body>
</html>
