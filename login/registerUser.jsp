<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Get form parameters
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    // Check if any fields are empty
    if (name == null || name.isEmpty() || password == null || password.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
        response.sendRedirect("login.jsp?error=100"); // Redirect if any fields are missing
    } else if (!password.equals(confirmPassword)) {
        // Check if passwords match
        response.sendRedirect("login.jsp?error=passwordMismatch");
    } else {
        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Define connection URL
            String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC";

            // Establish connection to URL
            Connection conn = DriverManager.getConnection(connURL);

            // Check if a user with the same name already exists
            String checkQuery = "SELECT * FROM member WHERE name = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, name);
            ResultSet checkRs = checkStmt.executeQuery();

            if (checkRs.next()) {
                // User already exists
                response.sendRedirect("login.jsp?error=userExists");
            } else {
                // Insert new user into the database with role "user"
                String insertQuery = "INSERT INTO member (name, password, role) VALUES (?, ?, 'user')";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, name);
                insertStmt.setString(2, password);
                
                int rowsAffected = insertStmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Successful registration
                    response.sendRedirect("login.jsp?success=1");
                } else {
                    // Registration failed
                    response.sendRedirect("login.jsp?error=registrationFailed");
                }

                insertStmt.close();
            }

            // Close resources
            checkRs.close();
            checkStmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=unknown");
        }
    }
%>

