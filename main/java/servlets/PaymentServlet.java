package servlets;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.CheckoutDAO;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    public void init() throws ServletException {
        super.init();
        Stripe.apiKey = "sk_test_51QpuavPxDBHWbWwkxTAbdV9tU3b03m8EX9ZJMrIKgbJNmynFQIc4yGLKt57wLCss3sk8gUmIROkUiHwLQw8K1Fo800CIpZlvJv";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer totalAmount = (Integer) request.getSession().getAttribute("totalAmount");
        if (totalAmount == null) {
            response.getWriter().write("{\"error\":\"Session has expired or total amount is missing.\"}");
            return;
        }

        try {
            PaymentIntentCreateParams params = PaymentIntentCreateParams.builder()
                .setAmount((long) totalAmount * 100) // Ensure this is in cents
                .setCurrency("usd")
                .build();

            PaymentIntent intent = PaymentIntent.create(params);
            String clientSecret = intent.getClientSecret();

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"clientSecret\": \"" + clientSecret + "\"}");
        } catch (StripeException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Stripe error: " + e.getMessage() + "\"}");
        }
    }
}
