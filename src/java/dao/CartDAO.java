package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.Product;
import utils.DBUtils;

public class CartDAO {

    public void addToCart(int customerId, int productId) throws ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            // First check if product exists and has stock
            String checkProductQuery = "SELECT Stock FROM Product WHERE Product_ID = ?";
            PreparedStatement checkProductStmt = conn.prepareStatement(checkProductQuery);
            checkProductStmt.setInt(1, productId);
            ResultSet productRs = checkProductStmt.executeQuery();

            if (!productRs.next()) {
                throw new SQLException("Product not found");
            }
            
            int stock = productRs.getInt("Stock");
            if (stock <= 0) {
                throw new SQLException("Product is out of stock");
            }

            // Check if item already exists in cart
            String checkCartQuery = "SELECT Quantity FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement checkCartStmt = conn.prepareStatement(checkCartQuery);
            checkCartStmt.setInt(1, customerId);
            checkCartStmt.setInt(2, productId);
            ResultSet cartRs = checkCartStmt.executeQuery();

            if (cartRs.next()) {
                // Update quantity if item exists
                int currentQuantity = cartRs.getInt("Quantity");
                if (currentQuantity >= stock) {
                    throw new SQLException("Not enough stock available");
                }
                updateCart(customerId, productId, currentQuantity + 1);
            } else {
                // Insert new item if it doesn't exist
                String insertCartQuery = "INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date) VALUES (?, ?, 1, GETDATE())";
                PreparedStatement insertStmt = conn.prepareStatement(insertCartQuery);
                insertStmt.setInt(1, customerId);
                insertStmt.setInt(2, productId);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding item to cart: " + e.getMessage());
        }
    }

    public void removeFromCart(int customerId, int productId) throws ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String deleteCartQuery = "DELETE FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteCartQuery);
            deleteStmt.setInt(1, customerId);
            deleteStmt.setInt(2, productId);
            deleteStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error removing item from cart: " + e.getMessage());
        }
    }

    public void updateCart(int customerId, int productId, int quantity) throws ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            if (quantity <= 0) {
                removeFromCart(customerId, productId);
            } else {
                // Check stock availability
                String checkStockQuery = "SELECT Stock FROM Product WHERE Product_ID = ?";
                PreparedStatement checkStockStmt = conn.prepareStatement(checkStockQuery);
                checkStockStmt.setInt(1, productId);
                ResultSet stockRs = checkStockStmt.executeQuery();

                if (!stockRs.next()) {
                    throw new SQLException("Product not found");
                }

                int stock = stockRs.getInt("Stock");
                if (quantity > stock) {
                    throw new SQLException("Not enough stock available");
                }

                String updateCartQuery = "UPDATE Shopping_Cart SET Quantity = ? WHERE Customer_ID = ? AND Product_ID = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateCartQuery);
                updateStmt.setInt(1, quantity);
                updateStmt.setInt(2, customerId);
                updateStmt.setInt(3, productId);
                updateStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating cart: " + e.getMessage());
        }
    }

    public List<CartItem> getCartItems(int customerId) throws ClassNotFoundException {
        List<CartItem> cartItems = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT p.Product_ID, p.Name, p.Price, p.Stock, p.Product_Description, p.Product_img, c.Quantity " +
                          "FROM Shopping_Cart c " +
                          "JOIN Product p ON c.Product_ID = p.Product_ID " +
                          "WHERE c.Customer_ID = ? " +
                          "ORDER BY c.Created_Date DESC";
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
                    rs.getString("Product_img")
                );
                int quantity = rs.getInt("Quantity");
                cartItems.add(new CartItem(product, quantity));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting cart items: " + e.getMessage());
        }
        return cartItems;
    }

    public void addToCartWithQuantity(int customerId, int productId, int quantity) throws ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            // First check if product exists and has stock
            String checkProductQuery = "SELECT Stock FROM Product WHERE Product_ID = ?";
            PreparedStatement checkProductStmt = conn.prepareStatement(checkProductQuery);
            checkProductStmt.setInt(1, productId);
            ResultSet productRs = checkProductStmt.executeQuery();

            if (!productRs.next()) {
                throw new SQLException("Product not found");
            }
            
            int stock = productRs.getInt("Stock");
            if (stock <= 0) {
                throw new SQLException("Product is out of stock");
            }
            
            if (quantity > stock) {
                throw new SQLException("Not enough stock available");
            }

            // Check if item already exists in cart
            String checkCartQuery = "SELECT Quantity FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement checkCartStmt = conn.prepareStatement(checkCartQuery);
            checkCartStmt.setInt(1, customerId);
            checkCartStmt.setInt(2, productId);
            ResultSet cartRs = checkCartStmt.executeQuery();

            if (cartRs.next()) {
                // Update quantity if item exists
                int currentQuantity = cartRs.getInt("Quantity");
                int newQuantity = currentQuantity + quantity;
                if (newQuantity > stock) {
                    throw new SQLException("Not enough stock available");
                }
                updateCart(customerId, productId, newQuantity);
            } else {
                // Insert new item if it doesn't exist
                String insertCartQuery = "INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date) VALUES (?, ?, ?, GETDATE())";
                PreparedStatement insertStmt = conn.prepareStatement(insertCartQuery);
                insertStmt.setInt(1, customerId);
                insertStmt.setInt(2, productId);
                insertStmt.setInt(3, quantity);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding item to cart: " + e.getMessage());
        }
    }
}   

