<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="../auth/checkAdmin.jsp" %>
<html>
<head>
    <title>Manage Users</title>
    <link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%@ include file="../web_elements/navbar.jsp" %>
    
    <div class="container mt-4">
        <h1>Manage Users</h1>
        <%
            Connection manageConn = null;
            Statement manageStmt = null;
            ResultSet manageRs = null;
            try {
                // Establish database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                String manageConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC";
                manageConn = DriverManager.getConnection(manageConnURL);
                
                // Query to fetch users
                String sql = "SELECT id, email, name, role FROM user";
                manageStmt = manageConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                manageRs = manageStmt.executeQuery(sql);
                
                if (manageRs.next()) {
                    manageRs.beforeFirst(); // Reset cursor to start
                    %>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Name</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        while (manageRs.next()) {
                            %>
                            <tr>
                                <td><%= manageRs.getInt("id") %></td>
                                <td><%= manageRs.getString("email") %></td>
                                <td><%= manageRs.getString("name") %></td>
                                <td><%= manageRs.getString("role") %></td>
                                <td>
                                    <!-- Edit and Delete Actions -->
                                    <a href="editUser.jsp?id=<%= manageRs.getInt("id") %>" class="btn btn-primary btn-sm">Edit</a>
                                    <a href="deleteUser.jsp?id=<%= manageRs.getInt("id") %>" class="btn btn-danger btn-sm">Delete</a>
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
                        No users found.
                    </div>
                    <%
                }
            } catch (Exception e) {
                %>
                <div class="alert alert-danger">
                    An error occurred while fetching users: <%= e.getMessage() %>
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
    <%@ include file="../web_elements/footer.html"%>
</body>
</html>

