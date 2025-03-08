package model;

import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDAO {
    private Connection conn;

    // Constructor khởi tạo kết nối
    public ProductDAO() {
        try {
            this.conn = DBUtils.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy tất cả sản phẩm
    public static List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT Product_ID, Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID FROM Product";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("Product_ID"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setDescription(rs.getString("Product_Description"));
                product.setCategoryID(rs.getInt("Product_Category_ID"));
                product.setSupplierID(rs.getInt("Supplier_ID"));
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Lấy sản phẩm theo ID
    public static Product getProductById(int productId) {
        Product product = null;
        String query = "SELECT * FROM Product WHERE Product_ID = ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                product = new Product();
                product.setProductID(rs.getInt("Product_ID"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setDescription(rs.getString("Product_Description"));
                product.setCategoryID(rs.getInt("Product_Category_ID"));
                product.setSupplierID(rs.getInt("Supplier_ID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

   
    public static List<Product> searchProductsByName(String keyword) {
    List<Product> productList = new ArrayList<>();
    String sql = "SELECT Product_ID, Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Image FROM Product WHERE Name LIKE ?";

    try (Connection conn = DBUtils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, "%" + keyword + "%");
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Product p = new Product();
            p.setProductID(rs.getInt("Product_ID"));
            p.setName(rs.getString("Name"));
            p.setPrice(rs.getDouble("Price"));
            p.setStock(rs.getInt("Stock"));
            p.setDescription(rs.getString("Product_Description"));
            p.setCategoryID(rs.getInt("Product_Category_ID"));
            p.setSupplierID(rs.getInt("Supplier_ID"));
            p.setImage(rs.getString("Image"));
            
            productList.add(p);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }   catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    return productList;
}

}
