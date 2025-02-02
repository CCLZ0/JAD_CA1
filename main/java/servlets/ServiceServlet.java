package servlets;

import models.Service;
import models.ServicesDAO;
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

@WebServlet("/ServiceServlet")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryIdStr = request.getParameter("categoryId");
        if (categoryIdStr == null || categoryIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }

        int categoryId = Integer.parseInt(categoryIdStr);
        ServicesDAO servicesDAO = new ServicesDAO();
        List<Service> services = servicesDAO.getServicesByCategory(categoryId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
        for (Service service : services) {
            JsonObjectBuilder jsonObjectBuilder = Json.createObjectBuilder()
                    .add("id", service.getId())
                    .add("name", service.getName())
                    .add("description", service.getDescription())
                    .add("price", service.getPrice())
                    .add("imgPath", service.getImgPath())
                    .add("categoryId", service.getCategoryId());
            jsonArrayBuilder.add(jsonObjectBuilder);
        }

        out.print(jsonArrayBuilder.build().toString());
        out.flush();
    }
}