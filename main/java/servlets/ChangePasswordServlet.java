package servlets;

import models.User;
import models.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String PROFILE_PAGE = "/user/profile.jsp";

    public ChangePasswordServlet() {
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

        String currentPassword = request.getParameter("currentPasswordChange");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        if (currentPassword == null || currentPassword.isEmpty() || newPassword == null || newPassword.isEmpty() || confirmNewPassword == null || confirmNewPassword.isEmpty()) {
            request.getRequestDispatcher(PROFILE_PAGE + "?error=missingData").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmNewPassword)) {
            request.getRequestDispatcher(PROFILE_PAGE + "?error=passwordMismatch").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        try {
            User userDetails = userDAO.getUserDetails(userId.toString());
            if (userDetails != null && userDetails.getPassword() != null) {
                System.out.println("Stored password hash: " + userDetails.getPassword());
                System.out.println("Current password: " + currentPassword);
                if (BCrypt.checkpw(currentPassword, userDetails.getPassword())) {
                    userDAO.updatePassword(userId, newPassword);
                    request.getRequestDispatcher(PROFILE_PAGE + "?success=passwordUpdated").forward(request, response);
                } else {
                    request.getRequestDispatcher(PROFILE_PAGE + "?error=incorrectPassword").forward(request, response);
                }
            } else {
                request.getRequestDispatcher(PROFILE_PAGE + "?error=incorrectPassword").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher(PROFILE_PAGE + "?error=updateFailed").forward(request, response);
        }
    }
}