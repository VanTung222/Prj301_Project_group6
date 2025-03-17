package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.Product;

public class CartDAO {
    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=cakeManagement;user=sa;password=;encrypt=false;trustServerCertificate=true";

    public void addToCart(int customerId, int productId) {
        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
            String checkCartQuery = "SELECT Quantity FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkCartQuery);
            checkStmt.setInt(1, customerId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int quantity = rs.getInt("Quantity") + 1;
                updateCart(customerId, productId, quantity);
            } else {
                String insertCartQuery = "INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date) VALUES (?, ?, ?, GETDATE())";
                PreparedStatement insertStmt = conn.prepareStatement(insertCartQuery);
                insertStmt.setInt(1, customerId);
                insertStmt.setInt(2, productId);
                insertStmt.setInt(3, 1);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeFromCart(int customerId, int productId) {
        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
            String deleteCartQuery = "DELETE FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteCartQuery);
            deleteStmt.setInt(1, customerId);
            deleteStmt.setInt(2, productId);
            deleteStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCart(int customerId, int productId, int quantity) {
        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
            String updateCartQuery = "UPDATE Shopping_Cart SET Quantity = ? WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateCartQuery);
            updateStmt.setInt(1, quantity);
            updateStmt.setInt(2, customerId);
            updateStmt.setInt(3, productId);
            updateStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<CartItem> getCartItems(int customerId) {
        List<CartItem> cartItems = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
            String query = "SELECT p.Product_ID, p.Name, p.Price, p.Stock, p.Product_Description, p.Product_img, c.Quantity " +
                           "FROM Shopping_Cart c JOIN Product p ON c.Product_ID = p.Product_ID " +
                           "WHERE c.Customer_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Name"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock"),
                        rs.getString("Product_Description"),
                        rs.getInt("productCategoryId"),
                        rs.getInt("supplierId"),
                        rs.getString("Product_img")
                );
                int quantity = rs.getInt("Quantity");
                cartItems.add(new CartItem(product, quantity));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }
}   

