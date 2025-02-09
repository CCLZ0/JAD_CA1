<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.myshop.b2bwebsite.dbaccess.Service"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container">
		<h1>Welcome to B2B Service Management System</h1>
		<form action="${pageContext.request.contextPath}/b2b/logout"
			method="post">
			<button type="submit" class="btn btn-primary">Logout</button>
		</form>

		<h2 class="mt-5">Add New Service</h2>
		<form action="${pageContext.request.contextPath}/b2b/service"
			method="post">
			<div class="form-group">
				<label for="categoryId">Category ID:</label> <input type="number"
					class="form-control" id="categoryId" name="categoryId" required>
			</div>
			<div class="form-group">
				<label for="serviceName">Service Name:</label> <input type="text"
					class="form-control" id="serviceName" name="serviceName" required>
			</div>
			<div class="form-group">
				<label for="description">Description:</label> <input type="text"
					class="form-control" id="description" name="description" required>
			</div>
			<div class="form-group">
				<label for="price">Price:</label> <input type="number"
					class="form-control" id="price" name="price" step="0.01" required>
			</div>
			<div class="form-group">
				<label for="img">Image URL:</label> <input type="text"
					class="form-control" id="img" name="img" required>
			</div>
			<button type="submit" class="btn btn-primary">Add Service</button>
		</form>

		<h2 class="mt-5">Services by Category</h2>
		<form
			action="${pageContext.request.contextPath}/b2b/services/category/1"
			method="get">
			<button type="submit" class="btn btn-primary">Get Services
				for Category 1</button>
		</form>
		<form
			action="${pageContext.request.contextPath}/b2b/services/category/2"
			method="get">
			<button type="submit" class="btn btn-primary">Get Services
				for Category 2</button>
		</form>
		<form
			action="${pageContext.request.contextPath}/b2b/services/category/3"
			method="get">
			<button type="submit" class="btn btn-primary">Get Services
				for Category 3</button>
		</form>

		<table id="servicesTable" class="table table-striped mt-3">
			<thead>
				<tr>
					<th>Service Name</th>
					<th>Description</th>
					<th>Price</th>
					<th>Category ID</th>
				</tr>
			</thead>
			<tbody>
				<%
                List<Service> services = (List<Service>) request.getAttribute("services");
                if (services != null) {
                    for (Service service : services) {
            %>
				<tr>
					<td><%= service.getServiceName() %></td>
					<td><%= service.getDescription() %></td>
					<td><%= service.getPrice() %></td>
					<td><%= service.getCategoryId() %></td>
					<td>
                        <a href="${pageContext.request.contextPath}/editService?id=<%= service.getId() %>" class="btn btn-primary">Edit</a>
                    </td>
				</tr>
				<%
                    }
                }
            %>
			</tbody>
		</table>

	</div>
</body>
</html>