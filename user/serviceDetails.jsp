<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Service Details</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="../web_elements/navbar.jsp" %>

<div class="container mt-5">
    <%
        String serviceId = request.getParameter("serviceId");
        
        if (serviceId != null && serviceId.matches("\\d+")) {
            Connection serviceConn = null;
            PreparedStatement servicePstmt = null;
            ResultSet serviceRs = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String serviceConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
                serviceConn = DriverManager.getConnection(serviceConnURL);
                
                String sql = "SELECT s.*, sc.category_name " +
                           "FROM service s " +
                           "INNER JOIN service_category sc ON s.category_id = sc.id " +
                           "WHERE s.id = ?";
                           
                servicePstmt = serviceConn.prepareStatement(sql);
                servicePstmt.setInt(1, Integer.parseInt(serviceId));
                serviceRs = servicePstmt.executeQuery();
                
                if (serviceRs.next()) {
                    String serviceName = serviceRs.getString("service_name");
                    String serviceDescription = serviceRs.getString("description");
                    double servicePrice = serviceRs.getDouble("price");
                    String categoryName = serviceRs.getString("category_name");
                    %>
                    <h2>Service Details</h2>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= serviceName %></h5>
                            <p class="card-text"><%= serviceDescription %></p>
                            <p class="card-text">Category: <%= categoryName %></p>
                            <p class="card-text">Price: $<%= servicePrice %></p>
                            <a href="bookService.jsp?serviceId=<%= serviceId %>" class="btn btn-primary">Book Now</a>
                        </div>
                    </div>
                    <%
                } else {
                    %>
                    <div class="alert alert-warning" role="alert">
                        Service not found.
                    </div>
                    <%
                }
            } catch (Exception e) {
                %>
                <div class="alert alert-danger" role="alert">
                    An error occurred while fetching service details: <%= e.getMessage() %>
                </div>
                <%
                e.printStackTrace();
            } finally {
                if (serviceRs != null) try { serviceRs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (servicePstmt != null) try { servicePstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (serviceConn != null) try { serviceConn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        } else {
            %>
            <div class="alert alert-danger" role="alert">
                Invalid service ID.
            </div>
            <%
        }
    %>
</div>
</body>
</html>