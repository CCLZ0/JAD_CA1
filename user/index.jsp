<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shine Pro</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link rel = "stylesheet" href="../css/style.css">
</head>
<body>
	 <%@ include file="../web_elements/navbar.jsp" %>
	 <div class="banner">
	 	<img id="bannerImg" src="../img/banner.png" alt="bannerImg">
	 	<div class="overlay">
        	<h1 id="overlayText">We leave your house sparkling clean!</h1>
        	<div class="searchBar">
            	<input type="text" placeholder="Search" />
            	<button class="book-now-btn">Book Now</button>
        	</div>
    	</div>
	 </div>
	 <div class="divider">
	 	<h2>Cleaning services for all!</h2>
	 </div>
	 
	 <%@ include file="../web_elements/footer.html" %>
</body>
</html>