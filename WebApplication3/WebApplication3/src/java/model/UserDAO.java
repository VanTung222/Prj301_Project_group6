package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DBUtils;

public class UserDAO {
    private static final String LOGIN = "SELECT id, username, email FROM users WHERE email=? AND password=?";
    private static final String INSERT_USER = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
    private static final String INSERT_USER_SIGNUP = "INSERT INTO userSignUp (GoogleID, Email, FullName, GivenName, FamilyName, ProfilePicture, VerifiedEmail) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String CHECK_EMAIL_USERS = "SELECT id FROM users WHERE email=?";
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
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
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
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
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
                    ""
                );
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
}