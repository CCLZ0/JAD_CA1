<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.ArrayList,java.util.List"%>
<%
	// Get the search query from the request
	String query = request.getParameter("query");
	// Connect to the database
	Class.forName("com.mysql.cj.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);
	// Prepare the SQL query
	String sql = "SELECT service_name FROM service";
	if (!query.isEmpty()) {
	sql += " WHERE service_name LIKE ?";
	}
	PreparedStatement stmt = conn.prepareStatement(sql);
	if (!query.isEmpty()) {
	stmt.setString(1, query + "%");
	}
	// Execute the query and get the results
	ResultSet rs = stmt.executeQuery();
	// Create a list to store the suggested services
	List<String> suggestions = new ArrayList<>();
	// Loop through the results and add the service names to the suggestions list
	while (rs.next()) {
	suggestions.add(rs.getString("service_name"));
	}
	// Close the database connection
	rs.close();
	stmt.close();
	conn.close();
	// Write the suggested service names as a JSON array
	response.setContentType("text/plain");
	response.setCharacterEncoding("UTF-8");
	if(suggestions.isEmpty()){
		response.getWriter().write("No matching results");
	}else{
		response.getWriter().write(String.format("%s", String.join("\n", suggestions.stream().toArray(String[]::new))));
	}
	
%>