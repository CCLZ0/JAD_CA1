<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submit Feedback</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-5">
    <h1>Submit Feedback</h1>
    <%
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("../login/login.jsp?error=notLoggedIn");
            return;
        }

        String bookingId = request.getParameter("bookingId");
        String rating = request.getParameter("rating");
        String description = request.getParameter("description");
        String suggestion = request.getParameter("suggestion");

        if (bookingId == null || !bookingId.matches("\\d+") || rating == null || !rating.matches("\\d+")) {
            response.sendRedirect("../user/bookingHistory.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
            conn = DriverManager.getConnection(connURL);

            String sql = "INSERT INTO feedback (user_id, service_id, booking_id, rating, description, suggestion) " +
                         "SELECT b.user_id, b.service_id, b.id, ?, ?, ? " +
                         "FROM booking b WHERE b.id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(rating));
            pstmt.setString(2, description);
            pstmt.setString(3, suggestion);
            pstmt.setInt(4, Integer.parseInt(bookingId));
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
    %>
                <div class="alert alert-success">
                    Feedback submitted successfully!
                </div>
                <%
                    response.sendRedirect("../user/bookingHistory.jsp");
                %>
    <%
            } else {
    %>
                <div class="alert alert-danger">
                    Failed to submit feedback.
                </div>
    <%
            }
        } catch (Exception e) {
    %>
            <div class="alert alert-danger">
                An error occurred while submitting feedback: <%= e.getMessage() %>
            </div>
    <%
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</div>
</body>
</html>