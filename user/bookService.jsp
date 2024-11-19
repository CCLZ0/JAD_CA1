<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Service</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="../web_elements/navbar.jsp" %>

<%
    String serviceId = request.getParameter("serviceId");
    String bookingTime = request.getParameter("bookingTime");
    String remarks = request.getParameter("remarks");

    if (userId == null) {
        response.sendRedirect("../login/login.jsp?error=notLoggedIn");
    } else if ("POST".equalsIgnoreCase(request.getMethod()) && serviceId != null && bookingTime != null) {
        Connection bookConn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String bookConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
            bookConn = DriverManager.getConnection(bookConnURL);

            String query = "INSERT INTO cart (user_id, service_id, booking_time, price, remarks) VALUES (?, ?, ?, (SELECT price FROM service WHERE id = ?), ?)";
            pstmt = bookConn.prepareStatement(query);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, Integer.parseInt(serviceId));
            pstmt.setString(3, bookingTime);
            pstmt.setInt(4, Integer.parseInt(serviceId));
            pstmt.setString(5, remarks != null ? remarks : "");
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
%>
                <div class="alert alert-success">
                    Service added to cart successfully!
                </div>
                <%
                    response.sendRedirect("cart.jsp");
                %>
<%
            } else {
%>
                <div class="alert alert-danger">
                    Failed to add service to cart.
                </div>
<%
            }
        } catch (Exception e) {
%>
            <div class="alert alert-danger">
                An error occurred while adding the service to the cart: <%= e.getMessage() %>
            </div>
<%
        } finally {
            if (pstmt != null) pstmt.close();
            if (bookConn != null) bookConn.close();
        }
    } else if (serviceId != null) {
%>
        <div class="container mt-5">
            <h2>Book Service</h2>
            <form action="bookService.jsp" method="post" onsubmit="return validateBookingTime()">
                <input type="hidden" name="serviceId" value="<%= serviceId %>">
                <div class="mb-3">
                    <label for="bookingTime" class="form-label">Booking Time</label>
                    <input type="datetime-local" class="form-control" id="bookingTime" name="bookingTime" required>
                </div>
                <div class="mb-3">
                    <label for="remarks" class="form-label">Remarks</label>
                    <textarea class="form-control" id="remarks" name="remarks" rows="3"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Add to Cart</button>
            </form>
        </div>
<%
    }
%>
</body>
<script src="../js/bookingForm.js"></script>
</html>