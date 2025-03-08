package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import model.Customer;
import utils.DBUtils;

public class CustomerDAO {
    // Sửa truy vấn LOGIN để dùng Username thay vì Email
    private static final String LOGIN = "SELECT Customer_ID, Username, Email FROM Customers WHERE Username=? AND Password=?";
    private static final String INSERT_CUSTOMER = "INSERT INTO Customers (Username, Email, Password, Registration_Date, Role) VALUES (?, ?, ?, ?, ?)";
    private static final String INSERT_GOOGLE_CUSTOMER = "INSERT INTO Customers (GoogleID, Email, Username, FirstName, LastName, ProfilePicture, Registration_Date, Role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String CHECK_EMAIL = "SELECT Customer_ID FROM Customers WHERE Email=?";
    private static final String GET_CUSTOMER_BY_ID = "SELECT Customer_ID, GoogleID, Email, Username, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role FROM Customers WHERE Customer_ID=?";

    // Kiểm tra đăng nhập bằng username và password
    public Customer checkLogin(String username, String password) throws SQLException {
        Customer customer = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(LOGIN);
                stm.setString(1, username); // Sử dụng username thay vì email
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    customer = new Customer(
                        rs.getInt("Customer_ID"),
                        rs.getString("Username"),
                        rs.getString("Email"),
                        password // Nên mã hóa password trong thực tế
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return customer;
    }

    // Thêm khách hàng thông thường
    public boolean insertCustomer(String username, String email, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean inserted = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(INSERT_CUSTOMER);
                stm.setString(1, username);
                stm.setString(2, email);
                stm.setString(3, password);
                stm.setDate(4, new java.sql.Date(new Date().getTime())); // Ngày hiện tại
                stm.setBoolean(5, true); // Role mặc định là 1 (user)
                inserted = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return inserted;
    }

    // Thêm khách hàng đăng nhập bằng Google
    public boolean insertGoogleCustomer(String googleId, String email, String username, String firstName, 
                                       String lastName, String profilePicture) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean inserted = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(INSERT_GOOGLE_CUSTOMER);
                stm.setString(1, googleId);
                stm.setString(2, email);
                stm.setString(3, username);
                stm.setString(4, firstName);
                stm.setString(5, lastName);
                stm.setString(6, profilePicture);
                stm.setDate(7, new java.sql.Date(new Date().getTime())); // Ngày hiện tại
                stm.setBoolean(8, true); // Role mặc định là 1 (user)
                inserted = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return inserted;
    }

    // Kiểm tra email đã tồn tại chưa
    public boolean isEmailExists(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(CHECK_EMAIL);
                stm.setString(1, email);
                rs = stm.executeQuery();
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return false;
    }

    // Lấy thông tin khách hàng theo ID
    public Customer getCustomerById(int customerId) throws SQLException {
        Customer customer = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_CUSTOMER_BY_ID);
                stm.setInt(1, customerId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    customer = new Customer(
                        rs.getInt("Customer_ID"),
                        rs.getString("GoogleID"),
                        rs.getString("Email"),
                        rs.getString("Username"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Password"),
                        rs.getString("ProfilePicture"),
                        rs.getString("Address"),
                        rs.getString("Phone"),
                        rs.getDate("Registration_Date"),
                        rs.getBoolean("Role")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return customer;
    }
}