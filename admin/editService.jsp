<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../auth/checkAdmin.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Service</title>
    <link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Client-side validation
        function validateForm() {
            const serviceName = document.getElementById("serviceName").value;
            const description = document.getElementById("description").value;
            const price = document.getElementById("price").value;
            const categoryId = document.getElementById("categoryId").value;
            const imgPath = document.getElementById("imgPath").value;

            if (serviceName.trim() === "" || description.trim() === "" || price.trim() === "" || categoryId === "" || imgPath.trim() === "") {
                alert("All fields must be filled out.");
                return false; // Prevent form submission
            }

            // Check for valid price
            if (isNaN(price) || price <= 0) {
                alert("Please enter a valid price greater than 0.");
                return false;
            }

            return true; // Allow form submission
        }
    </script>
</head>
<body>
    <%@ include file="../web_elements/navbar.jsp" %>
    
    <div class="container mt-4">
        <h1>Edit Service</h1>

        <% 
            Connection manageConn = null;
            PreparedStatement manageStmt = null;
            ResultSet manageRs = null;
            int serviceId = Integer.parseInt(request.getParameter("id"));
            String serviceName = "";
            String description = "";
            double price = 0.0;
            int categoryId = 0;
            String imgPath = "";
            String successMessage = "";
            String errorMessage = "";

            // Fetch service details to pre-fill the form
            try {
                manageConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC");
                String sql = "SELECT * FROM service WHERE id = ?";
                manageStmt = manageConn.prepareStatement(sql);
                manageStmt.setInt(1, serviceId);
                manageRs = manageStmt.executeQuery();

                if (manageRs.next()) {
                    serviceName = manageRs.getString("service_name");
                    description = manageRs.getString("description");
                    price = manageRs.getDouble("price");
                    categoryId = manageRs.getInt("category_id");
                    imgPath = manageRs.getString("img");
                }
            } catch (Exception e) {
                errorMessage = "Error fetching service details: " + e.getMessage();
                e.printStackTrace();
            } finally {
                try { if (manageRs != null) manageRs.close(); } catch (SQLException e) { }
                try { if (manageStmt != null) manageStmt.close(); } catch (SQLException e) { }
                try { if (manageConn != null) manageConn.close(); } catch (SQLException e) { }
            }
        %>

        <!-- Success or Error Message -->
        <%
            if (!successMessage.isEmpty()) {
        %>
            <div class="alert alert-success">
                <%= successMessage %>
            </div>
        <%
            }
            if (!errorMessage.isEmpty()) {
        %>
            <div class="alert alert-danger">
                <%= errorMessage %>
            </div>
        <%
            }
        %>

        <form action="editService.jsp" method="post" onsubmit="return validateForm();">
            <input type="hidden" name="id" value="<%= serviceId %>">

            <div class="mb-3">
                <label for="serviceName" class="form-label">Service Name:</label>
                <input type="text" id="serviceName" name="serviceName" class="form-control" value="<%= serviceName %>" required>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <textarea id="description" name="description" class="form-control" required><%= description %></textarea>
            </div>

            <div class="mb-3">
                <label for="price" class="form-label">Price:</label>
                <input type="number" id="price" name="price" class="form-control" value="<%= price %>" step="0.01" required>
            </div>

            <div class="mb-3">
                <label for="categoryId" class="form-label">Category:</label>
                <select id="categoryId" name="categoryId" class="form-select" required>
                    <%
                        // Fetch categories from the database
                        try {
                            manageConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC");
                            String categoryQuery = "SELECT id, category_name FROM service_category";
                            manageStmt = manageConn.prepareStatement(categoryQuery);
                            manageRs = manageStmt.executeQuery();
                            while (manageRs.next()) {
                                int catId = manageRs.getInt("id");
                                String catName = manageRs.getString("category_name");
                                String selected = (catId == categoryId) ? "selected" : "";
                                out.println("<option value='" + catId + "' " + selected + ">" + catName + "</option>");
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
            <div class="mb-3">
                <label for="imgPath" class="form-label">Image Path:</label>
                <input type="text" id="imgPath" name="imgPath" class="form-control" value="<%= imgPath %>" required>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary">Update Service</button>
        </form>

        <% 
            // If form is submitted, update the service details
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                serviceName = request.getParameter("serviceName");
                description = request.getParameter("description");
                price = Double.parseDouble(request.getParameter("price"));
                categoryId = Integer.parseInt(request.getParameter("categoryId"));
                Connection manageConn2 = null;
                PreparedStatement pstmt = null;

                try {
                    // Connect to the database
                    manageConn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC");

                    // Update service details in the database
                    String sql = "UPDATE service SET service_name = ?, description = ?, price = ?, category_id = ? WHERE id = ?";
                    pstmt = manageConn2.prepareStatement(sql);
                    pstmt.setString(1, serviceName);
                    pstmt.setString(2, description);
                    pstmt.setDouble(3, price);
                    pstmt.setInt(4, categoryId);
                    pstmt.setInt(5, serviceId);
                    pstmt.executeUpdate();
                    
                    successMessage = "Service updated successfully!";
                } catch (Exception e) {
                    errorMessage = "Error updating service: " + e.getMessage();
                    e.printStackTrace();
                } finally {
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
                    try { if (manageConn2 != null) manageConn2.close(); } catch (SQLException e) { }
                }
            }
        %>

        <!-- Redirect to manageService.jsp if update is successful -->
        <script type="text/javascript">
            <% if (!successMessage.isEmpty()) { %>
                window.location.href = '../admin/manageService.jsp';
            <% } %>
        </script>

        <!-- Back Button -->
        <button class="btn btn-secondary mt-3" onclick="window.location.href='../admin/manageService.jsp';">Back</button>
    </div>
    <%@ include file="../web_elements/footer.html"%>
</body>
</html>




