<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="java.sql.*" %>

<%
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

 	// Debugging output (You can remove this after debugging)
    out.println("Username: " + username);
    out.println("Email: " + email);
    out.println("Password: " + password);
    out.println("Confirm Password: " + confirmPassword);

    // Check for missing data in any of the fields
    if (username == null || username.isEmpty() || email == null || email.isEmpty() || 
        password == null || password.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
        response.sendRedirect("registerUser.jsp?error=100"); // Redirect if fields are missing
    } else if (!password.equals(confirmPassword)) {
        response.sendRedirect("registerUser.jsp?error=passwordMismatch"); // Redirect if passwords don't match
    } else {
        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Define connection URL for MySQL
            String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);

            // Check if a user with the same username or email already exists
            String checkQuery = "SELECT * FROM user WHERE name = ? OR email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, username);
            checkStmt.setString(2, email);
            ResultSet checkRs = checkStmt.executeQuery();

            if (checkRs.next()) {
                // If username or email already exists
                response.sendRedirect("registerUser.jsp?error=userExists");
            } else {
                // Hash the password before storing it
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

                // Insert new user into the database with the hashed password
                String insertQuery = "INSERT INTO user (email, name, password, role) VALUES (?, ?, ?, 'member')";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, email);
                insertStmt.setString(2, username);
                insertStmt.setString(3, hashedPassword);  // Store the hashed password
                int rowsAffected = insertStmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Redirect to login page after successful registration
                    response.sendRedirect("login.jsp?success=1");
                } else {
                    // If registration failed, redirect back with error
                    response.sendRedirect("registerUser.jsp?error=registrationFailed");
                }

                insertStmt.close();
            }

            // Close resources
            checkRs.close();
            checkStmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registerUser.jsp?error=unknown");
        }
    }
%>



