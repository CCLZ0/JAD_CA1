package admin_servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import models.BookingHistoryDAO;

/**
 * Servlet implementation class DeleteBookingServlet
 */
@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteBookingServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Retrieve booking ID from request
            int bookingId = Integer.parseInt(request.getParameter("id"));

            // Access database to delete the booking
            BookingHistoryDAO bookingHistoryDAO = new BookingHistoryDAO();
            boolean success = bookingHistoryDAO.deleteBooking(bookingId);

            if (success) {
                // Redirect to GetAllBookingsServlet to display the updated list of bookings
                response.sendRedirect(request.getContextPath() + "/GetAllBookingsServlet");
            } else {
                throw new Exception("Failed to delete booking");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "DatabaseError");
            String url = "/admin/manageBooking.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}
