<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="../web_elements/navbar.jsp" %>

<div class="container mt-5">
    <h1>Your Cart</h1>
    <form action="checkout.jsp" method="post">
        <table class="table">
            <thead>
                <tr>
                    <th>Select</th>
                    <th>Service Name</th>
                    <th>Booking Time</th>
                    <th>Price</th>
                    <th>Remarks</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (userId == null) {
                        response.sendRedirect("../login/login.jsp?error=notLoggedIn");
                    } else {
                        try (Connection cartConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC")) {
                            String sql = "SELECT c.id, s.service_name, c.booking_time, c.price, c.remarks FROM cart c JOIN service s ON c.service_id = s.id WHERE c.user_id = ?";
                            try (PreparedStatement stmt = cartConn.prepareStatement(sql)) {
                                stmt.setInt(1, userId);
                                try (ResultSet rs = stmt.executeQuery()) {
                                    while (rs.next()) {
                                        int cartId = rs.getInt("id");
                                        String serviceName = rs.getString("service_name");
                                        String bookingTime = rs.getString("booking_time");
                                        double price = rs.getDouble("price");
                                        String remarks = rs.getString("remarks");
                %>
                                        <tr>
                                            <td><input type="checkbox" name="cartIds" value="<%= cartId %>"></td>
                                            <td><%= serviceName %></td>
                                            <td><%= bookingTime %></td>
                                            <td><%= price %></td>
                                            <td><%= remarks %></td>
                                            <td>
                                                <a href="../cart/editCart.jsp?id=<%= cartId %>" class="btn btn-warning">Edit</a>
                                                <a href="../cart/deleteCart.jsp?id=<%= cartId %>" class="btn btn-danger">Delete</a>
                                            </td>
                                        </tr>
                <%
                                    }
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
        <button type="submit" class="btn btn-success">Checkout</button>
    </form>
</div>
</body>
</html>