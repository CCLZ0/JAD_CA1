package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dbaccess.DBConnection;

public class NavbarDAO {

    public ArrayList<String[]> getCategories() {
        ArrayList<String[]> categories = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection()) {
            String query = "SELECT id, category_name FROM service_category";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                String[] category = new String[2];
                category[0] = resultSet.getString("id");
                category[1] = resultSet.getString("category_name");
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public NavbarData getUserData(int userId) {
        NavbarData userData = null;
        String query = "SELECT name, role FROM user WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    userData = new NavbarData(rs.getString("name"), rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userData;
    }
}
