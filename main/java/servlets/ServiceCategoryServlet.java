package servlets;

import models.ServiceCategory;
import models.ServiceCategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;

@WebServlet("/ServiceCategoryServlet")
public class ServiceCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServiceCategoryDAO serviceCategoryDAO = new ServiceCategoryDAO();
        List<ServiceCategory> serviceCategories = serviceCategoryDAO.getServiceCategories();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
        for (ServiceCategory category : serviceCategories) {
            JsonObjectBuilder jsonObjectBuilder = Json.createObjectBuilder()
                    .add("id", category.getId())
                    .add("name", category.getName())
                    .add("description", category.getDescription());
            jsonArrayBuilder.add(jsonObjectBuilder);
        }

        out.print(jsonArrayBuilder.build().toString());
        out.flush();
    }
}