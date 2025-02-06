<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dbaccess.User" %>
<%@ page import="dbaccess.UserDAO" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@ include file="../web_elements/navbar.jsp"%>

    <div class="container mt-5">
        <h1 class="mb-4">Edit User</h1>

        <%
        String errorMessage = "";
        String successMessage = "";
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = null;

        try {
            UserDAO userDAO = new UserDAO();
            user = userDAO.getUserDetails(userId);
        } catch (SQLException e) {
            errorMessage = "Error retrieving user: " + e.getMessage();
            e.printStackTrace();
        }

        if (user != null) {
        %>
            <!-- Form for Editing User -->
            <div class="box">
                <h3>[POST] User::Edit</h3>
                <form action="<%=request.getContextPath()%>/EditUserServlet" method="POST">
                	<input type="hidden" name="id" value="<%= user.getid() %>" />
                    <div>
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required />
                    </div>
                    <div>
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" value="<%= user.getName() %>" required />
                    </div>
                    <div>
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" value="<%= user.getPassword() %>" required />
                    </div>
                    <div>
                        <label for="role">Role:</label>
                        <input type="text" id="role" name="role" value="<%= user.getRole() %>" required />
                    </div>
                    <div>
                        <input type="submit" value="Update User" class="btn btn-primary" />
                    </div>
                </form>
            </div>
        <%
        } else {
            out.print("<p style='color:red;'>ERROR: User not found!</p>");
        }
        %>

        <!-- Back Button -->
        <button class="btn btn-secondary mt-3" onclick="window.location.href='<%=request.getContextPath()%>/admin/manageUser.jsp';">Back</button>
    </div>

    <%@ include file="../web_elements/footer.html"%>
</body>
</html>