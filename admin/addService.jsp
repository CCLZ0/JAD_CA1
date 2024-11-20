<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Service</title>
    <link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@ include file="../web_elements/navbar.jsp"%>
    <div class="container mt-4">
        <h1>Add New Service</h1>
        
        <form action="addService.jsp" method="post">
            <div class="mb-3">
                <label for="serviceName" class="form-label">Service Name:</label>
                <input type="text" id="serviceName" name="serviceName" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <textarea id="description" name="description" class="form-control" required></textarea>
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Price:</label>
                <input type="number" id="price" name="price" class="form-control" step="0.01" required>
            </div>
            <div class="mb-3">
                <label for="categoryId" class="form-label">Category:</label>
                <select id="categoryId" name="categoryId" class="form-select" required>
                    <%
                        Connection manageConn = null;
                        Statement manageStmt = null;
                        ResultSet manageRs = null;
                        try {
                            manageConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC");
                            String categoryQuery = "SELECT id, category_name FROM service_category";
                            manageStmt = manageConn.createStatement();
                            manageRs = manageStmt.executeQuery(categoryQuery);
                            while (manageRs.next()) {
                                int categoryId = manageRs.getInt("id");
                                String categoryName = manageRs.getString("category_name");
                                out.println("<option value='" + categoryId + "'>" + categoryName + "</option>");
                            }
                        } catch (Exception e) {
                            out.println("<option value=''>Error loading categories</option>");
                            out.println("<p style='color: red;'>Error loading categories: " + e.getMessage() + "</p>");
                        } finally {
                            try { if (manageRs != null) manageRs.close(); } catch (SQLException e) { }
                            try { if (manageStmt != null) manageStmt.close(); } catch (SQLException e) { }
                            try { if (manageConn != null) manageConn.close(); } catch (SQLException e) { }
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Add Service</button>
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String serviceName = request.getParameter("serviceName");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                Connection manageConn2 = null;
                PreparedStatement pstmt = null;

                try {
                    // Connect to the database
                    manageConn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC");

                    // Insert new service into the database
                    String sql = "INSERT INTO service (service_name, description, price, category_id) VALUES (?, ?, ?, ?)";
                    pstmt = manageConn2.prepareStatement(sql);
                    pstmt.setString(1, serviceName);
                    pstmt.setString(2, description);
                    pstmt.setDouble(3, price);
                    pstmt.setInt(4, categoryId);
                    pstmt.executeUpdate();
                    
                    out.println("<div class='alert alert-success mt-3'>Service added successfully!</div>");
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger mt-3'>Error: " + e.getMessage() + "</div>");
                } finally {
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
                    try { if (manageConn2 != null) manageConn2.close(); } catch (SQLException e) { }
                }
            }
        %>

        <button class="btn btn-secondary mt-3" onclick="window.location.href='../admin/manageService.jsp';">Back</button>
    </div>
</body>
</html>






