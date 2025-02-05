package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import dbaccess.User;
import dbaccess.UserDAO;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String LOGIN_PAGE = "login/login.jsp";

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve form data
            String name = request.getParameter("name2");
            String email = request.getParameter("email2");
            String password = request.getParameter("password2");
            String confirmPassword = request.getParameter("confirmPassword2");
            String role = "member";

            // Validate form data
            if (name == null || name.isEmpty() || email == null || email.isEmpty() || password == null || password.isEmpty()) {
                response.sendRedirect(LOGIN_PAGE + "?error=101");
                return;
            }

            // Check if password matches confirm password
            if (!password.equals(confirmPassword)) {
                response.sendRedirect(LOGIN_PAGE + "?error=passwordMismatch");
                return;
            }

            // Create a new user object with all fields
            User newUser = new User(0, email, name, password, role);

            // Access database to add the new user
            UserDAO userDAO = new UserDAO();
            int result = userDAO.insertUser(newUser);

            // Redirect based on registration success
            if (result > 0) {
                RequestDispatcher dispatcher = request.getRequestDispatcher(LOGIN_PAGE + "?success=registrationComplete");
                dispatcher.forward(request, response);
            } else {
                RequestDispatcher dispatcher = request.getRequestDispatcher(LOGIN_PAGE + "?error=registrationFailed");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher dispatcher = request.getRequestDispatcher(LOGIN_PAGE + "?error=registrationFailed");
            dispatcher.forward(request, response);
        }
    }
}
