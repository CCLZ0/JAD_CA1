package admin_servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import dbaccess.ServiceDAO;

/**
 * Servlet implementation class AverageRatingServlet
 */
@WebServlet("/AverageRatingServlet")
public class AverageRatingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AverageRatingServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Access database to retrieve average rating details
            ServiceDAO serviceDatabase = new ServiceDAO();
            List<Map<String, Object>> ratings = serviceDatabase.getAverageRating();

            request.setAttribute("servicesData", ratings);
            request.setAttribute("showAverageRatings", true);

            String url = "/admin/dashboard.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "DatabaseError");
            String url = "/admin/dashboard.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}