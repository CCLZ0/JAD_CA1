package servlets;

import models.Feedback;
import models.FeedbackDAO;
import models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String MAIN_PAGE ="/user/bookingHistory.jsp";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"User not logged in\"}");
            return;
        }

        String bookingIdStr = request.getParameter("bookingId");
        if (bookingIdStr == null || !bookingIdStr.matches("\\d+")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid booking ID\"}");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdStr);
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        Feedback feedback = feedbackDAO.getFeedbackDetails(bookingId);

        if (feedback == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\":\"Feedback details not found\"}");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = String.format("{\"userId\":%d, \"serviceId\":%d, \"serviceName\":\"%s\", \"bookingDate\":\"%s\"}", feedback.getUserId(), feedback.getServiceId(), feedback.getServiceName(), feedback.getBookingDate());
        response.getWriter().write(json);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int serviceId = Integer.parseInt(request.getParameter("serviceId"));
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String description = request.getParameter("description");
        String suggestion = request.getParameter("suggestion");

        FeedbackDAO feedbackDAO = new FeedbackDAO();
        feedbackDAO.submitFeedback(userId, serviceId, bookingId, rating, description, suggestion);

        response.sendRedirect(request.getContextPath() + MAIN_PAGE);
    }
}