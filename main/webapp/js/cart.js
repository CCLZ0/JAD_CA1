document.addEventListener("DOMContentLoaded", loadCartItems);

function loadCartItems() {
    fetch(contextPath + "/CartServlet")
    .then(response => response.json())
    .then(data => displayCartItems(data.cartItems))
    .catch(error => console.error("Error loading cart items:", error));
}

function displayCartItems(cartItems) {
    const cartContainer = document.getElementById("cartItems");
    if (!cartContainer) return;

    if (cartItems.length === 0) {
        cartContainer.innerHTML = "<p>Your cart is empty.</p>";
        return;
    }

    let tableHTML = `
    <table class="table table-striped">
    <thead>
    <tr>
    <th><input type="checkbox" id="selectAll" onchange="toggleAllCheckboxes(this)"></th>
    <th>Service Name</th>
    <th>Booking Time</th>
    <th>Price</th>
    <th>Remarks</th>
    <th>Action</th>
    </tr>
    </thead>
    <tbody>
    `;

    cartItems.forEach(item => {
        tableHTML += `
        <tr>
        <td><input type="checkbox" class="cart-checkbox" data-id="${item.id}"></td>
        <td>${item.serviceName}</td>
        <td>${item.bookingTime}</td>
        <td>$${item.price.toFixed(2)}</td>
        <td>${item.remarks}</td>
        <td><button class="btn btn-danger btn-sm" onclick="deleteCartItem(${item.id})">Remove</button></td>
        </tr>
        `;
    });

    tableHTML += `
    </tbody>
    </table>
    <button class="btn btn-primary mt-3" onclick="checkout()">Checkout</button>
    `;

    cartContainer.innerHTML = tableHTML;
}

function toggleAllCheckboxes(selectAll) {
    document.querySelectorAll(".cart-checkbox").forEach(checkbox => {
        checkbox.checked = selectAll.checked;
    });
}

function checkout() {
    const selectedCheckboxes = document.querySelectorAll(".cart-checkbox:checked");
    const selectedItems = Array.from(selectedCheckboxes).map(checkbox => parseInt(checkbox.dataset.id, 10));

    console.log("🛒 Selected cart item IDs:", selectedItems); // Debugging

    if (selectedItems.length === 0) {
        console.log("Checkout Error: No items selected for checkout.");
        alert("No items selected for checkout.");
        return;
    }

    console.log("Sending POST request to CheckoutServlet with items:", selectedItems);

    fetch(contextPath + "/CheckoutServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            cartItemIds: selectedItems,
            action: "startCheckout"
        })
    })
    .then(response => {
        console.log("Received response from CheckoutServlet:", response.status);
        if (response.ok) {
            return response.json(); // Only parse as JSON if the response is OK
        } else {
            throw new Error('Server returned non-OK status: ' + response.status);
        }
    })
    .then(data => {
        console.log("Response data from CheckoutServlet:", data);
        if (data.success) {
            console.log("✅ Checkout successful, redirecting...");
            window.location.href = `${contextPath}/user/checkout.jsp?totalAmount=${data.totalAmount}`;
        } else {
            console.log("Checkout Error with data received:", data);
            alert(data.message || "Error preparing checkout. Please try again.");
        }
    })
    .catch(error => {
        console.error("❌ Checkout Error:", error);
        alert("Checkout failed. Please check the console for more details.");
    });
}


function deleteCartItem(cartItemId) {
    fetch(`${contextPath}/CartServlet?id=${cartItemId}`, { method: "DELETE" })
    .then(response => {
        if (response.status === 204) {
            loadCartItems();
        } else {
            alert("Failed to remove item from cart.");
        }
    })
    .catch(error => console.error("Error deleting cart item:", error));
}
