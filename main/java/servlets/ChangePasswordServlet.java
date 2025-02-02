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

/**
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String PROFILE_PAGE ="/user/profile.jsp";
	private static final String LOGIN_PAGE ="/login/login.jsp";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + LOGIN_PAGE + "?error=notLoggedIn");
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
            User userDetails = userDAO.getUserDetails(String.valueOf(user.getUserid()));
            if (userDetails != null && userDetails.getPassword() != null) {
                System.out.println("Stored password hash: " + userDetails.getPassword());
                System.out.println("Current password: " + currentPassword);
                if (BCrypt.checkpw(currentPassword, userDetails.getPassword())) {
                    userDAO.updatePassword(user.getUserid(), newPassword);
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
