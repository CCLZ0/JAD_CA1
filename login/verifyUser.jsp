<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Get name and password from the form
    String name = request.getParameter("name");
    String password = request.getParameter("password");

    if (name == null || name.isEmpty() || password == null || password.isEmpty()) {
        // Redirect with error code if name or password is empty
        response.sendRedirect("login.jsp?error=101");
    } else {
        try {
        	// Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Define connection URL
            String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC";

            // Establish connection to URL
            Connection conn = DriverManager.getConnection(connURL);

            // Query to verify user
            String query = "SELECT * FROM member WHERE name = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // User found, proceed with login
                response.sendRedirect("../user/index.jsp");
            } else {
                // Invalid login
                response.sendRedirect("login.jsp?error=invalidLogin");
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=unknown");
        }
    }
%>
