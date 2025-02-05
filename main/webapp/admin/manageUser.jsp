<!-- filepath: /c:/Users/ong41/OneDrive/Documents/JAD_CA1/main/webapp/admin/manageUser.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="dbaccess.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Users</title>
<link
	href="https://fonts.googleapis.com/css2?family=Recursive&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%@ include file="../web_elements/navbar.jsp"%>

	<div class="container mt-5">
		<h1 class="mb-4">Manage Users</h1>

		<!-- Form for Listing All Users -->
		<div class="box">
			<h3>Show All Users</h3>
			<form action="<%=request.getContextPath()%>/GetAllUsersServlet">
				<div>
					<input type="submit" value="List All Users" class="btn btn-primary" />
				</div>
			</form>
		</div>

		<!-- Form for Creating New User -->
		<div class="box">
			<h3>Add User</h3>
			<form action="<%=request.getContextPath()%>/CreateUserServlet"
				method="POST">
				<div>
					<label for="email">email:</label> <input type="email" id="email"
						name="email" required />
				</div>
				<div>
					<label for="userName">Name:</label> <input type="text" id="name"
						name="name" required />
				</div>
				<div>
					<label for="password">Password:</label> <input type="password"
						id="password" name="password" required />
				</div>
				<div>
					<label for="role">Role:</label> <input type="text" id="role"
						name="role" required />
				</div>
				<div>
					<input type="submit" value="Create User" class="btn btn-primary" />
				</div>
			</form>
		</div>

		<!-- Display Error Message if User Not Found -->
		<%
		String error = (String) request.getAttribute("err");
		if (error != null && error.equals("NotFound")) {
			out.print("<p style='color:red;'>ERROR: User not found!</p>");
		}
		%>

		<!-- Display List of Users -->
		<%
		List<User> users = (List<User>) request.getAttribute("users");
		if (users != null) {
			if (!users.isEmpty()) {
		%>
		<h3>Existing Users</h3>
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
				for (User user : users) {
				%>
				<tr>
					<td><%=user.getid()%></td>
					<td><%=user.getEmail()%></td>
					<td><%=user.getName()%></td>
					<td><%=user.getRole()%></td>
					<td><a
						href="<%=request.getContextPath()%>/admin/editUser.jsp?id=<%=user.getid()%>"
						class="btn btn-primary btn-sm">Edit</a> <a
						href="<%=request.getContextPath()%>/DeleteUserServlet?id=<%=user.getid()%>"
						class="btn btn-danger btn-sm">Delete</a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		} else {
		%>
		<div class="alert alert-info">No users found.</div>
		<%
		}
		}
		%>
		<!-- Back Button -->
		<button class="btn btn-secondary mt-3"
			onclick="window.location.href='<%=request.getContextPath()%>/admin/dashboard.jsp';">Back</button>
	</div>

	<%@ include file="../web_elements/footer.html"%>
</body>
</html>