<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../web_elements/navbar.jsp" %>
<html>
<head>
    <title>Services</title>
    <link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="../css/style.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%
        Connection serviceConn = null;
        PreparedStatement servicePstmt = null;
        ResultSet serviceRs = null;
        
        String categoryId = request.getParameter("categoryId");
        
        if (categoryId != null && categoryId.matches("\\d+")) {
            try {
                // Create new connection using the same connection details
                Class.forName("com.mysql.cj.jdbc.Driver");
                String serviceConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
                serviceConn = DriverManager.getConnection(serviceConnURL);
                
                String sql = "SELECT s.*, sc.category_name " +
                           "FROM service s " +
                           "INNER JOIN service_category sc ON s.category_id = sc.id " +
                           "WHERE s.category_id = ?";
                           
                // Create a scrollable ResultSet
                servicePstmt = serviceConn.prepareStatement(sql, 
                    ResultSet.TYPE_SCROLL_INSENSITIVE, 
                    ResultSet.CONCUR_READ_ONLY);
                    
                servicePstmt.setString(1, categoryId);
                serviceRs = servicePstmt.executeQuery();
                
                if (serviceRs.next()) {
                    String categoryName = serviceRs.getString("category_name");
                    // Move cursor back to start
                    serviceRs.beforeFirst();
                    %>
                    <h2>Services in <%= categoryName %></h2>
                    <div class="container">
                        <div class="row">
                        <%
                        while (serviceRs.next()) {
                            %>
                            <div class="col-md-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title"><%= serviceRs.getString("service_name") %></h5>
                                        <p class="card-text"><%= serviceRs.getString("description") %></p>
                                        <p class="card-text">
                                            <small class="text-muted">
                                                Price: $<%= serviceRs.getDouble("price") %>
                                            </small>
                                        </p>
                                        <a href="bookService.jsp?serviceId=<%= serviceRs.getInt("id") %>" class="btn btn-primary">Book Now</a>
                                         <a href="serviceDetails.jsp?serviceId=<%= serviceRs.getInt("id") %>" class="btn btn-primary">More Details</a>
                                    </div>
                                </div>
                            </div>
                            <%
                        }
                        %>
                        </div>
                    </div>
                    <%
                } else {
                    %>
                    <div class="alert alert-info">
                        No services found in this category.
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
                try { if (serviceRs != null) serviceRs.close(); } catch (SQLException e) { }
                try { if (servicePstmt != null) servicePstmt.close(); } catch (SQLException e) { }
                try { if (serviceConn != null) serviceConn.close(); } catch (SQLException e) { }
            }
        } else {
            %>
            <div class="alert alert-warning">
                Invalid category selected. Please choose a valid category.
            </div>
            <%
        }
    %>
</body>
</html>