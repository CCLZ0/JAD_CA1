package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;
import models.UserDAO;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String LOGIN_PAGE = "/login/login.jsp";
    private static final String MAIN_PAGE = "/user/index.jsp";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.getRequestDispatcher(LOGIN_PAGE + "?error=101").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.verifyUser(email, password);
        System.out.println("DEBUG: User object from LoginServlet: " + user);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getUserid()); // Store only userId in the session
            System.out.println("DEBUG: User logged in with userId: " + user.getUserid());
            response.sendRedirect(request.getContextPath() + MAIN_PAGE);
        } else {
            request.getRequestDispatcher(LOGIN_PAGE + "?error=invalidLogin").forward(request, response);
        }
    }
}