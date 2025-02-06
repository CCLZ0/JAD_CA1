<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ include file="../auth/checkAdmin.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link
	href="https://fonts.googleapis.com/css2?family=Recursive&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/dashboard.css"
	rel="stylesheet">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<%@ include file="../web_elements/navbar.jsp"%>

	<div class="container mt-5">
		<h1 class="mb-4">Dashboard</h1>

		<!-- Buttons to Navigate to Manage User and Manage Service -->
		<div class="box">
			<h3>Manage</h3>
			<form action="<%=request.getContextPath()%>/admin/manageUser.jsp"
				method="get">
				<input type="submit" value="Manage User" class="btn btn-secondary" />
			</form>
			<form action="<%=request.getContextPath()%>/admin/manageService.jsp"
				method="get" class="mt-2">
				<input type="submit" value="Manage Service"
					class="btn btn-secondary" />
			</form>
		</div>

		<!-- Button to Show Average Rating -->
		<div class="box">
			<h3>Show Average Rating</h3>
			<form action="<%=request.getContextPath()%>/AverageRatingServlet"
				method="get">
				<input type="hidden" name="action" value="showAverageRating" /> <input
					type="submit" value="Show Average Rating" class="btn btn-primary" />
			</form>
		</div>

		<!-- Button to Show Pie Chart -->
		<div class="box">
			<h3>Show Booking Counts</h3>
			<form action="<%=request.getContextPath()%>/BookingCountServlet"
				method="get">
				<input type="hidden" name="action" value="showBookingCounts" /> <input
					type="submit" value="Show Booking Counts" class="btn btn-primary" />
			</form>
		</div>

		<!-- Button to Show Top 10 Customers by Booking Value -->
		<div class="box">
			<h3>Top 10 Customers by Booking Value</h3>
			<form action="<%=request.getContextPath()%>/GetTopCustomersServlet"
				method="get">
				<input type="hidden" name="action" value="Get Top Customers"
					class="btn btn-primary" /> <input type="submit"
					value="Show Booking Value" class="btn btn-primary" />
			</form>
		</div>

		<!-- Display List of Top 10 Customers by Booking Value -->
		<%
		List<Map<String, Object>> topCustomers = (List<Map<String, Object>>) request.getAttribute("topCustomers");
		if (topCustomers != null) {
		%>
		<div class="box mt-4">
			<h3>Top 10 Customers by Booking Value</h3>
			<table class="table">
				<thead>
					<tr>
						<th>Customer ID</th>
						<th>Customer Name</th>
						<th>Total Booking Value</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> customer : topCustomers) {
					%>
					<tr>
						<td><%=customer.get("customerId")%></td>
						<td><%=customer.get("customerName")%></td>
						<td>$<%=customer.get("totalBookingValue")%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<%
		} else if (request.getAttribute("topCustomers") != null) {
		%>
		<div class="alert alert-info mt-4">No top customers found.</div>
		<%
		}
		%>

		<!-- Display List of Services with Average Rating -->
		<%
		Boolean showAverageRatings = (Boolean) request.getAttribute("showAverageRatings");
		if (showAverageRatings != null && showAverageRatings) {
		%>
		<div class="box">
			<h3>Services with Average Rating</h3>
			<%
			List<Map<String, Object>> servicesData = (List<Map<String, Object>>) request.getAttribute("servicesData");
			if (servicesData != null) {
				if (!servicesData.isEmpty()) {
			%>
			<table class="table">
				<thead>
					<tr>
						<th>Service Name</th>
						<th>Description</th>
						<th>Average Rating</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> service : servicesData) {
						String serviceName = (String) service.get("serviceName");
						String description = (String) service.get("description");
						Double avgRating = (Double) service.get("averageRating");
					%>
					<tr>
						<td><%=serviceName%></td>
						<td><%=description%></td>
						<td><%=avgRating != null ? avgRating : "Not available"%></td>
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
		<%
		}
		%>

		<!-- Pie Chart for Booking Counts -->
		<%
		Boolean showBookingCounts = (Boolean) request.getAttribute("showBookingCounts");
		if (showBookingCounts != null && showBookingCounts) {
		%>
		<div class="box">
			<h3>Booking Counts</h3>
			<canvas id="servicePieChart"></canvas>
			<%
			List<Map<String, Object>> servicesData = (List<Map<String, Object>>) request.getAttribute("servicesData");
			if (servicesData != null && !servicesData.isEmpty()) {
				StringBuilder labels = new StringBuilder();
				StringBuilder data = new StringBuilder();
				boolean isFirst = true;
				for (Map<String, Object> service : servicesData) {
					if (!isFirst) {
				labels.append(",");
				data.append(",");
					}
					labels.append("'").append(service.get("serviceName")).append("'");
					data.append(service.get("bookingCount"));
					isFirst = false;
				}
			%>
			<script>
				const ctx = document.getElementById('servicePieChart')
						.getContext('2d');
				new Chart(ctx, {
					type : 'pie',
					data : {
						labels : [
			<%=labels.toString()%>
				],
						datasets : [ {
							label : 'Bookings',
							data : [
			<%=data.toString()%>
				],
							backgroundColor : [ 'rgba(255, 99, 132, 0.7)',
									'rgba(54, 162, 235, 0.7)',
									'rgba(255, 206, 86, 0.7)',
									'rgba(75, 192, 192, 0.7)',
									'rgba(153, 102, 255, 0.7)',
									'rgba(255, 159, 64, 0.7)' ],
							borderColor : [ 'rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)',
									'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)',
									'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)' ],
							borderWidth : 1
						} ]
					},
					options : {
						responsive : true,
						maintainAspectRatio : true,
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
			<%
			} else {
			%>
			<p>Booking data not available</p>
			<%
			}
			%>
		</div>
		<%
		}
		%>
	</div>
	<%@ include file="../web_elements/footer.html"%>
</body>
</html>

