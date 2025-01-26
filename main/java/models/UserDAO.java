package models;

import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;
import dbaccess.DBConnection;

public class UserDAO {
	boolean exists = false;
	
	public User getUserDetails(String userid) throws SQLException{
		
		User uBean = null;
		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT id, email, name, role FROM user WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				uBean = new User(rs.getInt("id"), rs.getString("email"), rs.getString("name"), rs.getString("role"));
				System.out.print(".....done writing to bean!.....");
			}
		}catch (Exception e) {
			System.out.print("............UserTableDB:" + e);
		} finally {
			conn.close();
		}
		return uBean;
	}
	
	public boolean emailExists(String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM user WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    exists = rs.getInt(1) > 0;
                }
            }
        }
        return exists;
    }
	
	public boolean registerUser(String name, String email, String password) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    String query = "INSERT INTO user (name, email, password, role) VALUES (?, ?, ?, 'member')";

	    // Hash the password before storing it
	    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

	    try {
	        conn = DBConnection.getConnection();
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, name);
	        pstmt.setString(2, email);
	        pstmt.setString(3, hashedPassword);

	        int rowsAffected = pstmt.executeUpdate();
	        return rowsAffected > 0;
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
	    return false;
	}
	
	public User verifyUser(String email, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String query = "SELECT * FROM user WHERE email = ?";

        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                // User found, retrieve stored hashed password
                String storedHashedPassword = rs.getString("password");

                // Compare the entered password with the stored hashed password using BCrypt
                if (BCrypt.checkpw(password, storedHashedPassword)) {
                    // If password matches, populate and return a User bean
                    User uBean = new User(rs.getInt("id"), rs.getString("email"), rs.getString("name"), rs.getString("role"));
                    System.out.println(uBean);
                    return uBean;
                }
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

        // If no user found or password mismatch, return null
        return null;
    }
}

