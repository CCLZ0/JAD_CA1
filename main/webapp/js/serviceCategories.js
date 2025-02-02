document.addEventListener('DOMContentLoaded', function() {
    fetchServiceCategories();
});

function fetchServiceCategories() {
    fetch(contextPath + '/ServiceCategoryServlet')
        .then(response => response.json())
        .then(data => {
            const serviceCategoriesDiv = document.getElementById('serviceCategories');
            serviceCategoriesDiv.innerHTML = '';

            if (data.length === 0) {
                serviceCategoriesDiv.innerHTML = '<p>No service categories available.</p>';
            } else {
                data.forEach(category => {
                    const categoryDiv = document.createElement('div');
                    categoryDiv.classList.add('card', 'mb-3');
                    categoryDiv.innerHTML = `
                        <div class="card-body">
                            <h5 class="card-title">${category.name}</h5>
                            <p class="card-text">${category.description}</p>
                            <a href="${contextPath}/user/services.jsp?categoryId=${category.id}" class="btn btn-primary">View Services</a>
                        </div>
                    `;
                    serviceCategoriesDiv.appendChild(categoryDiv);
                });
            }
        })
        .catch(error => console.error('Error fetching service categories:', error));
}