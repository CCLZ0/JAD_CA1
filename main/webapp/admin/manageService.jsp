<!-- filepath: /c:/Users/ong41/OneDrive/Documents/JAD_CA1/main/webapp/admin/manageService.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dbaccess.Service" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Services</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@ include file="../web_elements/navbar.jsp"%>

    <div class="container mt-5">
        <h1 class="mb-4">Manage Services</h1>

        <!-- Form for Listing All Services -->
        <div class="box">
            <h3>[GET] Service::Show All</h3>
            <form action="<%=request.getContextPath()%>/GetAllServicesServlet">
                <div>
                    <input type="submit" value="List All Services" class="btn btn-primary" />
                </div>
            </form>
        </div>

        <!-- Form for Creating New Service -->
        <div class="box">
            <h3>[POST] Service::Add</h3>
            <form action="<%=request.getContextPath()%>/AddServiceServlet" method="POST">
                <div>
                    <label for="serviceName">Service Name:</label>
                    <input type="text" id="serviceName" name="serviceName" required />
                </div>
                <div>
                    <label for="description">Description:</label>
                    <input type="text" id="description" name="description" required />
                </div>
                <div>
                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" step="0.01" required />
                </div>
                <div>
                    <label for="categoryId">Category ID:</label>
                    <input type="number" id="categoryId" name="categoryId" required />
                </div>
                <div>
                    <label for="img">Image URL:</label>
                    <input type="text" id="img" name="img" required />
                </div>
                <div>
                    <input type="submit" value="Create Service" class="btn btn-primary" />
                </div>
            </form>
        </div>

        <!-- Display Error Message if Service Not Found -->
        <%
        String error = (String) request.getAttribute("err");
        if (error != null && error.equals("NotFound")) {
            out.print("<p style='color:red;'>ERROR: Service not found!</p>");
        }
        %>

        <!-- Display List of Services -->
        <%
        List<Service> services = (List<Service>) request.getAttribute("services");
        if (services != null) {
            if (!services.isEmpty()) {
        %>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Category ID</th>
                            <th>Service Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    for (Service service : services) {
                    %>
                        <tr>
                            <td><%= service.getId() %></td>
                            <td><%= service.getCategoryId() %></td>
                            <td><%= service.getServiceName() %></td>
                            <td><%= service.getDescription() %></td>
                            <td>$<%= service.getPrice() %></td>
                            <td><%= service.getImg() %></td>
                            <td>
                                <a href="<%= request.getContextPath() %>/admin/editService.jsp?id=<%= service.getId() %>" class="btn btn-primary btn-sm">Edit</a>
                                <a href="<%= request.getContextPath() %>/DeleteServiceServlet?id=<%= service.getId() %>" class="btn btn-danger btn-sm">Delete</a>
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
                <div class="alert alert-info">No services found.</div>
            <%
            }
        }
        %>
    </div>

    <%@ include file="../web_elements/footer.html"%>
</body>
</html>
