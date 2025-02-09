package servlets;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.CheckoutDAO;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Read JSON from the request body
        StringBuilder jsonBody = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                jsonBody.append(line);
            }
        }

        Gson gson = new Gson();
        JsonObject jsonRequest = gson.fromJson(jsonBody.toString(), JsonObject.class);
        JsonArray cartItemsArray = jsonRequest.getAsJsonArray("cartItemIds");
        
        if (cartItemsArray == null || cartItemsArray.size() == 0) {
            response.getWriter().write("{\"error\":\"No items selected for checkout.\"}");
            return;
        }

        List<Integer> cartItemIds = new ArrayList<>();
        cartItemsArray.forEach(item -> cartItemIds.add(item.getAsInt()));

        HttpSession session = request.getSession();
        try {
            CheckoutDAO checkoutDAO = new CheckoutDAO();
            int totalAmount = checkoutDAO.getTotalAmount(cartItemIds);

            // Store cart item IDs and total amount in the session
            session.setAttribute("cartItemIds", cartItemIds);
            session.setAttribute("totalAmount", totalAmount);

            // Send success response with total amount
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("totalAmount", totalAmount);
            response.getWriter().write(gson.toJson(jsonResponse));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error: " + e.getMessage() + "\"}");
        }
    }
}
