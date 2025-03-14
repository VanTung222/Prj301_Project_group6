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

    // Tìm kiếm sản phẩm theo tên
    public List<Product> searchProductsByName(String keyword) throws SQLException {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT Product_ID, Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img FROM Product WHERE Name LIKE ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + keyword + "%");
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
}