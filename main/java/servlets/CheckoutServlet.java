package servlets;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.CartDAO;
import models.CheckoutDAO;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("finalizeCheckout".equals(action)) {
            String token = request.getParameter("token"); // Stripe payment token
            HttpSession session = request.getSession();
            String[] cartItemIdsStr = request.getParameterValues("cartItemIds");

            if (cartItemIdsStr == null || cartItemIdsStr.length == 0) {
                response.sendRedirect(request.getContextPath() + "/user/checkout.jsp?error=NoItems");
                return;
            }

            List<Integer> cartItemIds = Arrays.stream(cartItemIdsStr)
                                              .map(Integer::parseInt)
                                              .collect(Collectors.toList());

            try {
                CartDAO cartDAO = new CartDAO();
                double totalAmount = cartDAO.calculateTotalAmount(cartItemIds);

                boolean paymentSuccess = processStripePayment(token, totalAmount);

                if (paymentSuccess) {
                    int userId = (Integer) session.getAttribute("userId");
                    CheckoutDAO checkoutDAO = new CheckoutDAO();
                    boolean success = checkoutDAO.completeCheckout(userId, cartItemIdsStr);

                    if (success) {
                        session.removeAttribute("cartItemIds"); // Clear session after checkout
                        response.sendRedirect(request.getContextPath() + "/user/bookingHistory.jsp");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/user/checkout.jsp?error=CheckoutFailed");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/user/checkout.jsp?error=PaymentFailed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/user/checkout.jsp?error=ServerError");
            }
        }
    }

    private boolean processStripePayment(String token, double amount) {
        try {
            Stripe.apiKey = "sk_test_51QpuavPxDBHWbWwkxTAbdV9tU3b03m8EX9ZJMrIKgbJNmynFQIc4yGLKt57wLCss3sk8gUmIROkUiHwLQw8K1Fo800CIpZlvJv"; // Replace with real Stripe secret key

            PaymentIntentCreateParams params = 
                PaymentIntentCreateParams.builder()
                    .setAmount((long) (amount * 100)) // Convert amount to cents
                    .setCurrency("sgd	")
                    .setPaymentMethod(token)
                    .setConfirm(true)
                    .build();

            PaymentIntent intent = PaymentIntent.create(params);
            return "succeeded".equals(intent.getStatus());
        } catch (StripeException e) {
            e.printStackTrace();
            return false;
        }
    }
}