<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Cart Item</title>
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
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String cartId = request.getParameter("cartId");
        String bookingTime = request.getParameter("bookingTime");
        String remarks = request.getParameter("remarks");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root123&serverTimezone=UTC")) {
            String sql = "UPDATE cart SET booking_time = ?, remarks = ? WHERE id = ? AND user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, bookingTime);
                stmt.setString(2, remarks);
                stmt.setInt(3, Integer.parseInt(cartId));
                stmt.setInt(4, userId);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("../user/cart.jsp");
        return;
    }

    String cartId = request.getParameter("id");
    if (cartId == null) {
        response.sendRedirect("../user/cart.jsp");
        return;
    }

    String serviceName = "";
    String bookingTime = "";
    String remarks = "";

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=root123&serverTimezone=UTC")) {
        String sql = "SELECT s.service_name, c.booking_time, c.remarks FROM cart c JOIN service s ON c.service_id = s.id WHERE c.id = ? AND c.user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(cartId));
            stmt.setInt(2, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    serviceName = rs.getString("service_name");
                    bookingTime = rs.getString("booking_time");
                    remarks = rs.getString("remarks");
                } else {
                    response.sendRedirect("../user/cart.jsp");
                    return;
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<div class="container mt-5">
    <h1>Edit Cart Item</h1>
    <form action="editCart.jsp" method="post">
        <input type="hidden" name="cartId" value="<%= cartId %>">
        <div class="mb-3">
            <label for="serviceName" class="form-label">Service Name</label>
            <input type="text" class="form-control" id="serviceName" name="serviceName" value="<%= serviceName %>" readonly>
        </div>
        <div class="mb-3">
            <label for="bookingTime" class="form-label">Booking Time</label>
            <input type="datetime-local" class="form-control" id="bookingTime" name="bookingTime" value="<%= bookingTime %>" required>
        </div>
        <div class="mb-3">
            <label for="remarks" class="form-label">Remarks</label>
            <textarea class="form-control" id="remarks" name="remarks" rows="3"><%= remarks %></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
    </form>
</div>
</body>
</html>