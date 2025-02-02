document.addEventListener('DOMContentLoaded', function() {
    fetchCartItems();
});

function fetchCartItems() {
    fetch(contextPath + '/CartServlet')
        .then(response => response.json())
        .then(data => {
            const cartItemsDiv = document.getElementById('cartItems');
            cartItemsDiv.innerHTML = '';

            if (data.length === 0) {
                cartItemsDiv.innerHTML = '<p>Your cart is empty.</p>';
            } else {
                data.forEach(item => {
                    const itemDiv = document.createElement('div');
                    itemDiv.classList.add('card', 'mb-3');
                    itemDiv.innerHTML = `
                        <div class="card-body">
                            <h5 class="card-title">${item.serviceName}</h5>
                            <p class="card-text">Booking Time: ${item.bookingTime}</p>
                            <p class="card-text">Price: $${item.price}</p>
                            <p class="card-text">Remarks: ${item.remarks}</p>
                            <button class="btn btn-danger" onclick="deleteCartItem(${item.id})">Delete</button>
                        </div>
                    `;
                    cartItemsDiv.appendChild(itemDiv);
                });
            }
        })
        .catch(error => console.error('Error fetching cart items:', error));
}

function deleteCartItem(cartItemId) {
    fetch(contextPath + `/CartServlet?id=${cartItemId}`, {
        method: 'DELETE'
    })
	.then(response => {
	        if (response.status === 204) {
	            alert('Item successfully deleted.');
	            fetchCartItems(); // Refresh the cart items
	        } else {
	            console.error('Failed to delete cart item');
	        }
	    })
	.catch(error => console.error('Error deleting cart item:', error));
}