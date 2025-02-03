package servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.io.IOException;
import java.util.ArrayList;

import dbaccess.User;

/**
 * Servlet implementation class GetUserList
 */
@WebServlet("/GetUserList")
public class GetUserList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GetUserList() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Client client = ClientBuilder.newClient();
		String restUrl = "http://localhost:8081/user-ws/getAllUsers";

		WebTarget target = client.target(restUrl);
		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
		Response resp = invocationBuilder.get();

		System.out.println("status: " + resp.getStatus());

		if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
			System.out.println("success");

			// Read response entity as an ArrayList of User
			ArrayList<User> userList = resp.readEntity(new GenericType<ArrayList<User>>() {
			});

			// Set user list in request attribute
			request.setAttribute("userArray", userList);
			System.out.println("User list set in request object... forwarding...");

			// Forward request to testweb.jsp
			RequestDispatcher rd = request.getRequestDispatcher("pract8/testweb.jsp");
			rd.forward(request, response);

		} else {
			System.out.println("failed");
			request.setAttribute("err", "NotFound");

			// Forward to testweb.jsp with error message
			RequestDispatcher rd = request.getRequestDispatcher("pract8/testweb.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
