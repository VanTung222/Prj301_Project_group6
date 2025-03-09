/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
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
}

