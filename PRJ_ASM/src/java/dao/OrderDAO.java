//package dao;
//
//import model.CartItem;
//import utils.DBUtils;
//import java.sql.*;
//import java.util.List;
//
//public class OrderDAO {
//
//    public int createOrder(int customerId, double totalAmount, String firstName, String lastName, String address,
//                           String city, String countryState, String postcode, String phone, String email,
//                           String orderNotes, String paymentMethod, List<CartItem> cartItems)
//            throws SQLException, ClassNotFoundException {
//        String orderSql = "INSERT INTO Orders (Customer_ID, Total_Amount, Shipping_FirstName, Shipping_LastName, " +
//                         "Shipping_Address, City, Country_State, Postcode, Phone, Email, Order_Notes, Payment_Method, Order_Date) " +
//                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
//        String detailSql = "INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Unit_Price) VALUES (?, ?, ?, ?)";
//
//        try (Connection conn = DBUtils.getConnection()) {
//            conn.setAutoCommit(false);
//
//            PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
//            orderStmt.setInt(1, customerId);
//            orderStmt.setDouble(2, totalAmount);
//            orderStmt.setString(3, firstName);
//            orderStmt.setString(4, lastName);
//            orderStmt.setString(5, address);
//            orderStmt.setString(6, city);
//            orderStmt.setString(7, countryState);
//            orderStmt.setString(8, postcode);
//            orderStmt.setString(9, phone);
//            orderStmt.setString(10, email);
//            orderStmt.setString(11, orderNotes);
//            orderStmt.setString(12, paymentMethod);
//            orderStmt.executeUpdate();
//
//            ResultSet generatedKeys = orderStmt.getGeneratedKeys();
//            int orderId = generatedKeys.next() ? generatedKeys.getInt(1) : -1;
//            if (orderId == -1) {
//                throw new SQLException("Failed to retrieve order ID");
//            }
//
//            PreparedStatement detailStmt = conn.prepareStatement(detailSql);
//            for (CartItem item : cartItems) {
//                detailStmt.setInt(1, orderId);
//                detailStmt.setInt(2, item.getProduct().getProductId());
//                detailStmt.setInt(3, item.getQuantity());
//                detailStmt.setDouble(4, item.getProduct().getPrice());
//                detailStmt.addBatch();
//            }
//            detailStmt.executeBatch();
//
//            conn.commit();
//            return orderId;
//        } catch (SQLException e) {
//            throw e;
//        }
//    }
//
//    public void getLastShippingInfo(int customerId, java.util.Map<String, String> shippingInfo) 
//            throws SQLException, ClassNotFoundException {
//        String sql = "SELECT TOP 1 Shipping_FirstName, Shipping_LastName, Shipping_Address, City, Country_State, " +
//                     "Postcode, Phone, Email FROM Orders WHERE Customer_ID = ? ORDER BY Order_Date DESC";
//
//        try (Connection conn = DBUtils.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setInt(1, customerId);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                shippingInfo.put("firstName", rs.getString("Shipping_FirstName"));
//                shippingInfo.put("lastName", rs.getString("Shipping_LastName"));
//                shippingInfo.put("address", rs.getString("Shipping_Address"));
//                shippingInfo.put("city", rs.getString("City"));
//                shippingInfo.put("countryState", rs.getString("Country_State"));
//                shippingInfo.put("postcode", rs.getString("Postcode"));
//                shippingInfo.put("phone", rs.getString("Phone"));
//                shippingInfo.put("email", rs.getString("Email"));
//            }
//        } catch (SQLException e) {
//            throw e;
//        }
//    }
//}








//code mới 

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import model.CartItem;
import utils.DBUtils;

public class OrderDAO {

public int createOrder(int customerId, double finalTotal, int shippingAddressId, String firstName, String lastName, 
                           String address, String city, String countryState, String postcode, String phone, String email, 
                           String orderNotes, String paymentMethod, List<CartItem> cartItems, String couponCode, double discountAmount) 
            throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String orderQuery = "INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount, Shipping_FirstName, " +
                               "Shipping_LastName, Shipping_Address, City, Country_State, Postcode, Phone, Email, " +
                               "Order_Notes, Coupon_Code, Discount_Amount, Payment_Method, Status, Shipping_Address_ID) " +
                               "VALUES (?, GETDATE(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', ?)";
            PreparedStatement orderStmt = conn.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, customerId);
            orderStmt.setDouble(2, finalTotal);
            orderStmt.setString(3, firstName);
            orderStmt.setString(4, lastName);
            orderStmt.setString(5, address);
            orderStmt.setString(6, city);
            orderStmt.setString(7, countryState);
            orderStmt.setString(8, postcode);
            orderStmt.setString(9, phone);
            orderStmt.setString(10, email);
            orderStmt.setString(11, orderNotes);
            orderStmt.setString(12, couponCode);
            orderStmt.setDouble(13, discountAmount);
            orderStmt.setString(14, paymentMethod);
            orderStmt.setInt(15, shippingAddressId);
            orderStmt.executeUpdate();

            ResultSet rs = orderStmt.getGeneratedKeys();
            if (!rs.next()) {
                throw new SQLException("Failed to create order.");
            }
            int orderId = rs.getInt(1);

            String detailQuery = "INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Unit_Price) VALUES (?, ?, ?, ?)";
            PreparedStatement detailStmt = conn.prepareStatement(detailQuery);
            for (CartItem item : cartItems) {
                detailStmt.setInt(1, orderId);
                detailStmt.setInt(2, item.getProduct().getProductId());
                detailStmt.setInt(3, item.getQuantity());
                detailStmt.setDouble(4, item.getProduct().getPrice());
                detailStmt.addBatch();
            }
            detailStmt.executeBatch();

            return orderId;
        }
    }

    public void getLastShippingInfo(int customerId, Map<String, String> shippingInfo) 
            throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT TOP 1 Shipping_FirstName, Shipping_LastName, Shipping_Address, City, " +
                          "Country_State, Postcode, Phone, Email " +
                          "FROM Orders WHERE Customer_ID = ? ORDER BY Order_Date DESC";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                shippingInfo.put("firstName", rs.getString("Shipping_FirstName"));
                shippingInfo.put("lastName", rs.getString("Shipping_LastName"));
                shippingInfo.put("address", rs.getString("Shipping_Address"));
                shippingInfo.put("city", rs.getString("City"));
                shippingInfo.put("countryState", rs.getString("Country_State"));
                shippingInfo.put("postcode", rs.getString("Postcode"));
                shippingInfo.put("phone", rs.getString("Phone"));
                shippingInfo.put("email", rs.getString("Email"));
            }
        }
    }
}

