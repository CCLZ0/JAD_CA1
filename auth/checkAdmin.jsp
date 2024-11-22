<%@ page language="java" pageEncoding="UTF-8" import="java.sql.*" %>
<%
    //Retrieve userId from session
    Integer userIdcheck = (Integer) session.getAttribute("userId");

    if (userIdcheck == null) {
        // Redirect to login if the user is not logged in
        out.println("<script>alert('You need to log in first!'); window.location='../login/login.jsp';</script>");
        return;
    }

    Connection roleConn = null;
    PreparedStatement roleStmt = null;
    ResultSet roleRs = null;

    try {
        // Database connection setup
        Class.forName("com.mysql.cj.jdbc.Driver");
        String roleConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC";
        roleConn = DriverManager.getConnection(roleConnURL);

        // Query to get the role of the logged-in user
        String sql = "SELECT role FROM user WHERE id = ?";
        roleStmt = roleConn.prepareStatement(sql);
        roleStmt.setInt(1, userIdcheck);

        roleRs = roleStmt.executeQuery();

        if (roleRs.next()) {
            String role = roleRs.getString("role");
            if (!"admin".equals(role)) {
                out.println("<script>alert('You do not have permission to access the admin dashboard.'); window.location='../user/index.jsp';</script>");
                return;
            }
        } else {
            out.println("<script>alert('No user found.'); window.location='../login/login.jsp';</script>");
            return;
        }

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('An error occurred while checking the user role. Please try again.'); window.location='../login/login.jsp';</script>");
        return;
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('An unexpected error occurred.'); window.location='../login/login.jsp';</script>");
        return;
    } finally {
        try { if (roleRs != null) roleRs.close(); } catch (SQLException e) {}
        try { if (roleStmt != null) roleStmt.close(); } catch (SQLException e) {}
        try { if (roleConn != null) roleConn.close(); } catch (SQLException e) {}
    }
%>

