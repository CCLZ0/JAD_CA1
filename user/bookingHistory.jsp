<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking History</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="../web_elements/navbar.jsp" %>

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
            <%
                if (userId == null) {
                    response.sendRedirect("../login/login.jsp?error=notLoggedIn");
                } else {
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String bookHistconnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
                        conn = DriverManager.getConnection(connURL);

                        String sql = "SELECT b.id, s.service_name, b.booking_date, b.remarks, st.status_name, b.status, f.id AS feedback_id " +
                                "FROM booking b " +
                                "JOIN service s ON b.service_id = s.id " +
                                "JOIN status st ON b.status = st.id " +
                                "LEFT JOIN feedback f ON b.id = f.booking_id " +
                                "WHERE b.user_id = ?";
	                   pstmt = conn.prepareStatement(sql);
	                   pstmt.setInt(1, userId);
	                   rs = pstmt.executeQuery();

                   	while (rs.next()) {
                    	int bookingId = rs.getInt("id");
                        String serviceName = rs.getString("service_name");
                        String bookingDate = rs.getString("booking_date");
                        String remarks = rs.getString("remarks");
                        String statusName = rs.getString("status_name");
                        int statusId = rs.getInt("status");
                        int feedbackId = rs.getInt("feedback_id");
            %>
                            <tr>
                                <td><%= serviceName %></td>
                                <td><%= bookingDate %></td>
                                <td><%= remarks %></td>
                                <td><%= statusName %></td>
                                <td>
                                    <% if (statusId == 2 && feedbackId == 0) { %>
                                        <a href="feedback.jsp?bookingId=<%= bookingId %>" class="btn feedbackBtn">Feedback</a>
                                    <% } else if (statusId == 2) { %>
                                        <button class="btn btn-secondary" disabled>Feedback Submitted</button>
                                    <% } %>
                                </td>
                            </tr>
            <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
            %>
                        <tr>
                            <td colspan="5" class="text-danger">An error occurred while fetching booking history: <%= e.getMessage() %></td>
                        </tr>
            <%
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>