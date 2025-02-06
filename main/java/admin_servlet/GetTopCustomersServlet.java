package admin_servlet;

import dbaccess.BookingHistoryDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/GetTopCustomersServlet")
public class GetTopCustomersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookingHistoryDAO bookingHistoryDAO = new BookingHistoryDAO();
        try {
            List<Map<String, Object>> topCustomers = bookingHistoryDAO.getTopCustomersByBookingValue();
            request.setAttribute("topCustomers", topCustomers);
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while retrieving top customers.");
        }
    }
}