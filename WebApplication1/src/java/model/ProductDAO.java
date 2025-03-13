package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=cakeManagement1;user=sa;password=123456789;encrypt=false;trustServerCertificate=true";

    public static List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
            String query = "SELECT Product_ID, Name, Price, Stock, Product_Description, Product_img FROM Product";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                    rs.getInt("Product_ID"),
                    rs.getString("Name"),
                    rs.getDouble("Price"),
                    rs.getInt("Stock"),
                    rs.getString("Product_Description"),
                    rs.getString("Product_img")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
