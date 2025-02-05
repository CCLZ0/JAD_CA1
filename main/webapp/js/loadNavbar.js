// loadNavbar.js
document.addEventListener('DOMContentLoaded', function () {
    console.log('Fetching navbar data from:', contextPath + '/NavbarServlet');

    fetch(contextPath + '/NavbarServlet')
        .then(response => {
            if (!response.ok) throw new Error('Navbar data retrieval failed');
            return response.json();
        })
        .then(data => {
            console.log('Navbar Data Retrieved:', data);

            const userName = data.userName;
            const userRole = data.role; // Ensure correct key mapping
            const categories = data.categories;

            // Update categories dropdown
            const servicesDropdown = document.getElementById('servicesDropdown');
            const dropdownMenu = servicesDropdown ? servicesDropdown.nextElementSibling : null;

            if (dropdownMenu && categories && Array.isArray(categories)) {
                dropdownMenu.innerHTML = ''; // Clear existing items
                categories.forEach(category => {
                    const item = document.createElement('li');
                    item.innerHTML = `<a class="dropdown-item" href="${contextPath}/user/services.jsp?categoryId=${category.id}">${category.name}</a>`;
                    dropdownMenu.appendChild(item);
                });
            } else if (dropdownMenu) {
                dropdownMenu.innerHTML = '<p>No categories available</p>';
            }

            // Update user info in navbar
            const userLink = document.getElementById('userLink');
            const userDropdownMenu = document.getElementById('userDropdownMenu');

            if (userLink && userDropdownMenu) {
                if (userName && userRole) {
                    userLink.textContent = userName;
                    userLink.href = '#'; // Disable the link
                    userLink.classList.add('dropdown-toggle');
                    userLink.setAttribute('role', 'button');
                    userLink.setAttribute('data-bs-toggle', 'dropdown');
                    userLink.setAttribute('aria-expanded', 'false');

                    userDropdownMenu.innerHTML = `
                        <li><a class="dropdown-item" href="${contextPath}/user/profile.jsp">Profile</a></li>
                        <li><a class="dropdown-item" href="${contextPath}/login/logout.jsp">Logout</a></li>
                    `;

                    if (userRole === 'admin') {
                        const adminDashboard = document.createElement('li');
                        adminDashboard.innerHTML = `<a class="dropdown-item" href="${contextPath}/admin/dashboard.jsp">Admin Dashboard</a>`;
                        userDropdownMenu.insertBefore(adminDashboard, userDropdownMenu.firstChild);
                    } else if (userRole === 'member') {
                        const bookingHistory = document.createElement('li');
                        bookingHistory.innerHTML = `<a class="dropdown-item" href="${contextPath}/user/bookingHistory.jsp">Booking History</a>`;
                        userDropdownMenu.insertBefore(bookingHistory, userDropdownMenu.firstChild);

                        const cart = document.createElement('li');
                        cart.innerHTML = `<a class="dropdown-item" href="${contextPath}/user/cart.jsp">Cart</a>`;
                        userDropdownMenu.insertBefore(cart, userDropdownMenu.firstChild);
                    }
                } else {
                    // If user is not logged in
                    userLink.textContent = 'Login/Sign Up';
                    userLink.href = `${contextPath}/login/login.jsp`;
                    userDropdownMenu.innerHTML = ''; // No dropdown for guests
                }
            } else {
                console.error("Navbar elements not found in DOM!");
            }
        })
        .catch(error => {
            console.error('Error while fetching navbar data:', error);
            alert('Failed to load navbar. Please try again later.');
        });
});
