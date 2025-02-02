package com.myshop.user_ws.dbaccess;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection class to manage database connections.
 * Reference: https://www.linkedin.com/learning/java-ee-concurrency-and-multithreadi
 */
public class DBConnection {

    /**
     * Establishes and returns a connection to the database.
     *
     * @return Connection object or null if an exception occurs.
     */
    public static Connection getConnection() {

        String dbUrl = "jdbc:mysql://localhost/db1";
        String dbUser = "root";
        String dbPassword = "root";
        String dbClass = "com.mysql.jdbc.Driver";

        Connection connection = null;

        try {
            Class.forName(dbClass);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return connection;
    }
}
