package dbaccess;

import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnection() {
		
		String dbUrl = "jdbc:mysql://localhost:3306/ca1";
		String dbUser = "root";
		String dbPassword = "root123";
		String dbClass = "com.mysql.jdbc.Driver";
			
		Connection connection = null;
		try {
			Class.forName(dbClass);
		} catch (ClassNotFoundException e) {
			System.err.println("error: database driver not found");
			e.printStackTrace();
		}
		try {
			connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		} catch (SQLException e) {
			System.err.println("error: unable to start connection");
			e.printStackTrace();
		}
			
		return connection;
	}
}