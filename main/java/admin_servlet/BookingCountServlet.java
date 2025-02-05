package admin_servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import dbaccess.ServiceDAO;

/**
 * Servlet implementation class BookingCountServlet
 */
@WebServlet("/BookingCountServlet")
public class BookingCountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookingCountServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Access database to retrieve booking count details
            ServiceDAO serviceDatabase = new ServiceDAO();
            List<Map<String, Object>> bookings = serviceDatabase.getBookingCount();

            request.setAttribute("servicesData", bookings);
            request.setAttribute("showBookingCounts", true);

            String url = "/admin/dashboard.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "DatabaseError");
            String url = "/admin/dashboard.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}