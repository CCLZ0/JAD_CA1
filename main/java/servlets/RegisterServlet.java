package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import models.UserDAO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String LOGIN_PAGE = "/login/login.jsp";

    public RegisterServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("username2");
        String email = request.getParameter("email2");
        String password = request.getParameter("password2");
        String confirmPassword = request.getParameter("confirmPassword2");

        if (name == null || name.isEmpty() || email == null || email.isEmpty() || password == null || password.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
            response.sendRedirect(request.getContextPath() + LOGIN_PAGE + "?error=101");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + LOGIN_PAGE + "?error=passwordMismatch");
            return;
        }

        UserDAO userDAO = new UserDAO();
        boolean isRegistered = userDAO.registerUser(name, email, password);

        if (isRegistered) {
            request.getRequestDispatcher(LOGIN_PAGE + "?success=registrationComplete").forward(request, response);
        } else {
            request.getRequestDispatcher(LOGIN_PAGE + "?error=registrationFailed").forward(request, response);
        }
    }
}