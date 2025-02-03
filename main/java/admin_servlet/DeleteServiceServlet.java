package admin_servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import dbaccess.ServiceDAO;

/**
 * Servlet implementation class DeleteServiceServlet
 */
@WebServlet("/DeleteServiceServlet")
public class DeleteServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteServiceServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Retrieve service ID from request
            int serviceId = Integer.parseInt(request.getParameter("id"));

            // Access database to delete the service
            ServiceDAO serviceDatabase = new ServiceDAO();
            boolean success = serviceDatabase.deleteService(serviceId);

            if (success) {
                // Redirect to GetAllServicesServlet to display the updated list of services
                response.sendRedirect(request.getContextPath() + "/GetAllServicesServlet");
            } else {
                throw new Exception("Failed to delete service");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "DatabaseError");
            String url = "/admin/manageService.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}
