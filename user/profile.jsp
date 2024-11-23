<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<%@ include file="../web_elements/navbar.jsp" %>

<div class="container mt-5">
    <h1>Profile</h1>
    <%
        if (userId == null) {
            response.sendRedirect("../login/login.jsp?error=notLoggedIn");
            return;
        }

        String successMessage = request.getParameter("success");
        String errorMessage = request.getParameter("error");

        if (successMessage != null) {
    %>
        <div class="alert alert-success">
            <%= successMessage %>
        </div>
    <%
        } else if (errorMessage != null) {
    %>
        <div class="alert alert-danger">
            <%= errorMessage %>
        </div>
    <%
        }

        Connection profileConn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String userEmail = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String profileConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
            profileConn = DriverManager.getConnection(profileConnURL);

            String sql = "SELECT name, email FROM user WHERE id = ?";
            pstmt = profileConn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                userName = rs.getString("name");
                userEmail = rs.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (profileConn != null) try { profileConn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <div id="profileForm">
        <form action="editProfile.jsp" method="post">
            <div class="mb-3">
                <label for="userName" class="form-label">Username</label>
                <input type="text" class="form-control editable" id="userName" name="userName" value="<%= userName %>" disabled>
            </div>
            <div class="mb-3">
                <label for="userEmail" class="form-label">Email</label>
                <input type="email" class="form-control editable" id="userEmail" name="userEmail" value="<%= userEmail %>" disabled>
            </div>
            <button type="button" class="btn btn-primary" id="editButton" onclick="toggleEdit()">Edit Profile</button>
            <button type="submit" class="btn btn-success" id="saveButton" style="display: none;">Save Changes</button>
            <button type="button" class="btn btn-warning" id="changePasswordButton" style="display: none;" onclick="toggleChangePassword()">Change Password</button>
        </form>
        <a href="../login/logout.jsp" class="btn btn-danger mt-3" id="logoutButton">Logout</a>
    </div>

    <div id="changePasswordForm" style="display: none;">
        <form action="changePassword.jsp" method="post">
            <div class="mb-3">
                <label for="currentPasswordChange" class="form-label">Current Password</label>
                <input type="password" class="form-control" id="currentPasswordChange" name="currentPasswordChange" required>
            </div>
            <div class="mb-3">
                <label for="newPassword" class="form-label">New Password</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            </div>
            <div class="mb-3">
                <label for="confirmNewPassword" class="form-label">Confirm New Password</label>
                <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
            </div>
            <button type="submit" class="btn btn-success">Update Password</button>
            <button type="button" class="btn btn-secondary" onclick="toggleChangePassword()">Cancel</button>
        </form>
    </div>
</div>
<script src="../js/profile.js"></script>
<%@ include file="../web_elements/footer.html" %>
</body>
</html>