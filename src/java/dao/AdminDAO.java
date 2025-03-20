package dao;

import java.sql.*;
import java.util.*;
import model.Admin;
import model.Customer;
import utils.DBUtils;

public class AdminDAO {
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    
    private static final String GET_ALL_CUSTOMERS = "SELECT Customer_ID, GoogleID, Email, Username, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role FROM Customers";

    
    public Admin checkLogin(String username, String password) {
        try {
            String query = "SELECT * FROM Admin WHERE Username = ? AND Password = ?";
            conn = new DBUtils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return new Admin(
                    rs.getInt("admin_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("full_name"),
                    rs.getString("role"),
                    rs.getString("last_login")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customerList = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GET_ALL_CUSTOMERS);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Customer customer = new Customer(
                        rs.getInt("Customer_ID"),
                        rs.getString("GoogleID"),
                        rs.getString("Username"),
                        rs.getString("Email"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Password"),
                        rs.getString("ProfilePicture"),
                        rs.getString("Address"),
                        rs.getString("Phone"),
                        rs.getDate("Registration_Date"),
                        rs.getInt("Role")
                    );
                    customerList.add(customer);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return customerList;
    }

    
    public boolean deleteCustomer(int customerId) {
        try {
            String query = "DELETE FROM Customers WHERE customer_id = ?";
            conn = new DBUtils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Map<String, Object> getStatistics() {
        Map<String, Object> stats = new HashMap<>();
        try {
            conn = new DBUtils().getConnection();
            
            // Get total customers
            String customerQuery = "SELECT COUNT(*) as total FROM Customers";
            ps = conn.prepareStatement(customerQuery);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.put("totalCustomers", rs.getInt("total"));
            }
            
            // Get total orders
            String orderQuery = "SELECT COUNT(*) as total, SUM(total_amount) as revenue FROM Orders";
            ps = conn.prepareStatement(orderQuery);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.put("totalOrders", rs.getInt("total"));
                stats.put("totalRevenue", rs.getDouble("revenue"));
            }
            
            // Get orders by status
            String statusQuery = "SELECT status, COUNT(*) as count FROM Orders GROUP BY status";
            ps = conn.prepareStatement(statusQuery);
            rs = ps.executeQuery();
            Map<String, Integer> ordersByStatus = new HashMap<>();
            while (rs.next()) {
                ordersByStatus.put(rs.getString("status"), rs.getInt("count"));
            }
            stats.put("ordersByStatus", ordersByStatus);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }
} 