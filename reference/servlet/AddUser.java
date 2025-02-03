package servlet;

import jakarta.servlet.ServletException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import responses.AddUserResponse;

import java.io.IOException;

import org.jose4j.json.internal.json_simple.JSONObject;

/**
 * Servlet to Add a New User
 */
@WebServlet("/AddUser")
public class AddUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddUser() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userid");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");

        // Validate the input
        if (userId == null || age == null || gender == null) {
            request.getRequestDispatcher("/pract8/views/addResult.jsp?errCode=noInput").forward(request, response);
            return;
        }

        // Prepare the user data
        JSONObject userJSON = new JSONObject();
        userJSON.put("userid", userId);
        userJSON.put("age", age);
        userJSON.put("gender", gender);

        // Send data to web service
        Client client = ClientBuilder.newClient();
        WebTarget target = client.target("http://localhost:8081/user-ws/createUser");
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);

        Response res = invocationBuilder.post(Entity.entity(userJSON, MediaType.APPLICATION_JSON));

        // Read the response as an integer (rows affected)
        if (res.getStatus() == Response.Status.OK.getStatusCode()) {
            int rowsAffected = res.readEntity(Integer.class);  // Directly read the response as an integer
            request.setAttribute("rowsAffected", rowsAffected);
        } else {
            request.getRequestDispatcher("/pract8/views/addResult.jsp?errCode=someError").forward(request, response);
            return;
        }

        request.getRequestDispatcher("/pract8/views/addResult.jsp").forward(request, response);
    }
}
