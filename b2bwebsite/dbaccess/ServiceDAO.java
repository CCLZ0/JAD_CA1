package com.myshop.b2bwebsite.dbaccess;

import java.sql.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ServiceDAO {

    public Service getServiceById(int id) throws SQLException {
        String query = "SELECT * FROM service WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Service(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getString("service_name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
                    );
                }
            }
        }
        return null;
    }

    public List<Service> getAllServices() throws SQLException {
        List<Service> services = new ArrayList<>();
        String query = "SELECT * FROM service";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                services.add(new Service(
                    rs.getInt("id"),
                    rs.getInt("category_id"),
                    rs.getString("service_name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("img")
                ));
            }
        }
        return services;
    }
    
    public List<Service> getServicesByCategory(int categoryId) throws SQLException {
        List<Service> services = new ArrayList<>();
        String query = "SELECT * FROM service WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    services.add(new Service(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getString("service_name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
                    ));
                }
            }
        }
        return services;
    }

    public boolean addService(Service service) throws SQLException {
        String query = "INSERT INTO service (category_id, service_name, description, price, img) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, service.getCategoryId());
            stmt.setString(2, service.getServiceName());
            stmt.setString(3, service.getDescription());
            stmt.setDouble(4, service.getPrice());
            stmt.setString(5, service.getImg());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateService(Service service) throws SQLException {
        String query = "UPDATE service SET category_id = ?, service_name = ?, description = ?, price = ?, img = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, service.getCategoryId());
            stmt.setString(2, service.getServiceName());
            stmt.setString(3, service.getDescription());
            stmt.setDouble(4, service.getPrice());
            stmt.setString(5, service.getImg());
            stmt.setInt(6, service.getId());
            System.out.println("Executing update with ID: " + service.getId());
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        }
    }

    public boolean deleteService(int id) throws SQLException {
        String query = "DELETE FROM service WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public List<Map<String, Object>> getAverageRating() throws SQLException {
        List<Map<String, Object>> ratings = new ArrayList<>();
        String query = "SELECT s.service_name, s.description, IFNULL(AVG(f.rating), 0) AS average_rating " +
                       "FROM service s " +
                       "LEFT JOIN feedback f ON s.id = f.service_id " +
                       "GROUP BY s.id " +
                       "ORDER BY s.service_name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> rating = new HashMap<>();
                rating.put("averageRating", rs.getDouble("average_rating"));
                rating.put("description", rs.getString("description"));
                rating.put("serviceName", rs.getString("service_name"));
                ratings.add(rating);
            }
        }
        return ratings;
    }

    public List<Map<String, Object>> getBookingCount() throws SQLException {
        List<Map<String, Object>> bookings = new ArrayList<>();
        String query = "SELECT s.service_name, COUNT(b.id) AS booking_count " +
                       "FROM service s " +
                       "LEFT JOIN booking b ON s.id = b.service_id " +
                       "GROUP BY s.id " +
                       "ORDER BY booking_count DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("serviceName", rs.getString("service_name"));
                booking.put("bookingCount", rs.getInt("booking_count"));
                bookings.add(booking);
            }
        }
        return bookings;
    }
}