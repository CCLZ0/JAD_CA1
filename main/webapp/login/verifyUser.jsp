<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.User" %>
<%@ page import ="models.UserDAO" %>

<%
    // Get email and password from the form
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
        // Redirect with error code if email or password is empty
        response.sendRedirect("login.jsp?error=101");
    } else {
        UserDAO userDAO = new UserDAO();
        User user = userDAO.verifyUser(email, password);

        if (user != null) {
            // Login successful, set User bean in session
            session.setAttribute("user", user);
            response.sendRedirect("../user/index.jsp");
        } else {
            // Invalid login
            response.sendRedirect("login.jsp?error=invalidLogin");
        }
    }
%>
 --%>