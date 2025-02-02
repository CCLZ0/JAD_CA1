package servlets;

import models.BookingDAO;
import models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/BookServiceServlet")
public class BookServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String BOOKING_PAGE = "/user/bookService.jsp";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=notLoggedIn");
            return;
        }

        String serviceIdStr = request.getParameter("serviceId");
        String bookingTime = request.getParameter("bookingTime");
        String remarks = request.getParameter("remarks");

        System.out.println("Service ID: " + serviceIdStr); // Debugging statement

        if (serviceIdStr != null && !serviceIdStr.isEmpty() && bookingTime != null && !bookingTime.isEmpty()) {
            try {
                int serviceId = Integer.parseInt(serviceIdStr);
                BookingDAO bookingDAO = new BookingDAO();
                boolean isAdded = bookingDAO.addServiceToCart(user.getUserid(), serviceId, bookingTime, remarks);

                if (isAdded) {
                    response.sendRedirect(request.getContextPath() + "/user/cart.jsp?success=Service added to cart successfully!");
                } else {
                    response.sendRedirect(request.getContextPath() + BOOKING_PAGE + "?error=Failed to add service to cart&serviceId=" + serviceIdStr);
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + BOOKING_PAGE + "?error=Invalid service ID&serviceId=" + serviceIdStr);
            }
        } else {
            response.sendRedirect(request.getContextPath() + BOOKING_PAGE + "?error=Service ID and booking time are required&serviceId=" + serviceIdStr);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=notLoggedIn");
            return;
        }

        String serviceId = request.getParameter("serviceId");
        System.out.println("Service ID (GET): " + serviceId); // Debugging statement
        if (serviceId != null) {
            request.setAttribute("serviceId", serviceId);
            request.getRequestDispatcher(BOOKING_PAGE).forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/user/services.jsp");
        }
    }
}