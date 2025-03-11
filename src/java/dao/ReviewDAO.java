package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Review;
import utils.DBUtils;

public class ReviewDAO {
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, c.Username as CustomerName " +
                    "FROM Reviews r " +
                    "JOIN Customers c ON r.Customer_ID = c.Customer_ID " +
                    "WHERE r.Product_ID = ? " +
                    "ORDER BY r.Review_Date DESC";
        
        try {
            conn = new DBUtils().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("Review_ID"));
                review.setProductId(rs.getInt("Product_ID"));
                review.setCustomerId(rs.getInt("Customer_ID"));
                review.setCustomerName(rs.getString("CustomerName"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setReviewDate(rs.getTimestamp("Review_Date"));
                reviews.add(review);
            }
        } catch (Exception e) {
            System.out.println("Error getting reviews: " + e.getMessage());
        } finally {
            closeResources();
        }
        return reviews;
    }
    
    public boolean addReview(Review review) {
        String sql = "INSERT INTO Reviews (Product_ID, Customer_ID, Rating, Comment) VALUES (?, ?, ?, ?)";
        try {
            conn = new DBUtils().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, review.getProductId());
            ps.setInt(2, review.getCustomerId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error adding review: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }
    
    public boolean hasUserReviewed(int productId, int customerId) {
        String sql = "SELECT COUNT(*) FROM Reviews WHERE Product_ID = ? AND Customer_ID = ?";
        try {
            conn = new DBUtils().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.setInt(2, customerId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.out.println("Error checking user review: " + e.getMessage());
        } finally {
            closeResources();
        }
        return false;
    }
    
    public boolean updateReview(Review review) {
        String sql = "UPDATE Reviews SET Rating = ?, Comment = ?, Review_Date = GETDATE() WHERE Review_ID = ? AND Customer_ID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, review.getRating());
            ps.setString(2, review.getComment());
            ps.setInt(3, review.getReviewId());
            ps.setInt(4, review.getCustomerId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error updating review: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }
    
    public boolean deleteReview(int reviewId, int customerId) {
        String sql = "DELETE FROM Reviews WHERE Review_ID = ? AND Customer_ID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, reviewId);
            ps.setInt(2, customerId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error deleting review: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    public Review getReviewById(int reviewId) {
        String sql = "SELECT r.*, c.Username as CustomerName " +
                    "FROM Reviews r " +
                    "JOIN Customers c ON r.Customer_ID = c.Customer_ID " +
                    "WHERE r.Review_ID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, reviewId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("Review_ID"));
                review.setProductId(rs.getInt("Product_ID"));
                review.setCustomerId(rs.getInt("Customer_ID"));
                review.setCustomerName(rs.getString("CustomerName"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setReviewDate(rs.getTimestamp("Review_Date"));
                return review;
            }
        } catch (Exception e) {
            System.out.println("Error getting review: " + e.getMessage());
        } finally {
            closeResources();
        }
        return null;
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