package com.shinepro.admin.dbaccess;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

	public User getUserDetails(String userid) throws SQLException {
		User uBean = null;
		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT id, email, name, password, role FROM user WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				uBean = new User(rs.getInt("id"), rs.getString("email"), rs.getString("name"), rs.getString("password"),
						rs.getString("role"));
				System.out.print(".....done writing to bean!.....");
			}
		} catch (Exception e) {
			System.out.print("............UserTableDB:" + e);
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
		return uBean;
	}

	public List<User> listAllUsers() throws SQLException {
		List<User> users = new ArrayList<>();
		String query = "SELECT id, email, name, password, role FROM user";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(query);
				ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				users.add(new User(rs.getInt("id"), rs.getString("email"), rs.getString("name"),
						rs.getString("password"), rs.getString("role")));
			}
		}
		return users;
	}

	public boolean emailExists(String email) throws SQLException {
		String query = "SELECT COUNT(*) FROM user WHERE email = ?";
		boolean exists = false;
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, email);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					exists = rs.getInt(1) > 0;
				}
			}
		}
		return exists;
	}

	public int insertUser(User user) throws SQLException {
		String query = "INSERT INTO user (email, name, password, role) VALUES (?, ?, ?, ?)";
		String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, user.getEmail());
			stmt.setString(2, user.getName());
			stmt.setString(3, hashedPassword);
			stmt.setString(4, user.getRole());
			return stmt.executeUpdate();
		}
	}

	public int updateUser(String uid, User user) throws SQLException {
		String query = "UPDATE user SET email = ?, name = ?, password = ?, role = ? WHERE id = ?";
		String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, user.getEmail());
			stmt.setString(2, user.getName());
			stmt.setString(3, hashedPassword);
			stmt.setString(4, user.getRole());
			stmt.setString(5, uid);
			return stmt.executeUpdate();
		}
	}

	public int deleteUser(String uid) throws SQLException {
		String query = "DELETE FROM user WHERE id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, uid);
			return stmt.executeUpdate();
		}
	}

	public User verifyUser(String email, String password) throws SQLException {
		User user = null;
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
				String storedHashedPassword = rs.getString("password");
				if (BCrypt.checkpw(password, storedHashedPassword)) {
					user = new User(rs.getInt("id"), rs.getString("email"), rs.getString("name"),
							rs.getString("password"), rs.getString("role"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return user;
	}

	public boolean isAdmin(int userid) throws SQLException {
		String query = "SELECT role FROM user WHERE id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, userid);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					return "admin".equalsIgnoreCase(rs.getString("role"));
				}
			}
		}
		return false;
	}
}