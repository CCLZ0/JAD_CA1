package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import dbaccess.DBConnection;

public class CartDAO {

    public List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT c.id, s.service_name, c.booking_time, c.price, c.remarks " +
                           "FROM cart c JOIN service s ON c.service_id = s.id " +
                           "WHERE c.user_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setServiceName(rs.getString("service_name"));
                item.setBookingTime(rs.getString("booking_time"));
                item.setPrice(rs.getDouble("price"));
                item.setRemarks(rs.getString("remarks"));
                cartItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return cartItems;
    }
    
    public boolean deleteCartItem(int cartItemId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean isDeleted = false;

        try {
            conn = DBConnection.getConnection();
            String query = "DELETE FROM cart WHERE id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, cartItemId);
            int rowsAffected = pstmt.executeUpdate();
            isDeleted = rowsAffected > 0;
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

        return isDeleted;
    }
}