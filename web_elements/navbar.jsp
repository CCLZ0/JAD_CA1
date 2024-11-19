<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/navbar.css">
</head>
<body>
<%@page import="java.sql.*, java.util.ArrayList"%>
<%
    // Initialize an ArrayList to store categories
    ArrayList<String[]> categories = new ArrayList<>();
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = null;
    String userRole = null;
    
    // Load JDBC Driver
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	// Define connection URL
	String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
	
	// Establish connection to URL
	Connection conn = DriverManager.getConnection(connURL);
	try{
	    // Query to retrieve categories
	    String categoryQuery = "SELECT id, category_name FROM service_category";
	    PreparedStatement categoryPstmt = conn.prepareStatement(categoryQuery);
	
	    ResultSet categoryRs = categoryPstmt.executeQuery();
	    while (categoryRs.next()) {
	        // Store each category as a String array [id, category_name]
	        categories.add(new String[]{String.valueOf(categoryRs.getInt("id")), categoryRs.getString("category_name")});
	    }
	    System.out.println("Categories fetched:");
	    for (String[] category : categories) {
	        System.out.println("ID: " + category[0] + ", Name: " + category[1]);
	    }
	
	    categoryRs.close();
	    categoryPstmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
	
    if (userId != null) {
        try {
            // Query to retrieve user information
            String userQuery = "SELECT name, role FROM user WHERE id = ?";
            PreparedStatement userPstmt = conn.prepareStatement(userQuery);
            userPstmt.setInt(1, userId);

            ResultSet userRs = userPstmt.executeQuery();
            if (userRs.next()) {
                userName = userRs.getString("name");
                userRole = userRs.getString("role");
            }
            userRs.close();
            userPstmt.close();
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
	            <li class="nav-item dropdown">
                    <a class="nav-link nav_item dropdown-toggle" href="#" id="servicesDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Services
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="servicesDropdown">
                        <% 
                        // Iterate through the ArrayList and generate dropdown items
                        for (String[] category : categories) { 
                        %>
                            <li>
                                <a class="dropdown-item" href="../user/services.jsp?categoryId=<%= category[0] %>">
                                    <%= category[1] %>
                                </a>
                            </li>
                        <% 
                        } 
                        %>
                    </ul>
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
			                	<a class="nav-link nav_item" href="../user/cart.jsp">Cart</a>
			                </li>
			                <li class="nav-item dropdown">
				            	<a class="nav-link nav_item dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"><%= userName %></a>
				                	<ul class="dropdown-menu dropdown-menu-end">
					                    <li><a class="nav-item dropdown-item" href="../user/profile.jsp">Profile</a></li>
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
