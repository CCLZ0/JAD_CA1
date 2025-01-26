<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="java.sql.*" %>

<%
    String username = request.getParameter("username2");
    String email = request.getParameter("email2");
    String password = request.getParameter("password2");
    String confirmPassword = request.getParameter("confirmPassword2");

    // Debugging output (You can remove this after debugging)
    System.out.println("Username: " + username);
    System.out.println("Email: " + email);
    System.out.println("Password: " + password);
    System.out.println("Confirm Password: " + confirmPassword);

    if (!password.equals(confirmPassword)) {
        response.sendRedirect("login.jsp?error=passwordMismatch"); // Redirect if passwords don't match
    } else  if (password == null || password.length() <= 4) {
        request.getRequestDispatcher("login.jsp?error=passwordTooShort").forward(request, response);
    } else {
        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Define connection URL for MySQL
            String connURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root123&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);

            // Check if a user with the same email already exists
            String checkQuery = "SELECT COUNT(*) FROM user WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, email);
            ResultSet checkRs = checkStmt.executeQuery();

            checkRs.next(); // Move the cursor to the first row
            int count = checkRs.getInt(1); // Get the count of rows with the same email

            if (count > 0) {
                // If email already exists
                response.sendRedirect("login.jsp?error=emailExists");
                return;
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







