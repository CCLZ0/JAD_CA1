package models;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dbaccess.DBConnection;

public class BookingHistoryDAO {

	public List<Booking> getBookingHistory(int userId) {
		List<Booking> bookingHistory = new ArrayList<>();
		String sql = "SELECT b.id, s.service_name, b.booking_date, b.remarks, st.status_name, b.status, f.id AS feedback_id "
				+ "FROM booking b " + "JOIN service s ON b.service_id = s.id " + "JOIN status st ON b.status = st.id "
				+ "LEFT JOIN feedback f ON b.id = f.booking_id " + "WHERE b.user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

	// Methods for admin dashboard
	public List<Map<String, Object>> getTopCustomersByBookingValue() throws SQLException {
		List<Map<String, Object>> topCustomers = new ArrayList<>();
		String query = "SELECT u.id AS customerId, u.name AS customerName, SUM(s.price) AS totalBookingValue "
				+ "FROM booking b " + "JOIN user u ON b.user_id = u.id " + "JOIN service s ON b.service_id = s.id "
				+ "GROUP BY u.id, u.name " + "ORDER BY totalBookingValue DESC " + "LIMIT 10";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(query);
				ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				Map<String, Object> customer = new HashMap<>();
				customer.put("customerId", rs.getInt("customerId"));
				customer.put("customerName", rs.getString("customerName"));
				customer.put("totalBookingValue", rs.getDouble("totalBookingValue"));
				topCustomers.add(customer);
			}
		}
		return topCustomers;
	}

	public List<Booking> getAllBookings() throws SQLException {
		List<Booking> bookings = new ArrayList<>();
		String query = "SELECT b.id, s.service_name, b.booking_date, b.remarks, st.status_name, b.status, f.id AS feedback_id "
				+ "FROM booking b " + "JOIN service s ON b.service_id = s.id " + "JOIN status st ON b.status = st.id "
				+ "LEFT JOIN feedback f ON b.id = f.booking_id " + "ORDER BY b.id";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(query);
				ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				Booking booking = new Booking();
				booking.setId(rs.getInt("id"));
				booking.setServiceName(rs.getString("service_name"));
				booking.setBookingDate(rs.getString("booking_date"));
				booking.setRemarks(rs.getString("remarks"));
				booking.setStatusName(rs.getString("status_name"));
				booking.setStatusId(rs.getInt("status"));
				booking.setFeedbackId(rs.getInt("feedback_id"));
				bookings.add(booking);
			}
		}
		return bookings;
	}

    public List<Booking> getBookingsByDateRange(String startDate, String endDate) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT b.id, s.service_name, b.booking_date, b.remarks, st.status_name, b.status, f.id AS feedback_id " +
                       "FROM booking b " +
                       "JOIN service s ON b.service_id = s.id " +
                       "JOIN status st ON b.status = st.id " +
                       "LEFT JOIN feedback f ON b.id = f.booking_id " +
                       "WHERE b.booking_date BETWEEN ? AND ? " +
                       "ORDER BY b.id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setId(rs.getInt("id"));
                    booking.setServiceName(rs.getString("service_name"));
                    booking.setBookingDate(rs.getString("booking_date"));
                    booking.setRemarks(rs.getString("remarks"));
                    booking.setStatusName(rs.getString("status_name"));
                    booking.setStatusId(rs.getInt("status"));
                    booking.setFeedbackId(rs.getInt("feedback_id"));
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

	public boolean deleteBooking(int id) throws SQLException {
		String query = "DELETE FROM booking WHERE id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, id);
			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		}
	}
}