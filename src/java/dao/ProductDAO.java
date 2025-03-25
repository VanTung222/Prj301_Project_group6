package dao;

import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductDAO {

    // Lấy tất cả sản phẩm
    public List<Product> getAllProducts() throws SQLException {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT Product_ID, Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img FROM Product";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                while (rs.next()) {
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
                    productList.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return productList;
    }

    // Lấy sản phẩm theo ID
    public Product getProductById(int productId) throws SQLException {
        Product product = null;
        String query = "SELECT Product_ID, Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img FROM Product WHERE Product_ID = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(query);
                ps.setInt(1, productId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Name"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock"),
                        rs.getString("Product_Description"),
                        rs.getInt("Product_Category_ID"),
                        rs.getInt("Supplier_ID"),
                        rs.getString("Product_img")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return product;
    }
    
    public static List<Product> searchProductsByName(String keyword) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT Product_ID, Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img FROM Product WHERE Name LIKE ? OR Product_Description LIKE ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
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
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }
    
    public int getTotalProducts() throws SQLException, ClassNotFoundException {
        Connection conn = DBUtils.getConnection();
        String sql = "SELECT COUNT(*) as count FROM Product";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("count");
        }
        return 0;
    }

    // Lấy số sản phẩm sắp hết hàng (dưới 10 sản phẩm)
    public int getLowStockItemsCount() throws SQLException, ClassNotFoundException {
        Connection conn = DBUtils.getConnection();
        String sql = "SELECT COUNT(*) as count FROM Product WHERE Stock < 10";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("count");
        }
        return 0;
    }

    // Thêm sản phẩm mới
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO Product (Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setString(4, product.getDescription());
            ps.setInt(5, product.getProductCategoryId());
            ps.setInt(6, product.getSupplierId());
            ps.setString(7, product.getProductImg());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật sản phẩm
    public boolean updateProduct(Product product) {
        String sql = "UPDATE Product SET Name=?, Price=?, Stock=?, Product_Description=?, Product_Category_ID=?, Supplier_ID=?, Product_img=? WHERE Product_ID=?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setString(4, product.getDescription());
            ps.setInt(5, product.getProductCategoryId());
            ps.setInt(6, product.getSupplierId());
            ps.setString(7, product.getProductImg());
            ps.setInt(8, product.getProductId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa sản phẩm
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM Product WHERE Product_ID=?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Tìm kiếm sản phẩm
    public List<Product> searchProducts(String searchTerm) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT Product_ID, Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img FROM Product WHERE Name LIKE ? OR Product_Description LIKE ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + searchTerm + "%");
            ps.setString(2, "%" + searchTerm + "%");
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
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
                    products.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
}