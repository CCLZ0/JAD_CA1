<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../web_elements/navbar.jsp" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.stream.Collectors" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=notLoggedIn");
        return;
    }

    List<Integer> selectedCartIds = (List<Integer>) session.getAttribute("cartItemIds");
    if (selectedCartIds == null || selectedCartIds.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
        return;
    }

    String cartItemIdsAsString = selectedCartIds.stream()
                                                .map(String::valueOf)
                                                .collect(Collectors.joining(","));
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stripe Checkout</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans&family=Libre+Baskerville:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://js.stripe.com/v3/"></script>
</head>
<body>

    <!-- Hidden Inputs for Server Data -->
    <input type="hidden" id="hidden-cart-ids" value="<%= cartItemIdsAsString %>">

    <div class="container mt-5" id="checkout">
        <h2>Checkout</h2>
        <form id="payment-form">
            <div class="mb-3">
                <label for="firstName" class="form-label">First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" required>
            </div>
            <label class="form-label">Card Information:</label>
            <div id="card-element" class="mb-3"></div>
            <div id="card-errors" role="alert" class="text-danger"></div>
            <button id="payButton" type="submit" class="btn btn-primary">Pay</button>
        </form>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", async function () {
            const stripe = Stripe("pk_test_51QpuavPxDBHWbWwkARTamfH0UPy08eUNwiNiO8T4ljwCtbSAslT1hpoOfOMUp2FoADBvLdocfceAqwzbQ0LKDJCe00U3N8cbIM");
            const elements = stripe.elements();
            const card = elements.create('card', {
                hidePostalCode: true,   
                style: {
                    base: {
                        fontSize: "16px",
                        color: "#32325d",
                        fontFamily: "'Josefin Sans', sans-serif",
                        "::placeholder": { color: "#aab7c4" }
                    },
                    invalid: { color: "#fa755a" }
                }
            });
            card.mount("#card-element");

            const cartItemIds = document.getElementById("hidden-cart-ids").value.split(',');
            if (cartItemIds.length === 0) {
                console.error("No cart items found.");
                document.getElementById("card-errors").textContent = "No items selected for payment.";
                return;
            }

            const payButton = document.getElementById("payButton");
            document.getElementById("payment-form").addEventListener("submit", async function (event) {
                event.preventDefault();
                payButton.disabled = true;
                payButton.textContent = "Processing...";

                try {
                    const response = await fetch('<%= request.getContextPath() %>/PaymentServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            cartItemIds: cartItemIds
                        })
                    });

                    const data = await response.json();
                    if (data.error) {
                        throw new Error(data.error);
                    }

                    const { paymentIntent, error } = await stripe.confirmCardPayment(data.clientSecret, {
                        payment_method: {
                            card: card,
                            billing_details: {
                                name: document.getElementById("firstName").value
                            }
                        }
                    });

                    if (error) {
                        throw new Error(error.message);
                    }

                    if (paymentIntent.status === 'succeeded') {
                        window.location.href = '<%= request.getContextPath() %>/user/bookingHistory.jsp?orderId=' + paymentIntent.id;
                    } else {
                        throw new Error("Payment did not succeed.");
                    }
                } catch (err) {
                    document.getElementById("card-errors").textContent = err.message;
                    payButton.disabled = false;
                    payButton.textContent = "Pay";
                }
            });
        });
    </script>
</body>
</html>
