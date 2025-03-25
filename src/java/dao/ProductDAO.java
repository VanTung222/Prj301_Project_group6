package dao;

import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

public class ProductDAO {
    private Connection conn;

    public ProductDAO() {
        try {
            try {
                conn = DBUtils.getConnection();
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

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
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
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
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
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

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO Product (Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setString(4, product.getDescription());
            ps.setInt(5, product.getProductCategoryId());
            ps.setInt(6, product.getSupplierId());
            ps.setString(7, product.getProductImg());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE Product SET Name=?, Price=?, Stock=?, Product_Description=?, Product_Category_ID=?, Supplier_ID=?, Product_img=? WHERE Product_ID=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setString(4, product.getDescription());
            ps.setInt(5, product.getProductCategoryId());
            ps.setInt(6, product.getSupplierId());
            ps.setString(7, product.getProductImg());
            ps.setInt(8, product.getProductId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM Product WHERE Product_ID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
   
    // Lấy tổng số sản phẩm
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
    
     // Lấy sản phẩm liên quan (sửa lại cho SQL Server)
    public List<Product> getRelatedProducts(int productId, int categoryId, int limit) throws SQLException, ClassNotFoundException {
        List<Product> relatedProducts = new ArrayList<>();
        String query = "SELECT TOP (?) Product_ID, Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img " +
                      "FROM Product " +
                      "WHERE Product_Category_ID = ? AND Product_ID != ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection");
            }
            ps = conn.prepareStatement(query);
            ps.setInt(1, limit);      // Giới hạn số lượng bản ghi (TOP)
            ps.setInt(2, categoryId); // Đặt categoryId
            ps.setInt(3, productId);  // Loại bỏ sản phẩm hiện tại
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
                relatedProducts.add(product);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return relatedProducts;
    }

     
}