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

/**
 * Servlet implementation class EditProfileServlet
 */
@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private static final String PROFILE_PAGE ="/user/profile.jsp";
	 private static final String LOGIN_PAGE ="/login/login.jsp";
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfileServlet() {
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

        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");

        if (userName == null || userName.isEmpty() || userEmail == null || userEmail.isEmpty()) {
            request.getRequestDispatcher(PROFILE_PAGE + "?error=missingData").forward(request, response);
            return;
        }

        user.setName(userName);
        user.setEmail(userEmail);

        UserDAO userDAO = new UserDAO();
        try {
            userDAO.updateUser(user);
            session.setAttribute("user", user); // Update session with new user details
            request.getRequestDispatcher(PROFILE_PAGE + "?success=profileUpdated").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher(PROFILE_PAGE + "?error=updateFailed").forward(request, response);
        }
    }

}
