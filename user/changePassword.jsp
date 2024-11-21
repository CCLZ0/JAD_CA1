<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
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

        String currentPassword = request.getParameter("currentPasswordChange");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        if (currentPassword == null || newPassword == null || confirmNewPassword == null || !newPassword.equals(confirmNewPassword)) {
            response.sendRedirect("profile.jsp?error=Passwords do not match.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
            conn = DriverManager.getConnection(connURL);

            // Verify current password
            String sql = "SELECT password FROM user WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                if (!BCrypt.checkpw(currentPassword, storedPassword)) {
                    response.sendRedirect("profile.jsp?error=Invalid current password.");
                    return;
                }

                // Check if the new password is the same as the current password
                if (BCrypt.checkpw(newPassword, storedPassword)) {
                    response.sendRedirect("profile.jsp?error=New password cannot be the same as the current password.");
                    return;
                }
            }

            // Hash the new password
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

            // Update user password
            sql = "UPDATE user SET password = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hashedPassword);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();

            response.sendRedirect("profile.jsp?success=Password updated successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=Failed to update password. Please try again.");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

</body>
</html>