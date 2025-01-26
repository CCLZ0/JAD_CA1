<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>


    <%
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("../login/login.jsp?error=notLoggedIn");
            return;
        }

        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");

        if (userName == null || userEmail == null) {
            response.sendRedirect("profile.jsp?error=Missing data! Please fill out all fields.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root123&serverTimezone=UTC";
            conn = DriverManager.getConnection(connURL);

            // Update user information
            String sql = "UPDATE user SET name = ?, email = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            pstmt.setString(2, userEmail);
            pstmt.setInt(3, userId);
            pstmt.executeUpdate();

            response.sendRedirect("profile.jsp?success=Profile updated successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=Failed to update profile. Please try again.");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>