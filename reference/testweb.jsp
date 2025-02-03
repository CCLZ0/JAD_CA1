<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dbaccess.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>User List</title>
</head>
<body>
    <h2>List All Users</h2>

    <form action="<%=request.getContextPath()%>/GetUserList">
        <input type="submit" value="List All Users">
    </form>

    <!-- Form for User Inquiry -->
    <h3>Inquire User by ID</h3>
    <form action="<%=request.getContextPath()%>/ObtainUserDetailsServlet" method="get">
        <label for="userid">User ID:</label>
        <input type="text" id="userid" name="userid" required>
        <input type="submit" value="Inquire">
    </form>

    <!-- Form for Creating New User -->
    <h3>Create New User</h3>
    <form action="<%=request.getContextPath()%>/AddUser" method="post">
        <label for="userid">User ID:</label>
        <input type="text" id="userid" name="userid" required><br>
        <label for="age">Age:</label>
        <input type="number" id="age" name="age" required><br>
        <label for="gender">Gender:</label>
        <select id="gender" name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select><br>
        <input type="submit" value="Create User">
    </form>

    <!-- Display Error Message if User Not Found -->
    <%
    String error = (String) request.getAttribute("err");
    if (error != null && error.equals("NotFound")) {
        out.print("<p style='color:red;'>ERROR: User not found!</p>");
    }
    %>

    <%
    // Retrieve list of users from request attribute
    @SuppressWarnings("unchecked")
    ArrayList<User> userArray = (ArrayList<User>) request.getAttribute("userArray");

    // If the userArray is not null or empty, display users
    if (userArray != null && !userArray.isEmpty()) {
    %>
        <h3>Existing Users</h3>
        <table border="1">
            <tr>
                <th>User ID</th>
                <th>Age</th>
                <th>Gender</th>
            </tr>
            <%
            // Loop through the list of users and display each user's details
            for (User u : userArray) {
            %>
            <tr>
                <td><%= u.getUserid() %></td>
                <td><%= u.getAge() %></td>
                <td><%= u.getGender() %></td>
            </tr>
            <%
            }
            %>
        </table>
    <%
    } 
    %>

</body>
</html>




