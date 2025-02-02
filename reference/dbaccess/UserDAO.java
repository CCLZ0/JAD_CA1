package com.myshop.user_ws.dbaccess;

import java.sql.*;

import java.util.ArrayList;

/**
 * This is a utility Bean for extracting user info from the DB and populating
 * the value Bean.
 */
public class UserDAO {

	/**
	 * Retrieves user details from the database using the provided userid.
	 *
	 * @param userid The ID of the user to retrieve.
	 * @return A User object containing the user's details, or null if no user is
	 *         found.
	 * @throws SQLException If a database access error occurs.
	 */
	public User getUserDetails(String userid) throws SQLException {
		User uBean = null;
		Connection conn = null;

		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT * FROM user_details WHERE userid = ?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, userid);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				uBean = new User();
				uBean.setUserid(rs.getString("userid"));
				uBean.setAge(rs.getInt("age"));
				uBean.setGender(rs.getString("gender"));
				System.out.print(".....done writing to bean!......");
			}
		} catch (Exception e) {
			System.out.println("Error in UserDetailsDB: " + e);
		} finally {
			if (conn != null) {
				conn.close();
			}
		}

		return uBean;
	}

	/**
	 * Inserts a new user into the database.
	 *
	 * @param userid The ID of the user to insert.
	 * @param age    The age of the user.
	 * @param gender The gender of the user.
	 * @return The number of rows affected by the insert operation.
	 * @throws SQLException           If a database access error occurs.
	 * @throws ClassNotFoundException If the database driver class is not found.
	 */
	public int insertUser(String userid, int age, String gender) throws SQLException, ClassNotFoundException {
		Connection conn = null;
		int nrow = 0;

		try {
			conn = DBConnection.getConnection();
			String sqlStr = "INSERT INTO user_details VALUES (?, ?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, userid);
			pstmt.setInt(2, age);
			pstmt.setString(3, gender);

			nrow = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				conn.close();
			}
		}

		return nrow;
	}

	public ArrayList<User> listAllUsers() throws SQLException {
		ArrayList<User> userList = new ArrayList<User>(); // List to store users
		User uBean = null; // Temporary user object to hold each user record
		Connection conn = null;

		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT * FROM user_details"; // Query to fetch all users
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				uBean = new User();
				uBean.setUserid(rs.getString("userid"));
				uBean.setAge(rs.getInt("age"));
				uBean.setGender(rs.getString("gender"));
				userList.add(uBean); // Add each user to the list
			}
		} catch (SQLException e) {
			System.out.println("Error in listAllUsers: " + e);
			throw e; // Propagate the exception
		} finally {
			if (conn != null) {
				conn.close(); // Close the connection
			}
		}

		return userList; // Return the list of users
	}

	public int updateUser(String uid, User user) throws SQLException {
		int rowsUpdated = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBConnection.getConnection();
			String sqlStr = "UPDATE user_details SET age = ?, gender = ? WHERE userid = ?";
			pstmt = conn.prepareStatement(sqlStr);
			pstmt.setInt(1, user.getAge());
			pstmt.setString(2, user.getGender());
			pstmt.setString(3, uid);

			rowsUpdated = pstmt.executeUpdate();
			System.out.println("Update successful. Rows affected: " + rowsUpdated);
		} catch (SQLException e) {
			System.out.println("Error in updateUser: " + e.getMessage());
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}

		return rowsUpdated;
	}

	public int deleteUser(String uid) throws SQLException {
		int rowsDeleted = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBConnection.getConnection();
			String sqlStr = "DELETE FROM user_details WHERE userid = ?";
			pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, uid);

			rowsDeleted = pstmt.executeUpdate();
			System.out.println("Delete successful. Rows affected: " + rowsDeleted);
		} catch (SQLException e) {
			System.out.println("Error in deleteUser: " + e.getMessage());
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}

		return rowsDeleted;
	}
}
