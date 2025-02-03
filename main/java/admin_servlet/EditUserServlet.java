package admin_servlet;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import dbaccess.User;
import dbaccess.UserDAO;

/**
 * Servlet implementation class EditUserServlet
 */
@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditUserServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Retrieve form data
        	int id = Integer.parseInt(request.getParameter("id"));
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String role = request.getParameter("role");
            String password = request.getParameter("password");

            // Debug statement to print the form data
            System.out.println("Debug: id = " + id);
            System.out.println("Debug: email = " + email);
            System.out.println("Debug: name = " + name);
            System.out.println("Debug: role = " + role);
            System.out.println("Debug: password = " + password);

            // Create a new user object
            User updatedUser = new User(id, email, name, role, password);

            // Access database to update the user
            UserDAO userDatabase = new UserDAO();
            int rowsAffected = userDatabase.updateUser(id, updatedUser);

            // Debug statement to print the result of the update operation
            System.out.println("Debug: rowsAffected = " + rowsAffected);

            if (rowsAffected > 0) {
                // Redirect to GetAllUsersServlet to display the updated list of users
                response.sendRedirect(request.getContextPath() + "/GetAllUsersServlet");
            } else {
                throw new Exception("Failed to update user");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "DatabaseError");
            String url = "/admin/editUser.jsp?id=" + request.getParameter("id");
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}



