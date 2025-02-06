<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="dbaccess.Booking"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Bookings</title>
        <link
            href="https://fonts.googleapis.com/css2?family=Recursive&display=swap"
            rel="stylesheet">
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <%@ include file="../web_elements/navbar.jsp"%>

        <div class="container mt-5">
            <h1 class="mb-4">Manage Bookings</h1>

            <!-- Form for Listing All Bookings -->
            <div class="box">
                <h3>Show All Bookings</h3>
                <form
                    action="<%=request.getContextPath()%>/GetAllBookingsServlet">
                    <div>
                        <input type="submit" value="List All Bookings"
                            class="btn btn-primary" />
                    </div>
                </form>
            </div>

            <!-- Display Error Message if Booking Not Found -->
            <%
            String error = (String) request.getAttribute("err");
            if (error != null && error.equals("NotFound")) {
            out.print("<p style='color:red;'>ERROR: Booking not found!</p>");
            }
            %>

            <!-- Form for Bookings of Cleaning Services by Date, Period, or Month -->
            <div class="box mt-4">
                <h3>Bookings by Date, Period, or Month</h3>
                <form action="<%=request.getContextPath()%>/GetBookingsByDateServlet" method="GET">
                    <div class="mb-3">
                        <label for="startDate" class="form-label">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" class="form-control" required />
                    </div>
                    <div class="mb-3">
                        <label for="endDate" class="form-label">End Date:</label>
                        <input type="date" id="endDate" name="endDate" class="form-control" required />
                    </div>
                    <div>
                        <input type="submit" value="Get Bookings" class="btn btn-primary" />
                    </div>
                </form>
            </div>
            
            <!-- Display List of Bookings -->
            <%
            List<Booking> bookings = (List<Booking>)
                    request.getAttribute("bookings");
                    if (bookings != null) {
                    if (!bookings.isEmpty()) {
                    %>
                    <table class="table mt-4">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Service Name</th>
                                <th>Booking Date</th>
                                <th>Remarks</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            for (Booking booking : bookings) {
                            %>
                            <tr>
                                <td><%=booking.getId()%></td>
                                <td><%=booking.getServiceName()%></td>
                                <td><%=booking.getBookingDate()%></td>
                                <td><%=booking.getRemarks()%></td>
                                <td><%=booking.getStatusName()%></td>
                                <td>
                                    <a
                                        href="<%=request.getContextPath()%>/DeleteBookingServlet?id=<%=booking.getId()%>"
                                        class="btn btn-danger btn-sm">Delete</a></td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                    <%
                    } else {
                    %>
                    <div class="alert alert-info mt-4">No bookings found.</div>
                    <%
                    }
                    }
                    %>
                    <!-- Back Button -->
                    <button class="btn btn-secondary mt-3"
                        onclick="window.location.href='<%=request.getContextPath()%>/admin/dashboard.jsp';">Back</button>
                </div>

                <%@ include file="../web_elements/footer.html"%>
            </body>
        </html>