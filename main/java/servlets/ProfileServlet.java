package servlets;

import models.User;
import models.UserDAO;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.json.JsonWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(); // Use existing session, don't create new

        if (session == null) {
            System.out.println("DEBUG: Session is null.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject jsonResponse = Json.createObjectBuilder()
                    .add("error", "User not logged in")
                    .build();
            try (JsonWriter jsonWriter = Json.createWriter(response.getWriter())) {
                jsonWriter.write(jsonResponse);
            }
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("DEBUG: Retrieved userId from session: " + userId);

        if (userId == null) {
            System.out.println("DEBUG: Unauthorized access - No userId in session.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject jsonResponse = Json.createObjectBuilder()
                    .add("error", "User not logged in")
                    .build();
            try (JsonWriter jsonWriter = Json.createWriter(response.getWriter())) {
                jsonWriter.write(jsonResponse);
            }
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = null;
        try {
            user = userDAO.getUserDetails(userId.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (user == null) {
            System.out.println("DEBUG: User not found for userId: " + userId);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            JsonObject jsonResponse = Json.createObjectBuilder()
                    .add("error", "User not found")
                    .build();
            try (JsonWriter jsonWriter = Json.createWriter(response.getWriter())) {
                jsonWriter.write(jsonResponse);
            }
            return;
        }

        System.out.println("DEBUG: User is logged in with userId: " + userId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JsonObject jsonResponse = Json.createObjectBuilder()
                .add("name", user.getName())
                .add("email", user.getEmail())
                .build();
        try (JsonWriter jsonWriter = Json.createWriter(response.getWriter())) {
            jsonWriter.write(jsonResponse);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}