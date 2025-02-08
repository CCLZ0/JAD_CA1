package servlets;

import com.google.gson.JsonObject;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.CheckoutDAO;
import java.io.IOException;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Stripe.apiKey = "sk_test_51QpuavPxDBHWbWwkxTAbdV9tU3b03m8EX9ZJMrIKgbJNmynFQIc4yGLKt57wLCss3sk8gUmIROkUiHwLQw8K1Fo800CIpZlvJv"; // Replace with actual secret key

        String paymentIntentId = request.getParameter("paymentIntentId");
        String[] cartItemIds = request.getParameterValues("cartItemIds");
        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (paymentIntentId == null || cartItemIds == null || userId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters.");
            return;
        }

        try {
            // Retrieve the PaymentIntent from Stripe
            PaymentIntent paymentIntent = PaymentIntent.retrieve(paymentIntentId);

            if ("succeeded".equals(paymentIntent.getStatus())) {
                // Process checkout in database
                CheckoutDAO checkoutDAO = new CheckoutDAO();
                boolean success = checkoutDAO.checkout(userId, cartItemIds);

                if (success) {
                    response.setContentType("application/json");
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("message", "Payment successful. Booking confirmed.");
                    response.getWriter().write(jsonResponse.toString());
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update booking.");
                }
            } else {
                response.sendError(HttpServletResponse.SC_PAYMENT_REQUIRED, "Payment not successful.");
            }
        } catch (StripeException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Stripe error: " + e.getMessage());
        }
    }
}
