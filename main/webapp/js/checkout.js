document.addEventListener("DOMContentLoaded", function () {
    let stripe = Stripe("pk_test_51QpuavPxDBHWbWwkARTamfH0UPy08eUNwiNiO8T4ljwCtbSAslT1hpoOfOMUp2FoADBvLdocfceAqwzbQ0LKDJCe00U3N8cbIM"); // Replace with actual Stripe key
    let elements = stripe.elements();
    let card = elements.create("card");
    card.mount("#card-element");

    document.getElementById("payment-form").addEventListener("submit", function (event) {
        event.preventDefault();

        stripe.createToken(card).then(function (result) {
            if (result.error) {
                document.getElementById("card-errors").textContent = result.error.message;
            } else {
                sendPaymentToServer(result.token);
            }
        });
    });
});

function sendPaymentToServer(token) {
    fetch(contextPath + "/CheckoutServlet", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            token: token.id,
            action: "finalizeCheckout"
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert("Payment successful! Redirecting...");
            window.location.href = contextPath + "/user/success.jsp"; // Redirect to success page
        } else {
            alert("Payment failed. Please try again.");
        }
    })
    .catch(error => {
        console.error("Payment Error:", error);
        alert("An error occurred. Please try again.");
    });
}
