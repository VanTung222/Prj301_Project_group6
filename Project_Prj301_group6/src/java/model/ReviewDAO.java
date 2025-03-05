/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class ReviewDAO {

    public static boolean addReview(Review review) {
        String sql = "INSERT INTO Review (Customer_ID, Product_ID, Rating, Comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getCustomerId());
            ps.setInt(2, review.getProductId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức để lấy tất cả review của một sản phẩm
    public static List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.Review_ID, r.Customer_ID, c.FirstName, c.LastName, r.Rating, r.Comment " +
                     "FROM Review r " +
                     "JOIN Customers c ON r.Customer_ID = c.Customer_ID " +
                     "WHERE r.Product_ID = ?";
        try (Connection conn = DBUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                reviews.add(new Review(
                    rs.getInt("Review_ID"),
                    rs.getInt("Customer_ID"),
                    productId,
                    rs.getInt("Rating"),
                    rs.getString("Comment")
                ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return reviews;
    }
}