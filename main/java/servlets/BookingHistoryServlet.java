package servlets;

import models.Booking;
import models.BookingHistoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObject;
import jakarta.json.JsonObjectBuilder;
import jakarta.json.JsonWriter;

@WebServlet("/BookingHistoryServlet")
public class BookingHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(); // Use existing session, don't create new

        if (session == null) {
            System.out.println("DEBUG: Session is null.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            PrintWriter out = response.getWriter();
            JsonObject jsonResponse = Json.createObjectBuilder()
                    .add("error", "User not logged in")
                    .build();
            out.print(jsonResponse.toString());
            out.flush();
            return;
        } else {
            System.out.println("DEBUG: Session is not null.");
        }

        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("DEBUG: Retrieved userId from session: " + userId);

        if (userId == null) {
            System.out.println("DEBUG: Unauthorized access - No userId in session.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            PrintWriter out = response.getWriter();
            JsonObject jsonResponse = Json.createObjectBuilder()
                    .add("error", "User not logged in")
                    .build();
            out.print(jsonResponse.toString());
            out.flush();
            return;
        }

        System.out.println("DEBUG: User is logged in with userId: " + userId);

        BookingHistoryDAO bookingHistoryDAO = new BookingHistoryDAO();
        List<Booking> bookingHistory = bookingHistoryDAO.getBookingHistory(userId);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();

        for (Booking booking : bookingHistory) {
            JsonObjectBuilder jsonObjectBuilder = Json.createObjectBuilder()
                    .add("id", booking.getId())
                    .add("serviceName", booking.getServiceName())
                    .add("bookingDate", booking.getBookingDate())
                    .add("remarks", booking.getRemarks())
                    .add("statusName", booking.getStatusName())
                    .add("statusId", booking.getStatusId())
                    .add("feedbackId", booking.getFeedbackId());
            jsonArrayBuilder.add(jsonObjectBuilder);
        }

        JsonObject jsonResponse = Json.createObjectBuilder()
                .add("bookingHistory", jsonArrayBuilder)
                .build();

        try (JsonWriter jsonWriter = Json.createWriter(out)) {
            jsonWriter.write(jsonResponse);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}