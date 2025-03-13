package model;

import java.sql.*;

public class UserDAO {
    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=cakeManagement;user=sa;password=1357910;encrypt=false;trustServerCertificate=true";

    public User getUserByEmail(String email) {
        User user = null;
        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
            String query = "SELECT Customer_ID, Username, Email, Password FROM Customers WHERE Email = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("Customer_ID"),
                    rs.getString("Username"),
                    rs.getString("Email"),
                    rs.getString("Password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
