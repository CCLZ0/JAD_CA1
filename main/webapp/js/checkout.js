/*document.addEventListener("DOMContentLoaded", function () {
    let stripe = Stripe("pk_test_51QpuavPxDBHWbWwkARTamfH0UPy08eUNwiNiO8T4ljwCtbSAslT1hpoOfOMUp2FoADBvLdocfceAqwzbQ0LKDJCe00U3N8cbIM");
    let elements = stripe.elements();
    let cardElement = elements.create("card");
    cardElement.mount("#card-element");

    document.getElementById("payment-form").addEventListener("submit", function (event) {
        event.preventDefault();

        const clientSecret = document.getElementById("clientSecret").value; // Retrieve from hidden input or JSP variable
        stripe.confirmCardPayment(clientSecret, {
            payment_method: {
                card: cardElement,
                billing_details: {
                    name: document.getElementById("name").value,
                    email: document.getElementById("email").value,
                    address: {
                        line1: document.getElementById("address").value,
                        postal_code: document.getElementById("postalCode").value
                    }
                }
            }
        }).then(function (result) {
            if (result.error) {
                console.error("Payment Error:", result.error.message);
                alert("Payment failed: " + result.error.message);
            } else {
                if (result.paymentIntent.status === "succeeded") {
                    alert("Payment successful!");
                    window.location.href = "bookingHistory.jsp"; // Redirect to booking history
                }
            }
        });
    });
});
*/