<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/navbar.css">
</head>
<body>
<%@page import="java.sql.*"%>
<%  
    // Check if userId is stored in the session
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = null;
	String userRole = null;
    if (userId != null) {
        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Define connection URL
            String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";

            // Establish connection to URL
            Connection conn = DriverManager.getConnection(connURL);

            // Query to retrieve the user based on userId
            String query = "SELECT name, role FROM user WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // User found, retrieve the name
                userName = rs.getString("name");
                userRole = rs.getString("role");
                System.out.println(userRole);
            }
			
            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
	<header>
		<nav class="navbar navbar-expand-lg">		        
	    	<a class="navbar-brand" href="../user/index.jsp" id="icon">
	        	<img src="../img/logo.png" alt="icon" id="webicon">
	        </a>
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	        	<span class="navbar-toggler-icon"></span>
	        </button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto">
	               	<li class="nav-item">
	                	<a class="nav-link nav_item" href="../user/services.jsp">Services</a>
	               	</li>
	                <% if (userId != null) { %>
	                	<% if (userRole.equals("admin")) { %>
	                		<li class="nav-item">
			                	<a class="nav-link nav_item" href="../admin/dashboard.jsp">Admin dashboard</a>
			                </li>
			                <li class="nav-item dropdown">
				            	<a class="nav-link nav_item dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"><%= userName %></a>
				                <ul class="dropdown-menu">
					            	<li><a class="nav-item dropdown-item" href="../login/logout.jsp">Logout</a>
				                </ul>
				            </li>		                
	                	<%} else if(userRole.equals("member")){%>
		                	<li class="nav-item">
			                	<a class="nav-link nav_item" href="../user/bookingHistory.jsp">Booking History</a>
			                </li>
			                <li class="nav-item">
			                	<a class="nav-link nav_item" href="../user/bookings.jsp">Cart</a>
			                </li>
			                <li class="nav-item dropdown">
				            	<a class="nav-link nav_item dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"><%= userName %></a>
				                	<ul class="dropdown-menu">
					                    <li><a class="nav-item dropdown-item" href="../user/profile.jsp">Profile</a></li>
					                    <li><a class="nav-item dropdown-item" href="../user/feedback.jsp">Feedback</a></li>
					                    <li><a class="nav-item dropdown-item" href="../login/logout.jsp">Logout</a>
				                	</ul>
				            </li>
	                	<%} %>
	                <% } else { %>
	                    <li class="nav-item">
	                        <a class="nav-link nav_item" href="../login/login.jsp">Login/Sign up</a>
	                    </li>
	                <% } %>
				</ul>
			</div>
	    </nav>
	</header>	
</body>
</html>
