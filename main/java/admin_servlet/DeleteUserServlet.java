package admin_servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import dbaccess.UserDAO;

/**
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteUserServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Retrieve user ID from request
        	int Id = Integer.parseInt(request.getParameter("id"));

            // Access database to delete the user
            UserDAO userDatabase = new UserDAO();
            int rowsAffected = userDatabase.deleteUser(Id);

            if (rowsAffected > 0) {
                // Redirect to GetAllUsersServlet to display the updated list of users
                response.sendRedirect(request.getContextPath() + "/GetAllUsersServlet");
            } else {
                throw new Exception("Failed to delete user");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "DatabaseError");
            String url = "/admin/manageUser.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}

