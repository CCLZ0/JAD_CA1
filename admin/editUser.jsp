<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ include file="../auth/checkAdmin.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@ include file="../web_elements/navbar.jsp" %>

    <%
        // Initialization
        String email = "";
        String name = "";
        String role = "";
        String successMessage = "";
        String errorMessage = "";
        String newPassword = "";
        String confirmNewPassword = "";

        // Declare connection, statement, and result set variables
        Connection manageconn = null;
        PreparedStatement managestmt = null;
        ResultSet managers = null;

        // Fetch user details
        int userIdToEdit = Integer.parseInt(request.getParameter("id"));
        try {
            // Establish connection
            manageconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC");
            // Prepare SQL statement
            managestmt = manageconn.prepareStatement("SELECT email, name, role FROM user WHERE id = ?");
            managestmt.setInt(1, userIdToEdit);
            // Execute query
            managers = managestmt.executeQuery();

            if (managers.next()) {
                email = managers.getString("email");
                name = managers.getString("name");
                role = managers.getString("role");
            } else {
                errorMessage = "User not found.";
            }
        } catch (SQLException e) {
            errorMessage = "Error fetching user details: " + e.getMessage();
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (managers != null) managers.close();
                if (managestmt != null) managestmt.close();
                if (manageconn != null) manageconn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Handle form submission for updating user
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            email = request.getParameter("email");
            name = request.getParameter("name");
            role = request.getParameter("role");
            newPassword = request.getParameter("newPassword");
            confirmNewPassword = request.getParameter("confirmNewPassword");

            // Validate input data
            if (email == null || email.isEmpty()) {
                errorMessage = "Email is required.";
            } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                errorMessage = "Invalid email format.";
            } else if (name == null || name.isEmpty()) {
                errorMessage = "Name is required.";
            } else if (role == null || (!role.equals("admin") && !role.equals("member"))) {
                errorMessage = "Role must be either 'admin' or 'member'.";
            } else if (!newPassword.equals(confirmNewPassword)) {
                errorMessage = "Passwords do not match.";
            } else if (newPassword != null && !newPassword.isEmpty() && newPassword.length() < 4) {
                errorMessage = "Password must be at least 4 characters long.";
            } else {
                try {
                    // Check if email is already used by another user
                    manageconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC");
                    managestmt = manageconn.prepareStatement("SELECT COUNT(*) FROM user WHERE email = ? AND id != ?");
                    managestmt.setString(1, email);
                    managestmt.setInt(2, userIdToEdit);
                    ResultSet rs = managestmt.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        errorMessage = "Email is already in use by another user.";
                    } else {
                        // Hash the new password if provided
                        String hashedPassword = null;
                        if (newPassword != null && !newPassword.isEmpty()) {
                            hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                        }

                        // Prepare SQL update statement
                        String updateQuery = "UPDATE user SET email = ?, name = ?, role = ?";

                        // Only update password if provided
                        if (hashedPassword != null) {
                            updateQuery += ", password = ?";
                        }
                        updateQuery += " WHERE id = ?";

                        managestmt = manageconn.prepareStatement(updateQuery);
                        managestmt.setString(1, email);
                        managestmt.setString(2, name);
                        managestmt.setString(3, role);

                        // Set password parameter only if a new password is provided
                        if (hashedPassword != null) {
                            managestmt.setString(4, hashedPassword);
                            managestmt.setInt(5, userIdToEdit);
                        } else {
                            managestmt.setInt(4, userIdToEdit);
                        }

                        // Execute update
                        if (managestmt.executeUpdate() > 0) {
                            successMessage = "User updated successfully!";
                        } else {
                            errorMessage = "No rows updated. Please try again.";
                        }
                    }
                } catch (SQLException e) {
                    errorMessage = "Error updating user: " + e.getMessage();
                    e.printStackTrace();
                } finally {
                    // Close resources
                    try {
                        if (managestmt != null) managestmt.close();
                        if (manageconn != null) manageconn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>

    <div class="container mt-4">
        <h1>Edit User</h1>

        <!-- Feedback Messages -->
        <% if (!successMessage.isEmpty()) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } %>
        <% if (!errorMessage.isEmpty()) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>

        <form action="editUser.jsp" method="post">
            <input type="hidden" name="id" value="<%= userIdToEdit %>">

            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" id="email" name="email" class="form-control" value="<%= email %>" required>
            </div>

            <div class="mb-3">
                <label for="name" class="form-label">Name:</label>
                <input type="text" id="name" name="name" class="form-control" value="<%= name %>" required>
            </div>

            <div class="mb-3">
                <label for="role" class="form-label">Role:</label>
                <select id="role" name="role" class="form-select" required>
                    <option value="admin" <%= "admin".equals(role) ? "selected" : "" %>>Admin</option>
                    <option value="member" <%= "member".equals(role) ? "selected" : "" %>>Member</option>
                </select>
            </div>
            
            <p>Leave below empty if not changing password</p>
            <!-- New Password -->
            <div class="mb-3">
                <label for="newPassword" class="form-label">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" class="form-control">
            </div>

            <!-- Confirm New Password -->
            <div class="mb-3">
                <label for="confirmNewPassword" class="form-label">Confirm New Password:</label>
                <input type="password" id="confirmNewPassword" name="confirmNewPassword" class="form-control">
            </div>

            <button type="submit" class="btn btn-primary">Update User</button>
        </form>

        <!-- Back Button -->
        <button class="btn btn-secondary mt-3" onclick="window.location.href='../admin/manageUser.jsp';">Back</button>
    </div>
    <%@ include file="../web_elements/footer.html"%>
</body>
</html>





