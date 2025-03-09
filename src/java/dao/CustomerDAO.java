package dao;

import model.Customer;
import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CustomerDAO {
    // Các truy vấn SQL
    private static final String LOGIN = "SELECT Customer_ID, Username, Email FROM Customers WHERE Username=? AND Password=?";
    private static final String INSERT_CUSTOMER = "INSERT INTO Customers (Username, Email, Password, Registration_Date, Role) VALUES (?, ?, ?, ?, ?)";
    private static final String INSERT_GOOGLE_CUSTOMER = "INSERT INTO Customers (GoogleID, Email, Username, FirstName, LastName, ProfilePicture, Registration_Date, Role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String CHECK_EMAIL = "SELECT Customer_ID FROM Customers WHERE Email=?";
    private static final String GET_CUSTOMER_BY_ID = "SELECT Customer_ID, GoogleID, Email, Username, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role FROM Customers WHERE Customer_ID=?";
    private static final String GET_ALL_CUSTOMERS = "SELECT Customer_ID, GoogleID, Email, Username, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role FROM Customers";
    private static final String UPDATE_CUSTOMER = "UPDATE Customers SET GoogleID=?, Email=?, Username=?, FirstName=?, LastName=?, ProfilePicture=?, Address=?, Phone=?, Registration_Date=?, Role=? WHERE Customer_ID=?";
    private static final String DELETE_ACCOUNT = "UPDATE Customers SET Role=0 WHERE Customer_ID=?";
    private static final String EDIT_PASSWORD = "UPDATE Customers SET Password=? WHERE Customer_ID=?";

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
                stm.setString(1, username);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    customer = new Customer(
                        rs.getInt("Customer_ID"),
                        rs.getString("Username"),
                        rs.getString("Email"),
                        password
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
                stm.setDate(4, new java.sql.Date(new Date().getTime()));
                stm.setBoolean(5, true); // Role mặc định là user
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
                stm.setDate(7, new java.sql.Date(new Date().getTime()));
                stm.setBoolean(8, true); // Role mặc định là user
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
                        rs.getString("Username"),
                        rs.getString("Email"),
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

    // Lấy tất cả khách hàng
    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customerList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_ALL_CUSTOMERS);
                rs = stm.executeQuery();
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
                        rs.getBoolean("Role")
                    );
                    customerList.add(customer);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return customerList;
    }

    // Cập nhật thông tin khách hàng
    public boolean updateCustomer(Customer customer) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean updated = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(UPDATE_CUSTOMER);
                stm.setString(1, customer.getGoogleId());
                stm.setString(2, customer.getEmail());
                stm.setString(3, customer.getUsername());
                stm.setString(4, customer.getFirstName());
                stm.setString(5, customer.getLastName());
                stm.setString(6, customer.getProfilePicture());
                stm.setString(7, customer.getAddress());
                stm.setString(8, customer.getPhone());
                stm.setDate(9, new java.sql.Date(customer.getRegistrationDate().getTime()));
                stm.setBoolean(10, customer.isRole());
                stm.setInt(11, customer.getCustomerId());
                updated = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return updated;
    }

    // Xóa tài khoản (chuyển Role thành 0)
    public boolean deleteAccount(int customerId) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean deleted = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(DELETE_ACCOUNT);
                stm.setInt(1, customerId);
                deleted = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return deleted;
    }

    // Sửa mật khẩu
    public boolean editPassword(int customerId, String newPassword) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean updated = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(EDIT_PASSWORD);
                stm.setString(1, newPassword);
                stm.setInt(2, customerId);
                updated = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return updated;
    }

    // Kiểm tra username đã tồn tại chưa
    public boolean isUsernameExists(String username) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT Customer_ID FROM Customers WHERE Username=?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, username);
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

    // Lấy danh sách khách hàng theo Role
    public List<Customer> getCustomersByRole(boolean role) throws SQLException {
        List<Customer> customerList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT Customer_ID, GoogleID, Email, Username, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role FROM Customers WHERE Role=?";
                stm = conn.prepareStatement(sql);
                stm.setBoolean(1, role);
                rs = stm.executeQuery();
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
                        rs.getBoolean("Role")
                    );
                    customerList.add(customer);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return customerList;
    }
}