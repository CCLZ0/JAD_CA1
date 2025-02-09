package models;

import dbaccess.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CheckoutDAO {

    public boolean checkout(int userId, String[] cartItemIds) {
        Connection conn = null;
        PreparedStatement pstmtInsert = null;
        PreparedStatement pstmtDelete = null;
        boolean success = false;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Unable to establish a database connection.");
            }

            // Insert specific cart items to booking table
            String insertQuery = "INSERT INTO booking (user_id, service_id, booking_date, remarks, status) " +
                "SELECT user_id, service_id, booking_time, remarks, " +
                "(SELECT id FROM status WHERE status_name = 'Incomplete') " +
                "FROM cart WHERE user_id = ? AND id = ?";
            
            conn.setAutoCommit(false); // Start transaction
            
            pstmtInsert = conn.prepareStatement(insertQuery);
            
            // Insert each selected cart item
            for (String cartItemId : cartItemIds) {
                pstmtInsert.setInt(1, userId);
                pstmtInsert.setInt(2, Integer.parseInt(cartItemId));
                pstmtInsert.executeUpdate();
            }

            // Delete selected cart items
            String deleteQuery = "DELETE FROM cart WHERE user_id = ? AND id = ?";
            pstmtDelete = conn.prepareStatement(deleteQuery);
            
            for (String cartItemId : cartItemIds) {
                pstmtDelete.setInt(1, userId);
                pstmtDelete.setInt(2, Integer.parseInt(cartItemId));
                pstmtDelete.executeUpdate();
            }

            conn.commit(); // Commit transaction
            success = true;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback in case of error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset to default
                    conn.close();
                }
                if (pstmtInsert != null) pstmtInsert.close();
                if (pstmtDelete != null) pstmtDelete.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    // New method to calculate total amount
    public int getTotalAmount(List<Integer> cartItemIds) {
        int totalAmount = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Unable to establish a database connection.");
            }

            StringBuilder query = new StringBuilder("SELECT SUM(price) AS total FROM cart WHERE id IN (");
            for (int i = 0; i < cartItemIds.size(); i++) {
                query.append("?");
                if (i < cartItemIds.size() - 1) {
                    query.append(", ");
                }
            }
            query.append(")");

            pstmt = conn.prepareStatement(query.toString());

            for (int i = 0; i < cartItemIds.size(); i++) {
                pstmt.setInt(i + 1, cartItemIds.get(i));
            }

            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalAmount = rs.getInt("total");
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

    public boolean completeCheckout(int userId, List<Integer> cartItemIds) {
        Connection conn = null;
        PreparedStatement moveToBooking = null;
        PreparedStatement deleteFromCart = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Move items to Booking Table
            String insertBookingSQL = "INSERT INTO booking (user_id, service_name, booking_time, price, remarks) "
                                    + "SELECT user_id, service_name, booking_time, price, remarks FROM cart WHERE id = ?";
            moveToBooking = conn.prepareStatement(insertBookingSQL);

            for (Integer id : cartItemIds) {
                moveToBooking.setInt(1, id);
                moveToBooking.addBatch();
            }
            moveToBooking.executeBatch();

            // Delete items from Cart
            String deleteCartSQL = "DELETE FROM cart WHERE id = ?";
            deleteFromCart = conn.prepareStatement(deleteCartSQL);

            for (Integer id : cartItemIds) {
                deleteFromCart.setInt(1, id);
                deleteFromCart.addBatch();
            }
            deleteFromCart.executeBatch();

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        } finally {
            try { if (moveToBooking != null) moveToBooking.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (deleteFromCart != null) deleteFromCart.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

}
