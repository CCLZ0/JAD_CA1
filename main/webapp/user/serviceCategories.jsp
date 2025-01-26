<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Service Categories</title>
<link
	href="https://fonts.googleapis.com/css2?family=Recursive&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%@ include file="../web_elements/navbar.jsp"%>

	<div class="container mt-5">
		<h2>Service Categories</h2>
		<div class="row">
			<%
			Connection serviceCatConn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				String serviceCatConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root123&serverTimezone=UTC";
				conn = DriverManager.getConnection(connURL);

				String sql = "SELECT id, category_name, description FROM service_category";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

					while (rs.next()) {
						int categoryId = rs.getInt("id");
						String categoryName = rs.getString("category_name");
						String description = rs.getString("description");
				%>
				<div class="col-md-4 mb-4">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title"><%=categoryName%></h5>
							<p class="card-text"><%=description%></p>
							<a href="services.jsp?categoryId=<%=categoryId%>"
								class="btn btn-primary btn-custom">Related Services</a>
						</div>
					</div>
				</div>
				<%
				}
			} catch (Exception e) {
				e.printStackTrace();
				%>
				<div class="alert alert-danger">
					An error occurred while fetching service categories:
					<%=e.getMessage()%>
				</div>
				<%
			} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			%>
		</div>
	</div>
	<%@ include file="../web_elements/footer.html"%>
</body>
</html>