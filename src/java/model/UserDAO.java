package model;

import emtyp.GoogleAccount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

 public class UserDAO {

    private static final String LOGIN = "SELECT id, username, email FROM users WHERE email=? AND password=?";
    private static final String INSERT_USER = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
    private static final String INSERT_USER_SIGNUP = "INSERT INTO userSignUp (GoogleID, Email, FullName, GivenName, FamilyName, ProfilePicture, VerifiedEmail) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String CHECK_EMAIL_USERS = "SELECT id FROM users WHERE email=?";
    private static final String DELETE = "DELETE FROM users WHERE id=?";
    private static final String UPDATE_CUSTOMER = "UPDATE users SET fullName=?, email=?, address=?, phone=? WHERE id=?";
    private static final String UPDATE = "UPDATE users SET password=?, username=?, email=? WHERE id=?";
    private static final String GET_BY_ID = "SELECT id, username, email FROM users WHERE id=?";
    private static final String GET_ALL = "SELECT id, username, email FROM users";
    private static final String sql = "SELECT password FROM users WHERE email=?";
    private static final String CHECK_EMAIL_USERSIGNUP = "SELECT UserID FROM userSignUp WHERE Email=?";
    private static final String GET_USER_BY_ID = "SELECT id, username, email FROM users WHERE id=?";
    private static final String GET_USER_SIGNUP_BY_GOOGLEID = "SELECT * FROM userSignUp WHERE GoogleID=?";

    public User checkLogin(String email, String password) throws SQLException {
        User user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(LOGIN);
                stm.setString(1, email);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
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
        return user;
    }

    public boolean insertUser(String username, String email, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean inserted = false;
        try {
            conn = DBUtils.getConnection();
            stm = conn.prepareStatement(INSERT_USER);
            stm.setString(1, username);
            stm.setString(2, email);
            stm.setString(3, password);
            inserted = stm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return inserted;
    }

    public boolean insertUserSignUp(String googleID, String email, String fullName, String givenName, 
                                  String familyName, String profilePicture, boolean verifiedEmail) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean inserted = false;
        try {
            conn = DBUtils.getConnection();
            stm = conn.prepareStatement(INSERT_USER_SIGNUP);
            stm.setString(1, googleID);
            stm.setString(2, email);
            stm.setString(3, fullName);
            stm.setString(4, givenName);
            stm.setString(5, familyName);
            stm.setString(6, profilePicture);
            stm.setBoolean(7, verifiedEmail);
            inserted = stm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return inserted;
    }

    // 3. Xóa người dùng theo ID
    public boolean deleteUser(String userID) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean deleted = false;
        try {
            conn = DBUtils.getConnection();
            stm = conn.prepareStatement(DELETE);
            stm.setString(1, userID);
            deleted = stm.executeUpdate() > 0;
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return deleted;
    }

    // 4. Cập nhật thông tin người dùng
    public boolean updateUser(User user) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean updated = false;
        try {
            conn = DBUtils.getConnection();
            stm = conn.prepareStatement(UPDATE);
            stm.setString(1, user.getPassword());
            stm.setString(2, user.getUsername());
            stm.setString(3, user.getEmail());
            stm.setInt(4, user.getId());
            //stm.setBoolean(5, user.is());
            //stm.setString(6, user.getUserID());

            updated = stm.executeUpdate() > 0;
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return updated;
    }

    // 5. Tìm kiếm người dùng theo tên
//    public List<User> searchUser(String keyword) throws SQLException, ClassNotFoundException {
//        List<User> list = new ArrayList<>();
//        Connection conn = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        //try {
//            conn = DBUtils.getConnection();
//            stm = conn.prepareStatement(SEARCH);
//            stm.setString(1, "%" + keyword + "%");
//            rs = stm.executeQuery();
//            while (rs.next()) {
//                list.add(new User(
//                    //rs.getString("userID"),
//                    //rs.getString("password"),
//                    //rs.getString("fullName"),
//                    //rs.getString("email"),
//                    //.getInt("roleID"),
//                    //rs.getBoolean("status")
//                //));
//            //}
//        //} finally {
////            if (rs != null) rs.close();
////            if (stm != null) stm.close();
////            if (conn != null) conn.close();
//        //}
//        return list;
//    }
    // 6. Lấy danh sách tất cả người dùng
    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
        List<User> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        //try {
        conn = DBUtils.getConnection();
        stm = conn.prepareStatement(GET_ALL);
        rs = stm.executeQuery();
        while (rs.next()) {
            //list.add(new User(
            //rs.getString("userID"),
            //rs.getString("password"),
            //rs.getString("fullName"),
            //rs.getString("email"),
            //rs.getInt("roleID"),
            //rs.getBoolean("status")
            //));
            //}
            //} finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    // 7. Lấy thông tin người dùng theo ID
    public User getUserByID(String userID) throws SQLException, ClassNotFoundException {
        User user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            stm = conn.prepareStatement(GET_BY_ID);
            stm.setString(1, userID);
            rs = stm.executeQuery();
            if (rs.next()) {
                //user = new User(
//                    rs.getString("userID"),
//                    rs.getString("password"),
//                    rs.getString("fullName"),
//                    rs.getString("email"),
//                    rs.getInt("roleID"),
//                    rs.getBoolean("status")
                //);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    // Phần sửa đổi thông tin khách hàng nè 
    public boolean checkUserExists(String googleId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT GoogleID FROM userSignUp WHERE GoogleID = ?";
        try (Connection con = DBUtils.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, googleId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean updateCustomerProfile(String userID, String fullName, String email, String address, String phone) throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection(); PreparedStatement stm = conn.prepareStatement(UPDATE_CUSTOMER)) {
            stm.setString(1, fullName);
            stm.setString(2, email);
            stm.setString(3, address);
            stm.setString(4, phone);
            stm.setString(5, userID);
            return stm.executeUpdate() > 0;
        }
    }

    public boolean changePassword(String email, String oldPassword, String newPassword) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean isUpdated = false;

        try {
            conn = DBUtils.getConnection();
            // Lấy mật khẩu hiện tại
            stm = conn.prepareStatement("SELECT password FROM users WHERE email=?");
            stm.setString(1, email);
            rs = stm.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");

                // Kiểm tra mật khẩu cũ có đúng không
                if (BCrypt.checkpw(oldPassword, hashedPassword)) {
                    // Cập nhật mật khẩu mới
                    String newHashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                    PreparedStatement updateStm = conn.prepareStatement("UPDATE users SET password=? WHERE email=?");
                    updateStm.setString(1, newHashedPassword);
                    updateStm.setString(2, email);
                    isUpdated = updateStm.executeUpdate() > 0;
                    updateStm.close();
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return isUpdated;
    }

    public boolean isEmailExistsInUsers(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            stm = conn.prepareStatement(CHECK_EMAIL_USERS);
            stm.setString(1, email);
            rs = stm.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public boolean isEmailExistsInUserSignUp(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            stm = conn.prepareStatement(CHECK_EMAIL_USERSIGNUP);
            stm.setString(1, email);
            rs = stm.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public User getUserById(int id) throws SQLException {
        User user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            stm = conn.prepareStatement(GET_USER_BY_ID);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    public User getUserByEmail(String email) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DBUtils.getConnection();
            stm = conn.prepareStatement("SELECT id, username, email, password FROM users WHERE email=?");
            stm.setString(1, email);
            rs = stm.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password") // Cần password để kiểm tra BCrypt
                );
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return user;
    }

}
