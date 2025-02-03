package admin_servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import dbaccess.Service;
import dbaccess.ServiceDAO;

/**
 * Servlet implementation class ManageServiceServlet
 */
@WebServlet("/ManageServiceServlet")
public class GetAllServicesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GetAllServicesServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Access database to retrieve service details
            ServiceDAO serviceDatabase = new ServiceDAO();
            List<Service> services = serviceDatabase.getAllServices();

            request.setAttribute("services", services);

            String url = "/admin/manageService.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "DatabaseError");
            String url = "/admin/manageService.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
