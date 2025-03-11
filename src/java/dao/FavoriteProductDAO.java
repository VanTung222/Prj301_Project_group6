package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.FavoriteProduct;
import model.Product;
import utils.DBUtils;

public class FavoriteProductDAO {
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    
    public List<FavoriteProduct> getFavoritesByCustomerId(int customerId) {
        List<FavoriteProduct> favorites = new ArrayList<>();
        String query = "SELECT fp.*, p.Name, p.Price, p.Product_img, p.Product_Description, " +
                      "p.Stock, p.Product_Category_ID, p.Supplier_ID " +
                      "FROM Favorite_Products fp " +
                      "JOIN Product p ON fp.Product_ID = p.Product_ID " +
                      "WHERE fp.Customer_ID = ?";
        
        try {
            conn = new DBUtils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                FavoriteProduct favorite = new FavoriteProduct();
                favorite.setFavoriteId(rs.getInt("Favorite_ID"));
                favorite.setCustomerId(rs.getInt("Customer_ID"));
                favorite.setProductId(rs.getInt("Product_ID"));
                favorite.setAddedDate(rs.getDate("Added_Date"));
                
                // Create Product object and set its properties
                Product product = new Product(
                    rs.getInt("Product_ID"),
                    rs.getString("Name"),
                    rs.getDouble("Price"),
                    rs.getInt("Stock"),
                    rs.getString("Product_Description"),
                    rs.getInt("Product_Category_ID"),
                    rs.getInt("Supplier_ID"),
                    rs.getString("Product_img")
                );
                
                favorite.setProduct(product);
                favorites.add(favorite);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            closeResources();
        }
        return favorites;
    }
    
    public boolean addToFavorites(int customerId, int productId) throws ClassNotFoundException {
        String query = "INSERT INTO Favorite_Products (Customer_ID, Product_ID, Added_Date) VALUES (?, ?, GETDATE())";
        try {
            conn = new DBUtils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }
    
    public boolean removeFromFavorites(int customerId, int productId) throws ClassNotFoundException {
        String query = "DELETE FROM Favorite_Products WHERE Customer_ID = ? AND Product_ID = ?";
        try {
            conn = new DBUtils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }
    
    public boolean isFavorite(int customerId, int productId) throws ClassNotFoundException {
        String query = "SELECT COUNT(*) FROM Favorite_Products WHERE Customer_ID = ? AND Product_ID = ?";
        try {
            conn = new DBUtils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            closeResources();
        }
        return false;
    }
    
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            System.out.println("Error closing resources: " + e.getMessage());
        }
    }
}