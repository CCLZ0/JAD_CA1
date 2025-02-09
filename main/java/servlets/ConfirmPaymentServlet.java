package servlets;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.CartDAO;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/ConfirmPaymentServlet")
public class ConfirmPaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        String[] cartItemIdsArray = request.getParameterValues("cartItemIds");
        if (userId == null || cartItemIdsArray == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Session has expired or cart item IDs are missing.\"}");
            return;
        }

        List<Integer> cartItemIds = Arrays.asList(cartItemIdsArray).stream().map(Integer::parseInt).toList();
        CartDAO cartDao = new CartDAO();

        if (cartDao.moveItemsToBooking(userId, cartItemIds)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": true, \"message\": \"Items successfully moved to booking.\"}");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Failed to move items to booking.\"}");
        }
    }
}
