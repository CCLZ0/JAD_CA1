package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import dbaccess.DBConnection;

public class BookingDAO {

    public boolean addServiceToCart(int userId, int serviceId, String bookingTime, String remarks) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean isAdded = false;

        try {
            conn = DBConnection.getConnection();
            String query = "INSERT INTO cart (user_id, service_id, booking_time, price, remarks) VALUES (?, ?, ?, (SELECT price FROM service WHERE id = ?), ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, serviceId);
            pstmt.setString(3, bookingTime);
            pstmt.setInt(4, serviceId);
            pstmt.setString(5, remarks != null ? remarks : "");
            int rowsAffected = pstmt.executeUpdate();
            isAdded = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return isAdded;
    }
}