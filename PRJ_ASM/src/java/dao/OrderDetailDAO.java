/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author admin
 */
import model.OrderDetail;
import utils.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;

public class OrderDetailDAO {

    public void insertOrderDetail(OrderDetail orderDetail) throws ClassNotFoundException {
        String sql = "INSERT INTO OrderDetails (orderId, productId, quantity, unitPrice) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, orderDetail.getOrderId());
            stmt.setInt(2, orderDetail.getProductId());
            stmt.setInt(3, orderDetail.getQuantity());
            stmt.setDouble(4, orderDetail.getUnitPrice());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    orderDetail.setOrderDetailId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) throws ClassNotFoundException {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetails WHERE orderId = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    orderDetails.add(new OrderDetail(
                            rs.getInt("orderDetailId"),
                            rs.getInt("orderId"),
                            rs.getInt("productId"),
                            rs.getInt("quantity"),
                            rs.getDouble("unitPrice")
                            
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public void deleteOrderDetail(int orderDetailId) throws ClassNotFoundException {
        String sql = "DELETE FROM OrderDetails WHERE orderDetailId = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderDetailId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addOrderDetails(int orderId, List<CartItem> cartItems) throws ClassNotFoundException {
        String sql = "INSERT INTO OrderDetails (orderId, productId, quantity, unitPrice) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            conn.setAutoCommit(false); // Tắt auto-commit để tối ưu hiệu suất batch insert

            for (CartItem item : cartItems) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, item.getProduct().getProductId()); // Lấy productId từ Product
                stmt.setInt(3, item.getQuantity());
                stmt.setDouble(4, item.getProduct().getPrice()); // Lấy giá từ Product
                stmt.addBatch();
            }

            stmt.executeBatch(); // Thực thi tất cả câu lệnh INSERT một lần
            conn.commit(); // Commit giao dịch sau khi tất cả insert thành công
        } catch (SQLException e) {
            e.printStackTrace();
            try (Connection conn = DBUtils.getConnection()) {
                conn.rollback(); // Nếu có lỗi, rollback giao dịch
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try (Connection conn = DBUtils.getConnection()) {
                conn.setAutoCommit(true); // Bật lại auto-commit sau khi xong
            } catch (SQLException autoCommitEx) {
                autoCommitEx.printStackTrace();
            }
        }
    }

}
