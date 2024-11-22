<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../auth/checkAdmin.jsp" %>
<html>
<head>
    <title>Manage Services</title>
    <link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@ include file="../web_elements/navbar.jsp" %>
	
    <div class="container mt-4">
        <h1>Manage Services</h1>
        <a href="addService.jsp" class="btn btn-success mb-3">Add New Service</a>
        <%
            String sql = "SELECT id, service_name, description, price FROM service";
            try (Connection manageConn = DriverManager.getConnection(
                         "jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC");
                 Statement manageStmt = manageConn.createStatement();
                 ResultSet manageRs = manageStmt.executeQuery(sql)) {

                if (!manageRs.isBeforeFirst()) { 
                    %>
                    <div class="alert alert-info">No services found.</div>
                    <%
                } else {
                    %>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Service Name</th>
                                <th>Description</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        while (manageRs.next()) {
                            %>
                            <tr>
                                <td><%= manageRs.getInt("id") %></td>
                                <td><%= manageRs.getString("service_name") %></td>
                                <td><%= manageRs.getString("description") %></td>
                                <td>$<%= manageRs.getDouble("price") %></td>
                                <td>
                                    <a href="editService.jsp?id=<%= manageRs.getInt("id") %>" class="btn btn-primary btn-sm">Edit</a>
                                    <a href="deleteService.jsp?id=<%= manageRs.getInt("id") %>" class="btn btn-danger btn-sm">Delete</a>
                                </td>
                            </tr>
                            <%
                        }
                        %>
                        </tbody>
                    </table>
                    <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
                %>
                <div class="alert alert-danger">An error occurred while fetching services: <%= e.getMessage() %></div>
                <%
            }
        %>
    </div>
    <%@ include file="../web_elements/footer.html"%>
</body>
</html>



