<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../web_elements/navbar.jsp" %>
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

<%
    String serviceId = request.getParameter("serviceId");
    String bookingDate = request.getParameter("bookingDate");
    String remarks = request.getParameter("remarks");

    if (userId != null && serviceId != null && bookingDate != null) {
        Connection bookConn = null;
        PreparedStatement bookPstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String bookConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
            conn = DriverManager.getConnection(connURL);

            String bookQuery = "INSERT INTO booking (member_id, service_id, booking_date, remarks, status) VALUES (?, ?, ?, ?, 1)";
            bookPstmt = conn.prepareStatement(bookQuery);
            bookPstmt.setInt(1, userId);
            bookPstmt.setInt(2, Integer.parseInt(serviceId));
            bookPstmt.setString(3, bookingDate);
            bookPstmt.setString(4, remarks != null ? remarks : "");
            int rowsAffected = bookPstmt.executeUpdate();

            if (rowsAffected > 0) {
%>
                <div class="alert alert-success">
                    Booking created successfully! Your booking status is "incomplete".
                    <a href="index.jsp"><button class="btn-custom">Back to home</button></a>
                </div>
<%
            } else {
%>
                <div class="alert alert-danger">
                    Failed to create booking.
                </div>
<%
            }
        } catch (Exception e) {
%>
            <div class="alert alert-danger">
                An error occurred while creating the booking: <%= e.getMessage() %>
            </div>
<%
        } finally {
            if (bookPstmt != null) bookPstmt.close();
            if (conn != null) conn.close();
        }
    } else if (userId != null && serviceId != null) {
%>
        <div class="container mt-5">
            <h2>Book Service</h2>
            <form action="bookService.jsp" method="post">
                <input type="hidden" name="serviceId" value="<%= serviceId %>">
                <div class="mb-3">
                    <label for="bookingDate" class="form-label">Select Date</label>
                    <input type="date" class="form-control" id="bookingDate" name="bookingDate" required>
                </div>
                <div class="mb-3">
                    <label for="remarks" class="form-label">Remarks</label>
                    <textarea class="form-control" id="remarks" name="remarks" rows="3"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
<%
    } else {
    	response.sendRedirect("../login/login.jsp?error=notLoggedIn");
%>

<%
    }
%>
</body>
</html>