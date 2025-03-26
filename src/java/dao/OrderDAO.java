package dao;

import model.Order;
import model.OrderDetail;
import utils.DBUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import model.CartItem;

public class OrderDAO {

    public Order getRecentOrderByCustomerId(int customerId) throws SQLException, ClassNotFoundException {
        Order order = null;
        String sql = "SELECT TOP 1 o.Order_ID, o.Order_Date, o.Status "
                + "FROM Orders o "
                + "WHERE o.Customer_ID = ? "
                + "ORDER BY o.Order_Date DESC";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setOrderId(rs.getInt("Order_ID"));
                    order.setOrderDate(rs.getTimestamp("Order_Date"));
                    order.setStatus(rs.getString("Status"));

                    // Lấy chi tiết đơn hàng
                    List<OrderDetail> orderDetails = getOrderDetails(order.getOrderId());
                    order.setOrderDetails(orderDetails != null ? orderDetails : new ArrayList<>());
                }
            }
        }
        return order;
    }
  
    
    public List<Order> getAllOrdersByCustomerId(int customerId) throws SQLException, ClassNotFoundException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.Order_ID, o.Order_Date, o.Status "
                + "FROM Orders o "
                + "WHERE o.Customer_ID = ? "
                + "ORDER BY o.Order_Date DESC";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("Order_ID"));
                    order.setOrderDate(rs.getTimestamp("Order_Date"));
                    order.setStatus(rs.getString("Status"));

                    // Lấy chi tiết đơn hàng
                    List<OrderDetail> orderDetails = getOrderDetails(order.getOrderId());
                    order.setOrderDetails(orderDetails != null ? orderDetails : new ArrayList<>());

                    orders.add(order);
                }
            }
        }
        return orders;
    }

    

    // Lấy tất cả đơn hàng
    public List<Order> getAllOrders() throws SQLException, ClassNotFoundException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.FirstName + ' ' + c.LastName AS CustomerName "
                + "FROM Orders o "
                + "JOIN Customers c ON o.Customer_ID = c.Customer_ID "
                + "ORDER BY o.Order_Date DESC";

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
                List<OrderDetail> orderDetails = getOrderDetails(order.getOrderId());
                order.setOrderDetails(orderDetails != null ? orderDetails : new ArrayList<>()); // Đảm bảo không trả về null

                orders.add(order);
            }
        }
        return orders;
    }

    public int createOrder(int customerId, double finalTotal, int shippingAddressId, String firstName, String lastName,
            String address, String city, String countryState, String postcode, String phone, String email,
            String orderNotes, String paymentMethod, List<CartItem> cartItems, String couponCode, double discountAmount)
            throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String orderQuery = "INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount, Shipping_FirstName, "
                    + "Shipping_LastName, Shipping_Address, City, Country_State, Postcode, Phone, Email, "
                    + "Order_Notes, Coupon_Code, Discount_Amount, Payment_Method, Status, Shipping_Address_ID) "
                    + "VALUES (?, GETDATE(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', ?)";
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
        Map<String, Integer> ordersByDate = new TreeMap<>();
        String sql = "SELECT CAST(Order_Date AS DATE) AS OrderDay, COUNT(*) AS OrderCount "
                + "FROM Orders "
                + "GROUP BY CAST(Order_Date AS DATE) "
                + "ORDER BY OrderDay";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String orderDay = rs.getString("OrderDay");
                int orderCount = rs.getInt("OrderCount");
                ordersByDate.put(orderDay, orderCount);
            }
        }
        return ordersByDate;
    }

    // Lấy doanh thu theo tháng
    public Map<String, Double> getRevenueByMonth() throws SQLException, ClassNotFoundException {
        Map<String, Double> revenueByMonth = new TreeMap<>();
        String sql = "SELECT MONTH(Order_Date) AS Month, YEAR(Order_Date) AS Year, SUM(Total_Amount) AS TotalRevenue "
                + "FROM Orders "
                + "GROUP BY MONTH(Order_Date), YEAR(Order_Date) "
                + "ORDER BY Year, Month";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int month = rs.getInt("Month");
                int year = rs.getInt("Year");
                double totalRevenue = rs.getDouble("TotalRevenue");
                String key = year + "-" + String.format("%02d", month);
                revenueByMonth.put(key, totalRevenue);
            }
        }
        return revenueByMonth;
    }

    // Lấy doanh thu theo tuần trong tháng
    public Map<String, Double> getRevenueByWeekInMonth() throws SQLException, ClassNotFoundException {
        Map<String, Double> revenueByWeek = new TreeMap<>();
        String sql = "SELECT Order_Date, Total_Amount FROM Orders";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                java.sql.Timestamp orderDate = rs.getTimestamp("Order_Date");
                double totalAmount = rs.getDouble("Total_Amount");

                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.setTime(orderDate);
                int year = cal.get(java.util.Calendar.YEAR);
                int month = cal.get(java.util.Calendar.MONTH) + 1;
                int day = cal.get(java.util.Calendar.DAY_OF_MONTH);

                int week;
                if (day <= 7) {
                    week = 1;
                } else if (day <= 14) {
                    week = 2;
                } else if (day <= 21) {
                    week = 3;
                } else {
                    week = 4;
                }

                String key = String.format("%d-%02d-%d", year, month, week);
                revenueByWeek.put(key, revenueByWeek.getOrDefault(key, 0.0) + totalAmount);
            }
        }
        return revenueByWeek;
    }

    public void getLastShippingInfo(int customerId, Map<String, String> shippingInfo)
            throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT TOP 1 Shipping_FirstName, Shipping_LastName, Shipping_Address, City, "
                    + "Country_State, Postcode, Phone, Email "
                    + "FROM Orders WHERE Customer_ID = ? ORDER BY Order_Date DESC";
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
