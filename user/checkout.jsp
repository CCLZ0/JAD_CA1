<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

   <%
        Integer userId = (Integer) session.getAttribute("userId");
        boolean success = false;
        String errorMessage = null;

        if (userId == null) {
            response.sendRedirect("../login/login.jsp?error=notLoggedIn");
        } else {
            String[] cartIds = request.getParameterValues("cartIds");
            String cartIdCondition = "";

            if (cartIds != null && cartIds.length > 0) {
                cartIdCondition = " AND id IN (" + String.join(",", cartIds) + ")";
            }

            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC")) {
                // Move data from cart to booking table and set status to "Incomplete"
                String sql = "INSERT INTO booking (member_id, service_id, booking_date, remarks, status) " +
                             "SELECT user_id, service_id, booking_time, remarks, (SELECT id FROM status WHERE status_name = 'Incomplete') " +
                             "FROM cart WHERE user_id = ?" + cartIdCondition;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, userId);
                    int rowsInserted = stmt.executeUpdate();
                    if (rowsInserted > 0) {
                        success = true;
                    } else {
                        errorMessage = "No items in the cart to checkout.";
                    }
                }

                if (success) {
                    // Clear the selected items from the cart
                    sql = "DELETE FROM cart WHERE user_id = ?" + cartIdCondition;
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setInt(1, userId);
                        stmt.executeUpdate();
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                errorMessage = "An error occurred during the checkout process: " + e.getMessage();
            }

            if (success) {
                response.sendRedirect("bookingConfirmation.jsp");
            }
        }
    %>

    <% if (!success) { %>
        <div class="alert alert-danger">
            <%= errorMessage %>
        </div>
        <a href="cart.jsp" class="btn btn-primary">Return to Cart</a>
    <% } %>

</body>
</html>