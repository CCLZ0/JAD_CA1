<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <% 
        // Use the implicit session object directly
        if (session != null) {
            // Invalidate the session to log out the user
            session.invalidate();
        }

        // Redirect to login page or home page after logout
        response.sendRedirect("../login/login.jsp");
    %>
</body>
</html>
