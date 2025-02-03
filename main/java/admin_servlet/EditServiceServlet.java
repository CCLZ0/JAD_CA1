package admin_servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import dbaccess.Service;
import dbaccess.ServiceDAO;

/**
 * Servlet implementation class EditServiceServlet
 */
@WebServlet("/EditServiceServlet")
public class EditServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditServiceServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Retrieve form data
            int id = Integer.parseInt(request.getParameter("id"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String serviceName = request.getParameter("serviceName");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String img = request.getParameter("img");

            // Create a new service object
            Service updatedService = new Service(id, categoryId, serviceName, description, price, img);

            // Access database to update the service
            ServiceDAO serviceDatabase = new ServiceDAO();
            boolean success = serviceDatabase.updateService(updatedService);

            if (success) {
                // Redirect to GetAllServicesServlet to display the updated list of services
                response.sendRedirect(request.getContextPath() + "/GetAllServicesServlet");
            } else {
                throw new Exception("Failed to update service");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "DatabaseError");
            String url = "/admin/editService.jsp?id=" + request.getParameter("id");
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}

