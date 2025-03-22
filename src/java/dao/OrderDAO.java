package dao;

import model.Order;
import model.OrderDetail;
import utils.DBUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class OrderDAO {

    // Lấy tất cả đơn hàng
    public List<Order> getAllOrders() throws SQLException, ClassNotFoundException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.FirstName + ' ' + c.LastName AS CustomerName " +
                     "FROM Orders o " +
                     "JOIN Customers c ON o.Customer_ID = c.Customer_ID " +
                     "ORDER BY o.Order_Date DESC"; // Sắp xếp theo ngày giảm dần để lấy đơn hàng gần đây

        try (Connection conn = DBUtils.getConnection();
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

        try (Connection conn = DBUtils.getConnection();
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

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        }
    }

    // Lấy số lượng đơn hàng theo ngày
    public Map<String, Integer> getOrdersByDate() throws SQLException, ClassNotFoundException {
        Map<String, Integer> ordersByDate = new TreeMap<>(); // Sử dụng TreeMap để sắp xếp theo ngày
        String sql = "SELECT CAST(Order_Date AS DATE) AS OrderDay, COUNT(*) AS OrderCount " +
                     "FROM Orders " +
                     "GROUP BY CAST(Order_Date AS DATE) " +
                     "ORDER BY OrderDay";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String orderDay = rs.getString("OrderDay"); // Ngày dạng yyyy-MM-dd
                int orderCount = rs.getInt("OrderCount");
                ordersByDate.put(orderDay, orderCount);
            }
        }
        return ordersByDate;
    }

    // Lấy doanh thu theo tháng
    public Map<String, Double> getRevenueByMonth() throws SQLException, ClassNotFoundException {
        Map<String, Double> revenueByMonth = new TreeMap<>(); // Sử dụng TreeMap để sắp xếp theo tháng
        String sql = "SELECT MONTH(Order_Date) AS Month, YEAR(Order_Date) AS Year, SUM(Total_Amount) AS TotalRevenue " +
                     "FROM Orders " +
                     "GROUP BY MONTH(Order_Date), YEAR(Order_Date) " +
                     "ORDER BY Year, Month";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int month = rs.getInt("Month");
                int year = rs.getInt("Year");
                double totalRevenue = rs.getDouble("TotalRevenue");
                String key = year + "-" + String.format("%02d", month); // Định dạng: yyyy-MM
                revenueByMonth.put(key, totalRevenue);
            }
        }
        return revenueByMonth;
    }

    // Lấy doanh thu theo tuần trong tháng
    public Map<String, Double> getRevenueByWeekInMonth() throws SQLException, ClassNotFoundException {
        Map<String, Double> revenueByWeek = new TreeMap<>(); // Sử dụng TreeMap để tự động sắp xếp theo key
        String sql = "SELECT Order_Date, Total_Amount FROM Orders";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                java.sql.Timestamp orderDate = rs.getTimestamp("Order_Date");
                double totalAmount = rs.getDouble("Total_Amount");

                // Lấy năm và tháng từ Order_Date
                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.setTime(orderDate);
                int year = cal.get(java.util.Calendar.YEAR);
                int month = cal.get(java.util.Calendar.MONTH) + 1; // Tháng bắt đầu từ 0, nên +1
                int day = cal.get(java.util.Calendar.DAY_OF_MONTH);

                // Xác định tuần trong tháng
                int week;
                if (day <= 7) {
                    week = 1; // Tuần 1: ngày 1-7
                } else if (day <= 14) {
                    week = 2; // Tuần 2: ngày 8-14
                } else if (day <= 21) {
                    week = 3; // Tuần 3: ngày 15-21
                } else {
                    week = 4; // Tuần 4: ngày 22 đến cuối tháng
                }

                // Tạo key dạng YYYY-MM-W (ví dụ: 2025-03-1 cho Tuần 1 của tháng 3 năm 2025)
                String key = String.format("%d-%02d-%d", year, month, week);

                // Cộng dồn doanh thu cho tuần đó
                revenueByWeek.put(key, revenueByWeek.getOrDefault(key, 0.0) + totalAmount);
            }
        }
        return revenueByWeek;
    }
}