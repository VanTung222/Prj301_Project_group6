package dao;

import model.Order;
import model.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private String jdbcURL = "jdbc:sqlserver://TUNG\\VANTUNG:1433;databaseName=cakeManagement;encrypt=false;trustServerCertificate=true";
    private String jdbcUsername = "sa";
    private String jdbcPassword = "Tung@123456789";

    // Kết nối cơ sở dữ liệu
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Lấy tất cả đơn hàng
    public List<Order> getAllOrders() throws SQLException, ClassNotFoundException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("Order_ID"));
                order.setCustomerId(rs.getInt("Customer_ID"));
                order.setEmployeeId(rs.getInt("Employee_ID") == 0 ? null : rs.getInt("Employee_ID"));
                order.setOrderDate(rs.getTimestamp("Order_Date"));
                order.setTotalAmount(rs.getDouble("Total_Amount"));
                order.setShippingFirstName(rs.getString("Shipping_FirstName"));
                order.setShippingLastName(rs.getString("Shipping_LastName"));
                order.setShippingAddress(rs.getString("Shipping_Address"));
                order.setCity(rs.getString("City"));
                order.setCountryState(rs.getString("Country_State"));
                order.setPostcode(rs.getString("Postcode"));
                order.setPhone(rs.getString("Phone"));
                order.setEmail(rs.getString("Email"));
                order.setOrderNotes(rs.getString("Order_Notes"));
                order.setCouponCode(rs.getString("Coupon_Code"));
                order.setDiscountAmount(rs.getDouble("Discount_Amount"));
                order.setPaymentMethod(rs.getString("Payment_Method"));
                order.setShipperId(rs.getInt("Shipper_ID") == 0 ? null : rs.getInt("Shipper_ID"));
                order.setEstimatedDeliveryDate(rs.getDate("Estimated_Delivery_Date"));
                order.setStatus(rs.getString("Status"));

                // Lấy chi tiết đơn hàng
                order.setOrderDetails(getOrderDetails(order.getOrderId()));

                orders.add(order);
            }
        }
        return orders;
    }

    // Lấy chi tiết đơn hàng theo Order_ID
    public List<OrderDetail> getOrderDetails(int orderId) throws SQLException, ClassNotFoundException {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM Order_Details WHERE Order_ID = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderDetailId(rs.getInt("Order_Detail_ID"));
                    detail.setOrderId(rs.getInt("Order_ID"));
                    detail.setProductId(rs.getInt("Product_ID"));
                    detail.setQuantity(rs.getInt("Quantity"));
                    detail.setUnitPrice(rs.getDouble("Unit_Price"));
                    detail.setSubtotal(rs.getDouble("Subtotal"));
                    orderDetails.add(detail);
                }
            }
        }
        return orderDetails;
    }

    // Cập nhật trạng thái đơn hàng
    public void updateOrderStatus(int orderId, String status) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE Orders SET Status = ? WHERE Order_ID = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        }
    }
}