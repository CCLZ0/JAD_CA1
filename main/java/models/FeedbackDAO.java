package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dbaccess.DBConnection;

public class FeedbackDAO {

    public Feedback getFeedbackDetails(int bookingId) {
        Feedback feedback = null;
        String sql = "SELECT b.user_id, s.id AS service_id, s.service_name, b.booking_date " +
                     "FROM booking b " +
                     "JOIN service s ON b.service_id = s.id " +
                     "WHERE b.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, bookingId);
            System.out.println("Executing query with bookingId: " + bookingId); // Log bookingId
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    feedback = new Feedback();
                    feedback.setUserId(rs.getInt("user_id"));
                    feedback.setServiceId(rs.getInt("service_id"));
                    feedback.setServiceName(rs.getString("service_name"));
                    feedback.setBookingDate(rs.getString("booking_date"));
                    System.out.println("Feedback details retrieved: " + feedback.getServiceName() + ", " + feedback.getBookingDate());
                } else {
                    System.out.println("No feedback details found for bookingId: " + bookingId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedback;
    }

    public void submitFeedback(int userId, int serviceId, int bookingId, int rating, String description, String suggestion) {
        String sql = "INSERT INTO feedback (user_id, service_id, booking_id, rating, description, suggestion) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, serviceId);
            pstmt.setInt(3, bookingId);
            pstmt.setInt(4, rating);
            pstmt.setString(5, description);
            pstmt.setString(6, suggestion);
            pstmt.executeUpdate();
            System.out.println("Feedback submitted for bookingId: " + bookingId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}