package servlets;

import models.NavbarDAO;
import models.NavbarData;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObject;
import jakarta.json.JsonObjectBuilder;
import jakarta.json.JsonWriter;

@WebServlet("/NavbarServlet")
public class NavbarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("NavbarServlet doGet method invoked");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId"); // Retrieve user ID from session

        NavbarDAO navbarDAO = new NavbarDAO();
        ArrayList<String[]> categories = navbarDAO.getCategories(); // Fetch categories directly from DAO

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder jsonResponseBuilder = Json.createObjectBuilder();

        if (userId != null) {
            // Fetch user data using the user ID
            NavbarData userData = navbarDAO.getUserData(userId);
            if (userData != null) {
                System.out.println("User found: " + userData.getName());
                jsonResponseBuilder.add("userId", userId); // Add user ID to the response
                jsonResponseBuilder.add("userName", userData.getName()); // Add user name to the response
                jsonResponseBuilder.add("role", userData.getRole()); // Add user role to the response
            } else {
                System.out.println("No user data found for userId: " + userId);
            }
        }

        // Add categories to the JSON response
        JsonArrayBuilder categoriesArrayBuilder = Json.createArrayBuilder();
        if (categories != null) {
            for (String[] category : categories) {
                JsonObject categoryJson = Json.createObjectBuilder()
                        .add("id", category[0])
                        .add("name", category[1])
                        .build();
                categoriesArrayBuilder.add(categoryJson);
            }
        }
        jsonResponseBuilder.add("categories", categoriesArrayBuilder);

        JsonObject jsonResponse = jsonResponseBuilder.build();

        System.out.println("JSON Response: " + jsonResponse.toString());

        try (JsonWriter jsonWriter = Json.createWriter(out)) {
            jsonWriter.write(jsonResponse);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to doGet to handle the request
        doGet(request, response);
    }
}

