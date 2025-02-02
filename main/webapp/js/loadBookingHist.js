// loadBookingHist.js
document.addEventListener('DOMContentLoaded', function() {
    console.log('Fetching booking history data from:', contextPath + '/BookingHistoryServlet');
    fetch(contextPath + '/BookingHistoryServlet')
        .then(response => {
            if (!response.ok) {
                if (response.status === 401) {
                    return response.json().then(data => {
                        alert(data.error);
                        window.location.href = contextPath + '/login/login.jsp?error=notLoggedIn';
                    });
                }
                throw new Error('Booking history data retrieval failed');
            }
            return response.json();
        })
        .then(data => {
            console.log('Booking History Data Retrieved:', data);

            const bookingHistory = data.bookingHistory;
            const tbody = document.querySelector('tbody');

            if (bookingHistory && Array.isArray(bookingHistory)) {
                tbody.innerHTML = ''; // Clear existing items
                bookingHistory.forEach(booking => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${booking.serviceName}</td>
                        <td>${booking.bookingDate}</td>
                        <td>${booking.remarks}</td>
                        <td>${booking.statusName}</td>
                        <td>
                            ${booking.statusId === 2 && booking.feedbackId === 0 ? 
                                `<a href="feedback.jsp?bookingId=${booking.id}" class="btn feedbackBtn">Feedback</a>` : 
                                booking.statusId === 2 ? 
                                `<button class="btn btn-secondary" disabled>Feedback Submitted</button>` : 
                                ''}
                        </td>
                    `;
                    tbody.appendChild(row);
                });
            } else {
                tbody.innerHTML = '<tr><td colspan="5" class="text-danger">No booking history available.</td></tr>';
            }
        })
        .catch(error => {
            console.error('Error while fetching booking history data:', error);
            alert('Failed to load booking history. Please try again later.');
        });
});