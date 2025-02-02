package servlets;

import models.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/SearchServiceServlet")
public class SearchServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        System.out.println("Received query: " + query); // Debugging statement

        ServiceDAO serviceDAO = new ServiceDAO();
        List<String[]> suggestions = serviceDAO.searchServices(query);
        System.out.println("Suggestions: " + suggestions); // Debugging statement

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        if (suggestions.isEmpty()) {
            response.getWriter().write("[]");
        } else {
            response.getWriter().write("[");
            for (int i = 0; i < suggestions.size(); i++) {
                String[] suggestion = suggestions.get(i);
                response.getWriter().write(String.format("{\"id\": \"%s\", \"service_name\": \"%s\"}", suggestion[0], suggestion[1]));
                if (i < suggestions.size() - 1) {
                    response.getWriter().write(",");
                }
            }
            response.getWriter().write("]");
        }
    }
}