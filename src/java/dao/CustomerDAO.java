package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Customer;
import utils.DBUtils;

public class CustomerDAO {
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    // Các truy vấn SQL
    private static final String LOGIN = "SELECT Customer_ID, Username, Email FROM Customers WHERE Username=? AND Password=?";
    private static final String INSERT_CUSTOMER = "INSERT INTO Customers (Username, Email, Password, Registration_Date, Role) VALUES (?, ?, ?, ?, ?)";
    private static final String INSERT_GOOGLE_CUSTOMER = "INSERT INTO Customers (GoogleID, Email, Username, FirstName, LastName, ProfilePicture, Registration_Date, Role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String CHECK_EMAIL = "SELECT Customer_ID FROM Customers WHERE Email=?";
    private static final String GET_CUSTOMER_BY_ID = "SELECT Customer_ID, GoogleID, Email, Username, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role FROM Customers WHERE Customer_ID=?";
    private static final String GET_ALL_CUSTOMERS = "SELECT Customer_ID, GoogleID, Email, Username, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role FROM Customers";
    private static final String sql = "UPDATE Customers SET Email=?, FirstName=?, LastName=?, Address=?, Phone=? WHERE Customer_ID=?";
    private static final String DELETE_ACCOUNT = "UPDATE Customers SET Role=0 WHERE Customer_ID=?";
    private static final String EDIT_PASSWORD = "UPDATE Customers SET Password=? WHERE Customer_ID=?";

    // Kiểm tra đăng nhập bằng username và password
    public Customer checkLogin(String username, String password) throws SQLException {
        Customer customer = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(LOGIN);
                ps.setString(1, username);
                ps.setString(2, password);
                rs = ps.executeQuery();
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
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return customer;
    }

    // Thêm khách hàng thông thường
    public boolean insertCustomer(String username, String email, String password) throws SQLException {
        boolean inserted = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(INSERT_CUSTOMER);
                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setDate(4, new java.sql.Date(new Date().getTime()));
                ps.setBoolean(5, true); // Role mặc định là user
                inserted = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return inserted;
    }

    // Thêm khách hàng đăng nhập bằng Google
    public boolean insertGoogleCustomer(String googleId, String email, String username, String firstName, 
                                       String lastName, String profilePicture) throws SQLException {
        boolean inserted = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(INSERT_GOOGLE_CUSTOMER);
                ps.setString(1, googleId);
                ps.setString(2, email);
                ps.setString(3, username);
                ps.setString(4, firstName);
                ps.setString(5, lastName);
                ps.setString(6, profilePicture);
                ps.setDate(7, new java.sql.Date(new Date().getTime()));
                ps.setBoolean(8, true); // Role mặc định là user
                inserted = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return inserted;
    }

    // Kiểm tra email đã tồn tại chưa
    public boolean isEmailExists(String email) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECK_EMAIL);
                ps.setString(1, email);
                rs = ps.executeQuery();
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return false;
    }

    // Lấy thông tin khách hàng theo ID
    public Customer getCustomerById(int customerId) throws SQLException {
        Customer customer = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GET_CUSTOMER_BY_ID);
                ps.setInt(1, customerId);
                rs = ps.executeQuery();
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
                        rs.getInt("Role")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return customer;
    }

    // Lấy tất cả khách hàng
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

   
    // Xóa tài khoản (chuyển Role thành 0)
    public boolean deleteAccount(int customerId) throws SQLException {
        boolean deleted = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(DELETE_ACCOUNT);
                ps.setInt(1, customerId);
                deleted = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return deleted;
    }
    
    // Sửa mật khẩu
    public boolean editPassword(int customerId, String newPassword) throws SQLException {
        boolean updated = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(EDIT_PASSWORD);
                ps.setString(1, newPassword);
                ps.setInt(2, customerId);
                updated = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return updated;
    }

    // Kiểm tra username đã tồn tại chưa
    public boolean isUsernameExists(String username) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT Customer_ID FROM Customers WHERE Username=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                rs = ps.executeQuery();
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return false;
    }

    // Lấy danh sách khách hàng theo Role
    public List<Customer> getCustomersByRole(boolean role) throws SQLException {
        List<Customer> customerList = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT Customer_ID, GoogleID, Email, Username, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role FROM Customers WHERE Role=?";
                ps = conn.prepareStatement(sql);
                ps.setBoolean(1, role);
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

    public Customer getCustomerByUsername(String username) {
        String sql = "SELECT * FROM Customers WHERE Username = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return new Customer(
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
                    rs.getInt("Role")
                );
            }
        } catch (Exception e) {
            System.out.println("Error getting customer by username: " + e.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }
    public int getRoleByCustomerId(int customerId) throws SQLException {
    int role = 0; // Mặc định là 0 (khách hàng)
    String sql = "SELECT Role FROM Customers WHERE Customer_ID = ?";

    try (Connection conn = DBUtils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, customerId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                role = rs.getInt("Role");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return role;
}
    public boolean updateProfilePicture(int customerId, String profilePicture) throws SQLException {
        boolean updated = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE Customers SET ProfilePicture=? WHERE Customer_ID=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, profilePicture);
                ps.setInt(2, customerId);
                updated = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return updated;
    }
    
    public boolean updateCustomer(Customer customer) throws ClassNotFoundException {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBUtils.getConnection();
            String sql = "UPDATE Customers SET Email=?, FirstName=?, LastName=?, Address=?, Phone=? WHERE Customer_ID=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, customer.getEmail());
            ps.setString(2, customer.getFirstName());
            ps.setString(3, customer.getLastName());
            ps.setString(4, customer.getAddress());
            ps.setString(5, customer.getPhone());
            ps.setInt(6, customer.getCustomerId());
            
            int rowsAffected = ps.executeUpdate();
            success = rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return success;
    }

    // Giữ nguyên phương thức updateCustomerProfile của bạn
    public boolean updateCustomerProfile(
        int customerId,
        String username,
        String email,
        String firstName,
        String lastName,
        String phone,
        String address,
        String password
    ) throws SQLException {
        boolean updated = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql;
                if (password != null && !password.trim().isEmpty()) {
                    sql = "UPDATE Customers SET Username=?, Email=?, FirstName=?, LastName=?, Phone=?, Address=?, Password=? WHERE Customer_ID=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, email);
                    ps.setString(3, firstName);
                    ps.setString(4, lastName);
                    ps.setString(5, phone);
                    ps.setString(6, address);
                    ps.setString(7, password);
                    ps.setInt(8, customerId);
                } else {
                    sql = "UPDATE Customers SET Username=?, Email=?, FirstName=?, LastName=?, Phone=?, Address=? WHERE Customer_ID=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, email);
                    ps.setString(3, firstName);
                    ps.setString(4, lastName);
                    ps.setString(5, phone);
                    ps.setString(6, address);
                    ps.setInt(7, customerId);
                }
                updated = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return updated;
    }

    private void closeResources() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Lấy tổng số khách hàng
    public int getTotalCustomers() throws SQLException, ClassNotFoundException {
        Connection conn = DBUtils.getConnection();
        String sql = "SELECT COUNT(*) as count FROM Customers";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("count");
        }
        return 0;
    }
}