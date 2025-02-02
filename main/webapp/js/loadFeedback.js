document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const bookingId = urlParams.get('bookingId');

    if (!bookingId) {
        alert('Invalid booking ID');
        window.location.href = 'bookingHistory.jsp';
        return;
    }

    fetch(`${contextPath}/FeedbackServlet?bookingId=${bookingId}`)
        .then(response => {
            if (!response.ok) {
                if (response.status === 401) {
                    alert('User not logged in');
                    window.location.href = `${contextPath}/login/login.jsp?error=notLoggedIn`;
                } else if (response.status === 400) {
                    alert('Invalid booking ID');
                    window.location.href = 'bookingHistory.jsp';
                } else if (response.status === 404) {
                    alert('Feedback details not found');
                    window.location.href = 'bookingHistory.jsp';
                }
                throw new Error('Failed to load feedback details');
            }
            return response.json();
        })
        .then(data => {
            document.getElementById('userId').value = data.userId;
            document.getElementById('serviceId').value = data.serviceId;
            document.getElementById('serviceName').value = data.serviceName;
            document.getElementById('bookingDate').value = data.bookingDate;
        })
        .catch(error => {
            console.error('Error:', error);
        });
});