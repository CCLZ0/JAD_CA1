package models;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dbaccess.DBConnection;

public class ServiceDAO {

    public List<String[]> searchServices(String query) {
        List<String[]> suggestions = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT id, service_name FROM service";
            if (query != null && !query.isEmpty()) {
                sql += " WHERE service_name LIKE ?";
            }
            stmt = conn.prepareStatement(sql);
            if (query != null && !query.isEmpty()) {
                stmt.setString(1, query + "%");
            }

            rs = stmt.executeQuery();
            while (rs.next()) {
                suggestions.add(new String[]{String.valueOf(rs.getInt("id")), rs.getString("service_name")});
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return suggestions;
    }
}