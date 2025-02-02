document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const categoryId = urlParams.get('categoryId');
    if (categoryId) {
        fetchServices(categoryId);
    }
});

function fetchServices(categoryId) {
    fetch(contextPath + '/ServiceServlet?categoryId=' + categoryId)
        .then(response => response.json())
        .then(data => {
            const servicesDiv = document.getElementById('services');
            servicesDiv.innerHTML = '';

            if (data.length === 0) {
                servicesDiv.innerHTML = '<p>No services available for this category.</p>';
            } else {
                data.forEach(service => {
                    const serviceDiv = document.createElement('div');
                    serviceDiv.classList.add('col-md-4', 'mb-3');
                    serviceDiv.innerHTML = `
                        <div class="card">
                            <img src="${service.imgPath}" class="card-img-top serviceImg" alt="${service.name}">
                            <div class="card-body">
                                <h5 class="card-title">${service.name}</h5>
                                <p class="card-text">${service.description}</p>
                                <p class="card-text"><strong>Price:</strong> $${service.price}</p>
                                <a href="bookService.jsp?serviceId=${service.id}" class="btn bookBtn">Book Now</a>
                                <a href="serviceDetails.jsp?serviceId=${service.id}" class="btn detailBtn">More Details</a>
                            </div>
                        </div>
                    `;
                    servicesDiv.appendChild(serviceDiv);
                });
            }
        })
        .catch(error => console.error('Error fetching services:', error));
}