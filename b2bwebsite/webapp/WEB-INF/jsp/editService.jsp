<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myshop.b2bwebsite.dbaccess.Service"%>
<%@ page import="com.myshop.b2bwebsite.dbaccess.ServiceDAO"%>
<%@ page import="java.sql.SQLException" %>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Service</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1>Edit Service</h1>
    <form action="${pageContext.request.contextPath}/b2b/service/<%=serviceId%>" method="post">
        <input type="hidden" name="_method" value="put">
        <div class="form-group">
            <label for="categoryId">Category ID:</label>
            <input type="number" class="form-control" id="categoryId" name="categoryId" value="<%=service.getCategoryId()%>" required>
        </div>
        <div class="form-group">
            <label for="serviceName">Service Name:</label>
            <input type="text" class="form-control" id="serviceName" name="serviceName" value="<%=service.getServiceName()%>" required>
        </div>
        <div class="form-group">
            <label for="description">Description:</label>
            <input type="text" class="form-control" id="description" name="description" value="<%=service.getDescription()%>" required>
        </div>
        <div class="form-group">
            <label for="price">Price:</label>
            <input type="number" class="form-control" id="price" name="price" step="0.01" value="<%=service.getPrice()%>" required>
        </div>
        <div class="form-group">
            <label for="img">Image URL:</label>
            <input type="text" class="form-control" id="img" name="img" value="<%=service.getImg()%>" required>
        </div>
        <button type="submit" class="btn btn-primary">Update Service</button>
    </form>
</div>
</body>
</html>