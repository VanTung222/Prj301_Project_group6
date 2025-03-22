package dao;

import utils.DBUtils;
import java.sql.*;

public class PaymentDAO {

    public void addPayment(int orderId, int customerId, double amount, String method) 
            throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO Payment (Order_ID, Customer_ID, Amount, Method) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            stmt.setInt(2, customerId);
            stmt.setDouble(3, amount);
            stmt.setString(4, method);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw e;
        }
    }
    
    
    
    public int createPayment(int orderId, int customerId, double amount, String method)
            throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "INSERT INTO Payment (Order_ID, Customer_ID, Amount, Method, Payment_Date) " +
                          "VALUES (?, ?, ?, ?, GETDATE())";
            PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, orderId);
            stmt.setInt(2, customerId);
            stmt.setDouble(3, amount);
            stmt.setString(4, method);
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Trả về Payment_ID
            }
            throw new SQLException("Failed to create payment.");
        }
    }

    public double getTotalSpentByCustomer(int customerId) throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT SUM(Amount) as TotalSpent FROM Payment " +
                          "WHERE Customer_ID = ? AND Method != 'Pending'";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("TotalSpent");
            }
            return 0.0;
        }
    }

    public String getPaymentStatus(int paymentId) throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT Method FROM Payment WHERE Payment_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("Method");
            }
            return "Unknown";
        }
    }

    public void updatePaymentStatus(int paymentId, String status) throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "UPDATE Payment SET Method = ? WHERE Payment_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, status);
            stmt.setInt(2, paymentId);
            stmt.executeUpdate();
        }
    }
}