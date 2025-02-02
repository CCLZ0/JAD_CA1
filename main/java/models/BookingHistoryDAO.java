package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dbaccess.DBConnection;

public class BookingHistoryDAO {

    public List<Booking> getBookingHistory(int userId) {
        List<Booking> bookingHistory = new ArrayList<>();
        String sql = "SELECT b.id, s.service_name, b.booking_date, b.remarks, st.status_name, b.status, f.id AS feedback_id " +
                     "FROM booking b " +
                     "JOIN service s ON b.service_id = s.id " +
                     "JOIN status st ON b.status = st.id " +
                     "LEFT JOIN feedback f ON b.id = f.booking_id " +
                     "WHERE b.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setId(rs.getInt("id"));
                    booking.setServiceName(rs.getString("service_name"));
                    booking.setBookingDate(rs.getString("booking_date"));
                    booking.setRemarks(rs.getString("remarks"));
                    booking.setStatusName(rs.getString("status_name"));
                    booking.setStatusId(rs.getInt("status"));
                    booking.setFeedbackId(rs.getInt("feedback_id"));
                    bookingHistory.add(booking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookingHistory;
    }
}