package servlets;

import models.NavbarDAO;
import models.User;
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
        User user = (User) session.getAttribute("user");

        NavbarDAO navbarDAO = new NavbarDAO();
        ArrayList<String[]> categories = navbarDAO.getCategories();

        if (categories == null) {
            System.out.println("No categories found");
        } else {
            System.out.println("Categories found: " + categories.size());
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder jsonResponseBuilder = Json.createObjectBuilder();

        if (user != null) {
            System.out.println("User found: " + user.getName() + ", Role: " + user.getRole());
            jsonResponseBuilder.add("userName", user.getName());
            jsonResponseBuilder.add("userRole", user.getRole());
        } else {
            System.out.println("No user found in session");
        }

        JsonArrayBuilder categoriesArrayBuilder = Json.createArrayBuilder();
        for (String[] category : categories) {
            JsonObject categoryJson = Json.createObjectBuilder()
                    .add("id", category[0])
                    .add("name", category[1])
                    .build();
            categoriesArrayBuilder.add(categoryJson);
        }
        jsonResponseBuilder.add("categories", categoriesArrayBuilder);

        JsonObject jsonResponse = jsonResponseBuilder.build();

        System.out.println("JSON Response: " + jsonResponse.toString());

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
