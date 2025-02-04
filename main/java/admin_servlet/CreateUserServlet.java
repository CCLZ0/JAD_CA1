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
 * Servlet implementation class AddUserServlet
 */
@WebServlet("/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CreateUserServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Retrieve form data
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            // Debug statement to print the form data
            System.out.println("Debug: email = " + email);
            System.out.println("Debug: name = " + name);
            System.out.println("Debug: password = " + password);
            System.out.println("Debug: role = " + role);

            // Create a new user object
            User newUser = new User(0, email, name, password, role);

            // Access database to add the new user
            UserDAO userDatabase = new UserDAO();
            userDatabase.insertUser(newUser);

            // Redirect to manageUser.jsp
            String url = "/admin/manageUser.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);

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
