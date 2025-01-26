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

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String LOGIN_PAGE ="/login/login.jsp";
    private static final String MAIN_PAGE ="/user/index.jsp";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");

	    if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
	        request.getRequestDispatcher(LOGIN_PAGE +  "?error=101").forward(request, response);
	        return;
	    }

	    UserDAO userDAO = new UserDAO();
	    User user = userDAO.verifyUser(email, password);
	    System.out.println("User object from loginservlet: " + user);

	    if (user != null) {
	        HttpSession session = request.getSession();
	        session.setAttribute("user", user);
	        response.sendRedirect(request.getContextPath() + MAIN_PAGE);
	        return;
	    } else {
	        request.getRequestDispatcher(LOGIN_PAGE + "?error=invalidLogin").forward(request, response);
	    }
	}


}
