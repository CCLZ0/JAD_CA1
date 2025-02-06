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

@WebServlet("/GetAllBookingsServlet")
public class GetAllBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GetAllBookingsServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Access database to retrieve booking details
            BookingHistoryDAO bookingHistoryDAO = new BookingHistoryDAO();
            List<Booking> bookings = bookingHistoryDAO.getAllBookings();

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