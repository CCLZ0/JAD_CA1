package servlets;

import models.User;
import models.UserDAO;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.json.JsonWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String PROFILE_PAGE = "/user/profile.jsp";
    private static final String LOGIN_PAGE = "/login/login.jsp";

    public EditProfileServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Use existing session, don't create new

        if (session == null) {
            System.out.println("DEBUG: Session is null.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"User not logged in\"}");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("DEBUG: Retrieved userId from session: " + userId);

        if (userId == null) {
            System.out.println("DEBUG: Unauthorized access - No userId in session.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"User not logged in\"}");
            return;
        }

        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");

        if (userName == null || userName.isEmpty() || userEmail == null || userEmail.isEmpty()) {
            request.getRequestDispatcher(PROFILE_PAGE + "?error=missingData").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.getUserDetails(userId.toString());
            if (user != null) {
                user.setName(userName);
                user.setEmail(userEmail);
                userDAO.updateUser(user);
                request.getRequestDispatcher(PROFILE_PAGE + "?success=profileUpdated").forward(request, response);
            } else {
                request.getRequestDispatcher(PROFILE_PAGE + "?error=updateFailed").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher(PROFILE_PAGE + "?error=updateFailed").forward(request, response);
        }
    }
}