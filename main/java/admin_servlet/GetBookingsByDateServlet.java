package admin_servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import models.Booking;
import models.BookingHistoryDAO;

@WebServlet("/GetBookingsByDateServlet")
public class GetBookingsByDateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GetBookingsByDateServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Retrieve start and end dates from request
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            // Access database to retrieve booking details within the specified date range
            BookingHistoryDAO bookingHistoryDAO = new BookingHistoryDAO();
            List<Booking> bookings = bookingHistoryDAO.getBookingsByDateRange(startDate, endDate);

            request.setAttribute("bookings", bookings);

            String url = "/admin/manageBooking.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "DatabaseError");
            String url = "/admin/manageBooking.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}