<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../web_elements/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking History</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-5">
	    <h1>Booking History</h1>
	    <table class="table">
	        <thead>
	            <tr>
	                <th>Service Name</th>
	                <th>Booking Date</th>
	                <th>Remarks</th>
	                <th>Status</th>
	                <th>Actions</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <td colspan="5">Loading...</td>
	            </tr>
	        </tbody>
	    </table>
	</div>
	<%@ include file="../web_elements/footer.jsp"%>
	<script src="${pageContext.request.contextPath}/js/loadBookingHist.js"></script>
</body>
</html>