<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Cart Item</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("../login/login.jsp?error=notLoggedIn");
        } else {
            String cartId = request.getParameter("id");
            if (cartId == null) {
                response.sendRedirect("../user/cart.jsp");
            } else {
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC")) {
                    String sql = "DELETE FROM cart WHERE id = ? AND user_id = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setInt(1, Integer.parseInt(cartId));
                        stmt.setInt(2, userId);
                        stmt.executeUpdate();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                response.sendRedirect("../user/cart.jsp");
            }
        }
    %>
</body>
</html>