function validateBookingTime() {
    const bookingTimeInput = document.getElementById('bookingTime');
    const bookingTime = new Date(bookingTimeInput.value);
    const now = new Date();

    if (bookingTime < now) {
        alert('Booking time cannot be in the past.');
        return false;
    }
    return true;
}