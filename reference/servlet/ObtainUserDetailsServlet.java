package servlet;

import java.io.IOException;


import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import dbaccess.User;
import dbaccess.UserDAO;

/**
 * Servlet implementation class ObtainUserDetailsServlet
 */
@WebServlet("/ObtainUserDetailsServlet")
public class ObtainUserDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ObtainUserDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        User uBean = null;

        try {
            String userid = request.getParameter("userid");

            // Access database to retrieve user details
            UserDAO udatabase = new UserDAO();
            uBean = udatabase.getUserDetails(userid);

            request.setAttribute("userData", uBean);

            // Debug
            out.print("Test: userid=" + userid);

            String url = "/pract8/views/displayUserDetails.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		// TODO Auto-generated method stub
				doGet(request, response);
    }

}
