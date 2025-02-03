<!-- filepath: /c:/Users/ong41/OneDrive/Documents/JAD_CA1/main/webapp/admin/editService.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dbaccess.Service" %>
<%@ page import="dbaccess.ServiceDAO" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Service</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@ include file="../web_elements/navbar.jsp"%>

    <div class="container mt-5">
        <h1 class="mb-4">Edit Service</h1>

        <%
        String errorMessage = "";
        String successMessage = "";
        int serviceId = Integer.parseInt(request.getParameter("id"));
        Service service = null;

        try {
            ServiceDAO serviceDAO = new ServiceDAO();
            service = serviceDAO.getServiceById(serviceId);
        } catch (SQLException e) {
            errorMessage = "Error retrieving service: " + e.getMessage();
            e.printStackTrace();
        }

        if (service != null) {
        %>
            <!-- Form for Editing Service -->
            <div class="box">
                <h3>[POST] Service::Edit</h3>
                <form action="<%=request.getContextPath()%>/EditServiceServlet" method="POST">
                    <input type="hidden" name="id" value="<%= service.getId() %>" />
                    <div>
                        <label for="categoryId">Category ID:</label>
                        <input type="number" id="categoryId" name="categoryId" value="<%= service.getCategoryId() %>" required />
                    </div>
                    <div>
                        <label for="serviceName">Service Name:</label>
                        <input type="text" id="serviceName" name="serviceName" value="<%= service.getServiceName() %>" required />
                    </div>
                    <div>
                        <label for="description">Description:</label>
                        <input type="text" id="description" name="description" value="<%= service.getDescription() %>" required />
                    </div>
                    <div>
                        <label for="price">Price:</label>
                        <input type="number" id="price" name="price" step="0.01" value="<%= service.getPrice() %>" required />
                    </div>
                    <div>
                        <label for="img">Image URL:</label>
                        <input type="text" id="img" name="img" value="<%= service.getImg() %>" required />
                    </div>
                    <div>
                        <input type="submit" value="Update Service" class="btn btn-primary" />
                    </div>
                </form>
            </div>
        <%
        } else {
            out.print("<p style='color:red;'>ERROR: Service not found!</p>");
        }
        %>

        <!-- Back Button -->
        <button class="btn btn-secondary mt-3" onclick="window.location.href='<%=request.getContextPath()%>/admin/manageService.jsp';">Back</button>
    </div>

    <%@ include file="../web_elements/footer.html"%>
</body>
</html>