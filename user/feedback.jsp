<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/rating.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="../web_elements/navbar.jsp" %>

<div class="container mt-5">
    <h1>Feedback</h1>
    <%
    if (userId == null) {
        response.sendRedirect("../login/login.jsp?error=notLoggedIn");
        return;
    }
    
        String bookingId = request.getParameter("bookingId");
        if (bookingId == null || !bookingId.matches("\\d+")) {
            response.sendRedirect("bookingHistory.jsp");
            return;
        }

        Connection feedbackConn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String serviceName = "";
        String bookingDate = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String feedbackConnURL = "jdbc:mysql://localhost:3306/ca1?user=root&password=Cclz@hOmeSQL&serverTimezone=UTC";
            conn = DriverManager.getConnection(connURL);

            String sql = "SELECT s.service_name, b.booking_date " +
                         "FROM booking b " +
                         "JOIN service s ON b.service_id = s.id " +
                         "WHERE b.id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(bookingId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                serviceName = rs.getString("service_name");
                bookingDate = rs.getString("booking_date");
            } else {
                response.sendRedirect("bookingHistory.jsp");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <form action="../feedback/submitFeedback.jsp" method="post">
        <input type="hidden" name="bookingId" value="<%= bookingId %>">
        <input type="hidden" id="rating" name="rating" value="0">
        <div class="mb-3">
            <label for="serviceName" class="form-label">Service Name</label>
            <input type="text" class="form-control" id="serviceName" name="serviceName" value="<%= serviceName %>" readonly>
        </div>
        <div class="mb-3">
            <label for="bookingDate" class="form-label">Booking Date</label>
            <input type="text" class="form-control" id="bookingDate" name="bookingDate" value="<%= bookingDate %>" readonly>
        </div>
        <div class="mb-3">
            <label for="rating" class="form-label">Rating</label>
            <div class="stars">
	          <div class="star" data-rate="5">
	            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
	              <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
	              </polygon>
	            </svg>
	          </div>
	          <div class="star" data-rate="4">
	            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
	              <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
	              </polygon>
	            </svg>
	          </div>
	          <div class="star" data-rate="3">
	            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
	              <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
	              </polygon>
	            </svg>
	          </div>
	          <div class="star" data-rate="2">
	            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
	              <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
	              </polygon>
	            </svg>
	          </div>
	          <div class="star" data-rate="1">
	            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
	              <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
	              </polygon>
	            </svg>
	          </div>
        	</div>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Feedback</label>
            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
        </div>
        <div class="mb-3">
            <label for="suggestion" class="form-label">Suggestions</label>
            <textarea class="form-control" id="suggestion" name="suggestion" rows="3"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit Feedback</button>
    </form>
</div>
     <script src="../js/rating.js"></script>
</body>
</html>