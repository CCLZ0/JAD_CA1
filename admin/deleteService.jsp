<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root&serverTimezone=UTC");
        String sql = "DELETE FROM service WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        response.sendRedirect("manageService.jsp");
    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
    }
%>
