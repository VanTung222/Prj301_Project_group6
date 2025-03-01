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

    private static final String LOGIN = "SELECT userID FROM tblUsers WHERE userID=? AND password=?";
    private static final String SUCCESS = "UPDATE tblUsers SET roleID=? WHERE userID=?";
    private static final String INSERT = "INSERT INTO tblUsers(userID, password, fullName, email, roleID, status) VALUES(?, ?, ?, ?, ?, ?)";
    private static final String DELETE = "DELETE FROM tblUsers WHERE userID=?";
    private static final String UPDATE = "UPDATE tblUsers SET password=?, fullName=?, email=?, roleID=?, status=? WHERE userID=?";
    private static final String SEARCH = "SELECT * FROM tblUsers WHERE fullName LIKE ?";
    private static final String GET_ALL = "SELECT * FROM tblUsers";
    private static final String GET_BY_ID = "SELECT * FROM tblUsers WHERE userID=?";
    public boolean checkLogin(String userID, String password) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(LOGIN);
                stm.setString(1, userID);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    result = true;
                }
            }
            stm = conn.prepareStatement(SUCCESS);
            rs = stm.executeQuery();
            if (rs.next()) {
                System.out.println("");
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
        return result;
    }
    
     public boolean insertUser(GoogleAccount acc) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean inserted = false;
        try {
            Connection con = DBUtils.getConnection();
            stm = conn.prepareStatement(INSERT);
            stm.setString(1, acc.getId());
            stm.setString(2, acc.getEmail());
            stm.setString(3, acc.getFullName());
            stm.setString(4, acc.getGiven_name());
            stm.setString(5, acc.getFamily_name());
            stm.setString(6, acc.getPicture());
            stm.setBoolean(7, acc.isVerified_email());

            inserted = stm.executeUpdate() > 0;
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
            if (stm != null) stm.close();
            if (conn != null) conn.close();
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
            if (stm != null) stm.close();
            if (conn != null) conn.close();
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
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
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
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return user;
    }

}

    
