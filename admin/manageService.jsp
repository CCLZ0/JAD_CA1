<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../web_elements/navbar.jsp" %>
<html>
<head>
    <title>Manage Services</title>
    <link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container mt-4">
        <h1>Manage Services</h1>
        <a href="addService.jsp" class="btn btn-success mb-3">Add New Service</a>
        <%
            Connection manageConn = null;
            Statement manageStmt = null;
            ResultSet manageRs = null;
            try {
                // Establish database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                String manageConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC";
                manageConn = DriverManager.getConnection(manageConnURL);
                
                // Query to fetch services
                String sql = "SELECT id, service_name, description, price FROM service";
                manageStmt = manageConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                manageRs = manageStmt.executeQuery(sql);
                
                if (manageRs.next()) {
                    manageRs.beforeFirst(); // Reset cursor to start
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
                                    <!-- Edit and Delete Actions -->
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
                } else {
                    %>
                    <div class="alert alert-info">
                        No services found.
                    </div>
                    <%
                }
            } catch (Exception e) {
                %>
                <div class="alert alert-danger">
                    An error occurred while fetching services: <%= e.getMessage() %>
                </div>
                <%
                e.printStackTrace();
            } finally {
                try { if (manageRs != null) manageRs.close(); } catch (SQLException ignore) { }
                try { if (manageStmt != null) manageStmt.close(); } catch (SQLException ignore) { }
                try { if (manageConn != null) manageConn.close(); } catch (SQLException ignore) { }
            }
        %>
    </div>
</body>
</html>

