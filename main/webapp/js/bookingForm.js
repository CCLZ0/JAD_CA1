function validateBookingTime() {
    const bookingTimeInput = document.getElementById('bookingTime').value;
    if (!bookingTimeInput) {
        alert('Please select a booking time.');
        return false;
    }

    const bookingTime = new Date(bookingTimeInput);
    const now = new Date();
    const day = bookingTime.getDay(); // 0 (Sunday) to 6 (Saturday)
    const hours = bookingTime.getHours(); // 0 to 23

    // Check if the booking time is in the past
    if (bookingTime < now) {
        alert('Booking time cannot be in the past.');
        return false;
    }

    // Check if the day is Sunday (0)
    if (day === 0) {
        alert('Booking is not allowed on Sundays.');
        return false;
    }

    // Check if the time is between 9 AM (9) and 6 PM (18)
    if (hours < 9 || hours > 17) {
        alert('Booking time must be between 9 AM and 6 PM.');
        return false;
    }

    return true;
}