package servlets;

import models.CartItem;
import models.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        CartDAO cartDAO = new CartDAO();
        List<CartItem> cartItems = cartDAO.getCartItems(userId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
        for (CartItem cartItem : cartItems) {
            JsonObjectBuilder jsonObjectBuilder = Json.createObjectBuilder()
                .add("id", cartItem.getId())
                .add("serviceName", cartItem.getServiceName())
                .add("bookingTime", cartItem.getBookingTime())
                .add("price", cartItem.getPrice())
                .add("remarks", cartItem.getRemarks());
            jsonArrayBuilder.add(jsonObjectBuilder);
        }

        out.print(Json.createObjectBuilder().add("cartItems", jsonArrayBuilder).build().toString());
        out.flush();
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cartItemId = Integer.parseInt(request.getParameter("id"));
        CartDAO cartDAO = new CartDAO();
        boolean isDeleted = cartDAO.deleteCartItem(cartItemId);

        response.setStatus(isDeleted ? HttpServletResponse.SC_NO_CONTENT : HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}