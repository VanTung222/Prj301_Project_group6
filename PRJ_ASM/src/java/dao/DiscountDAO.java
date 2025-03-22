package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import model.DiscountCode;
import utils.DBUtils;

public class DiscountDAO {
    public DiscountCode getDiscountCode(String code, int customerId) throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT * FROM Discount_Code WHERE Code = ? AND Customer_ID = ? AND Is_Used = 0";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, code);
            stmt.setInt(2, customerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                DiscountCode discount = new DiscountCode();
                discount.setDiscountId(rs.getInt("Discount_ID"));
                discount.setCustomerId(rs.getInt("Customer_ID"));
                discount.setCode(rs.getString("Code"));
                discount.setDiscountPercentage(rs.getDouble("Discount_Percentage"));
                discount.setUsed(rs.getBoolean("Is_Used"));
                discount.setCreatedDate(rs.getTimestamp("Created_Date"));
                discount.setExpiryDate(rs.getTimestamp("Expiry_Date"));
                return discount;
            }
            return null;
        }
    }

    public void markDiscountAsUsed(String code) throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "UPDATE Discount_Code SET Is_Used = 1 WHERE Code = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, code);
            stmt.executeUpdate();
        }
    }

    public void createDiscountCode(int customerId, String code, double discountPercentage, Date expiryDate)
            throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "INSERT INTO Discount_Code (Customer_ID, Code, Discount_Percentage, Is_Used, Created_Date, Expiry_Date) " +
                          "VALUES (?, ?, ?, 0, GETDATE(), ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, customerId);
            stmt.setString(2, code);
            stmt.setDouble(3, discountPercentage);
            stmt.setTimestamp(4, new Timestamp(expiryDate.getTime()));
            stmt.executeUpdate();
        }
    }
}