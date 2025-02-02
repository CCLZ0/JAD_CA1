package servlets;

import models.Booking;
import models.BookingHistoryDAO;
import models.User;
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject jsonResponse = Json.createObjectBuilder()
                    .add("error", "Unauthorized access. Please log in.")
                    .build();
            try (JsonWriter jsonWriter = Json.createWriter(response.getWriter())) {
                jsonWriter.write(jsonResponse);
            }
            return;
        }

        BookingHistoryDAO bookingHistoryDAO = new BookingHistoryDAO();
        List<Booking> bookingHistory = bookingHistoryDAO.getBookingHistory(user.getUserid());

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


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
