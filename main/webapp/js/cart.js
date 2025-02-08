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
    const selectedItems = selectedCheckboxes.length > 0
        ? Array.from(selectedCheckboxes).map(checkbox => parseInt(checkbox.dataset.id))
        : Array.from(document.querySelectorAll(".cart-checkbox")).map(checkbox => parseInt(checkbox.dataset.id));

    if (selectedItems.length === 0) {
        alert("No items in the cart to checkout.");
        return;
    }

    fetch(contextPath + "/CheckoutServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ cartItemIds: selectedItems })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            window.location.href = contextPath + "/user/checkout.jsp"; // Redirect after backend processing
        } else {
            alert("Error during checkout. Please try again.");
        }
    })
    .catch(error => {
        console.error("Checkout Error:", error);
        alert("An error occurred. Please try again.");
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