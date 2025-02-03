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
 * Servlet implementation class AddServiceServlet
 */
@WebServlet("/AddServiceServlet")
public class AddServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddServiceServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Retrieve form data
            String serviceName = request.getParameter("serviceName");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String img = request.getParameter("img");

            // Create a new service object
            Service newService = new Service(0, categoryId, serviceName, description, price, img);

            // Access database to add the new service
            ServiceDAO serviceDatabase = new ServiceDAO();
            boolean success = serviceDatabase.addService(newService);

            if (success) {
                // Redirect to GetAllServicesServlet to display the updated list of services
                response.sendRedirect(request.getContextPath() + "/GetAllServicesServlet");
            } else {
                throw new Exception("Failed to add service");
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
