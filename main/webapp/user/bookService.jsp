<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.User" %>
<%@ include file="../web_elements/navbar.jsp" %>

<%
	Integer userId = (Integer) session.getAttribute("userId");
	if (userId == null) {
	    // Redirect to login page if not logged in
	    response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=notLoggedIn");
	    return;
	}
	
    String errorMessage = request.getParameter("error");
    String serviceId = request.getParameter("serviceId"); // Get serviceId from URL parameter
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Service</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-5">
    <h2>Book Service</h2>

    <%
        if (errorMessage != null) {
    %>
        <div class="alert alert-danger">
            <%= errorMessage %>
        </div>
    <%
        }
    %>

    <form action="<%= request.getContextPath() %>/BookServiceServlet" method="post" onsubmit="return validateBookingTime()">
        <input type="hidden" name="serviceId" value="<%= serviceId %>"> <!-- Hidden input field for serviceId -->
        <div class="mb-3">
            <label for="bookingTime" class="form-label">Booking Time (Working hours: 9am - 6pm, Mon - Sat)</label>
            <input type="datetime-local" class="form-control" id="bookingTime" name="bookingTime" required>
        </div>
        <div class="mb-3">
            <label for="remarks" class="form-label">Remarks</label>
            <textarea class="form-control" id="remarks" name="remarks" rows="3"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Add to Cart</button>
    </form>
</div>

<script src="${pageContext.request.contextPath}/js/bookingForm.js"></script>
</body>
</html>