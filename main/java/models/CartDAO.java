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
            closeResources(rs, pstmt, conn);
        }

        return cartItems;
    }
    
    public CartItem getCartItemById(int cartItemId) {
        CartItem cartItem = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT * FROM cart WHERE id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, cartItemId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                cartItem = new CartItem();
                cartItem.setId(rs.getInt("id"));
                cartItem.setServiceName(rs.getString("service_name"));
                cartItem.setPrice(rs.getDouble("price"));
                // Add other fields as necessary
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

        return cartItem;
    }

    // ✅ Method to calculate total price for selected cart items
    public double calculateTotalAmount(List<Integer> cartItemIds) {
        double totalAmount = 0.0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT SUM(price) AS totalAmount FROM cart WHERE id IN (" +
                           String.join(",", cartItemIds.stream().map(String::valueOf).toArray(String[]::new)) + ")";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                totalAmount = rs.getDouble("totalAmount");
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

        return totalAmount;
    }

    // ✅ Method to move cart items to booking table
    public boolean moveItemsToBooking(int userId, List<Integer> cartItemIds) {
        if (cartItemIds.isEmpty()) return false;

        Connection conn = null;
        PreparedStatement pstmtInsert = null;
        PreparedStatement pstmtDelete = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Prepare the SQL for inserting into the booking table
            String insertQuery = "INSERT INTO booking (user_id, service_id, booking_time, price, remarks) " +
                                 "SELECT user_id, service_id, booking_time, price, remarks FROM cart WHERE id = ?";
            pstmtInsert = conn.prepareStatement(insertQuery);

            for (Integer cartId : cartItemIds) {
                pstmtInsert.setInt(1, cartId);
                pstmtInsert.addBatch(); // Add to batch
            }

            pstmtInsert.executeBatch(); // Execute all inserts as a single batch

            // Prepare the SQL for deleting from the cart table
            String deleteQuery = "DELETE FROM cart WHERE id = ?";
            pstmtDelete = conn.prepareStatement(deleteQuery);

            for (Integer cartId : cartItemIds) {
                pstmtDelete.setInt(1, cartId);
                pstmtDelete.addBatch(); // Add to batch
            }

            pstmtDelete.executeBatch(); // Execute all deletes as a single batch

            conn.commit(); // Commit transaction
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return false;
        } finally {
            try { if (pstmtInsert != null) pstmtInsert.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmtDelete != null) pstmtDelete.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }


    // ✅ Method to delete a single cart item
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
            closeResources(null, pstmt, conn);
        }

        return isDeleted;
    }

    // ✅ Utility method to close resources
    private void closeResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
}
