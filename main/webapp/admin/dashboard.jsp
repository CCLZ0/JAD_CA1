<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="../auth/checkAdmin.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Administrator Dashboard</title>
<link
	href="https://fonts.googleapis.com/css2?family=Recursive&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" type="text/css" href="../css/dashboard.css">
</head>
<body>
	<%@ include file="../web_elements/navbar.jsp"%>

	<div class="specialContainer mt-5">
		<h1 class="mb-4">Administrator Dashboard</h1>
		<div class="d-flex justify-content-center gap-3 mt-4">
			<a href="manageService.jsp" class="btn btn-primary">Manage Services</a> 
			<a href="#" class="btn btn-primary">Manage Bookings (WIP)</a>
			<a href="manageUser.jsp" class="btn btn-primary">Manage Users</a>
		</div>
		<h2>Average rating of each Service</h2>
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th>Service Name</th>
					<th>Description</th>
					<th>Average Rating</th>
				</tr>
			</thead>
			<tbody>
				<%
                    try (Connection ratingConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root123&serverTimezone=UTC")) {
                        String sql = "SELECT s.service_name, s.description, IFNULL(AVG(f.rating), 0) AS average_rating " +
                                     "FROM service s " +
                                     "LEFT JOIN feedback f ON s.id = f.service_id " +
                                     "GROUP BY s.id " +
                                     "ORDER BY s.service_name";
                        try (PreparedStatement stmt = ratingConn.prepareStatement(sql);
                             ResultSet rs = stmt.executeQuery()) {
                             while (rs.next()) {
                                 String serviceName = rs.getString("service_name");
                                 String description = rs.getString("description");
                                 double averageRating = rs.getDouble("average_rating");
                %>
				<tr>
					<td><%= serviceName %></td>
					<td><%= description %></td>
					<td><%= averageRating %></td>
				</tr>
				<%
                             }
                        }
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='3'>Error fetching data: " + e.getMessage() + "</td></tr>");
                    }
                %>
			</tbody>
		</table>
	</div>

	<h2 id="header2">Number of bookings for each Service</h2>
	<div class="d-flex justify-content-center">
		<canvas id="servicePieChart"></canvas>
	</div>

	<% 
            String sqlBookings = "SELECT s.service_name, COUNT(b.id) AS booking_count " +
                                 "FROM service s " +
                                 "LEFT JOIN booking b ON s.id = b.service_id " +
                                 "GROUP BY s.id " +
                                 "ORDER BY booking_count DESC";
            StringBuilder labels = new StringBuilder();
            StringBuilder data = new StringBuilder();

            try (Connection bookingConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root123&serverTimezone=UTC");
                 PreparedStatement stmt = bookingConn.prepareStatement(sqlBookings);
                 ResultSet rs = stmt.executeQuery()) {

                boolean isFirst = true;
                while (rs.next()) {
                    String serviceName = rs.getString("service_name");
                    int bookingCount = rs.getInt("booking_count");

                    if (!isFirst) {
                        labels.append(",");
                        data.append(",");
                    }
                    labels.append("'").append(serviceName).append("'");
                    data.append(bookingCount);

                    isFirst = false;
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Error fetching booking data: " + e.getMessage() + "</div>");
            }
        %>

	<script>
		// Pie Chart Data
		const ctx = document.getElementById('servicePieChart').getContext('2d');
		new Chart(ctx, {
			type : 'pie',
			data : {
				labels : [
	<%= labels.toString() %>
		], // Service names
				datasets : [ {
					label : 'Bookings',
					data : [
	<%= data.toString() %>
		], // Booking counts
					backgroundColor : [ 'rgba(255, 99, 132, 0.7)',
							'rgba(54, 162, 235, 0.7)',
							'rgba(255, 206, 86, 0.7)',
							'rgba(75, 192, 192, 0.7)',
							'rgba(153, 102, 255, 0.7)',
							'rgba(255, 159, 64, 0.7)' ],
					borderColor : [ 'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
							'rgba(255, 159, 64, 1)' ],
					borderWidth : 1
				} ]
			},
			options : {
				responsive : true,
				maintainAspectRatio : true, // Ensures that the chart scales proportionally
				plugins : {
					legend : {
						position : 'top',
					},
					tooltip : {
						enabled : true
					}
				}
			}
		});
	</script>
	<%@ include file="../web_elements/footer.jsp"%>
</body>
</html>








