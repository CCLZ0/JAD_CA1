<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="java.sql.*" %>

<%
    // Get email and password from the form
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
        // Redirect with error code if email or password is empty
        response.sendRedirect("login.jsp?error=101");
    } else {
        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Define connection URL
            String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC";

            // Establish connection to URL
            Connection conn = DriverManager.getConnection(connURL);

            // Query to retrieve the user based on email
            String query = "SELECT * FROM user WHERE email = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            
            pstmt.setString(1, email);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // User found, retrieve stored hashed password
                String storedHashedPassword = rs.getString("password");
				int userId = rs.getInt("id");
				String userRole = rs.getString("role");
                // Compare the entered password with the stored hashed password using BCrypt
                if (BCrypt.checkpw(password, storedHashedPassword)) {
                    // Password matches, proceed with login
                    session.setAttribute("userId", userId);
                    session.setAttribute("userRole", userRole);
                    response.sendRedirect("../user/index.jsp");
                } else {
                    // Invalid password
                    response.sendRedirect("login.jsp?error=invalidLogin");
                }
            } else {
                // User not found
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

