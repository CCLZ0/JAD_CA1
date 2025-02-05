<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../web_elements/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-5">
    <h1>Profile</h1>

    <%
        String successMessage = request.getParameter("success");
        String errorMessage = request.getParameter("error");

        if ("profileUpdated".equals(successMessage)) {
    %>
        <div class="alert alert-success">
            Profile updated successfully.
        </div>
    <%
        } else if ("passwordUpdated".equals(successMessage)) {
    %>
        <div class="alert alert-success">
            Password updated successfully.
        </div>
    <%
        } else if ("missingData".equals(errorMessage)) {
    %>
        <div class="alert alert-danger">
            Missing data! Please fill out all fields.
        </div>
    <%
        } else if ("passwordMismatch".equals(errorMessage)) {
    %>
        <div class="alert alert-danger">
            New passwords do not match.
        </div>
    <%
        } else if ("incorrectPassword".equals(errorMessage)) {
    %>
        <div class="alert alert-danger">
            Current password is incorrect.
        </div>
    <%
        } else if ("updateFailed".equals(errorMessage)) {
    %>
        <div class="alert alert-danger">
            An error occurred while updating the profile.
        </div>
    <%
        }
    %>

    <div id="profileForm">
        <form action="<%= request.getContextPath() %>/EditProfileServlet" method="post">
            <div class="mb-3">
                <label for="userName" class="form-label">Username</label>
                <input type="text" class="form-control editable" id="userName" name="userName" disabled>
            </div>
            <div class="mb-3">
                <label for="userEmail" class="form-label">Email</label>
                <input type="email" class="form-control editable" id="userEmail" name="userEmail" disabled>
            </div>
            <button type="button" class="btn btn-primary" id="editButton" onclick="toggleEdit()">Edit Profile</button>
            <button type="submit" class="btn btn-success" id="saveButton" style="display: none;">Save Changes</button>
            <button type="button" class="btn btn-warning" id="changePasswordButton" style="display: none;" onclick="toggleChangePassword()">Change Password</button>
        </form>
        <a href="${pageContext.request.contextPath}/login/logout.jsp" class="btn btn-danger mt-3" id="logoutButton">Logout</a>
    </div>

    <div id="changePasswordForm" style="display: none;">
        <form action="<%= request.getContextPath() %>/ChangePasswordServlet" method="post">
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
<script src="${pageContext.request.contextPath}/js/profile.js"></script>
<%@ include file="../web_elements/footer.jsp" %>
</body>
</html>