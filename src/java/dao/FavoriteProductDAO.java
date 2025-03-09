package dao;

import model.FavoriteProduct;
import model.Product;
import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FavoriteProductDAO {
    private static final String GET_FAVORITES_BY_CUSTOMER = "SELECT Favorite_ID, Customer_ID, Product_ID, Added_Date FROM Favorite_Products WHERE Customer_ID=?";
    private static final String ADD_FAVORITE = "INSERT INTO Favorite_Products (Customer_ID, Product_ID) VALUES (?, ?)";
    private static final String GET_FAVORITE_BY_ID = "SELECT Favorite_ID, Customer_ID, Product_ID, Added_Date FROM Favorite_Products WHERE Favorite_ID=?";
    private static final String DELETE_FAVORITE = "DELETE FROM Favorite_Products WHERE Favorite_ID=?";
    private static final String DELETE_FAVORITE_BY_CUSTOMER_AND_PRODUCT = "DELETE FROM Favorite_Products WHERE Customer_ID=? AND Product_ID=?";
    private static final String GET_FAVORITE_PRODUCTS_WITH_DETAILS = 
        "SELECT fp.Favorite_ID, fp.Customer_ID, fp.Product_ID, fp.Added_Date, " +
        "p.Name, p.Price, p.Stock, p.Product_Description, p.Product_Category_ID, p.Supplier_ID, p.Product_img " +
        "FROM Favorite_Products fp " +
        "INNER JOIN Product p ON fp.Product_ID = p.Product_ID " +
        "WHERE fp.Customer_ID=?";

    // Lấy danh sách sản phẩm yêu thích của khách hàng (chỉ thông tin từ Favorite_Products)
    public List<FavoriteProduct> getFavoritesByCustomer(int customerId) throws SQLException {
        List<FavoriteProduct> favorites = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_FAVORITES_BY_CUSTOMER);
                stm.setInt(1, customerId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    FavoriteProduct favorite = new FavoriteProduct(
                        rs.getInt("Favorite_ID"),
                        rs.getInt("Customer_ID"),
                        rs.getInt("Product_ID"),
                        rs.getDate("Added_Date")
                    );
                    favorites.add(favorite);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return favorites;
    }

    // Thêm sản phẩm yêu thích
    public boolean addFavorite(int customerId, int productId) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean added = false;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(ADD_FAVORITE);
                stm.setInt(1, customerId);
                stm.setInt(2, productId);
                added = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return added;
    }

    // Lấy sản phẩm yêu thích theo ID
    public FavoriteProduct getFavoriteProductById(int favoriteId) throws SQLException {
        FavoriteProduct favorite = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_FAVORITE_BY_ID);
                stm.setInt(1, favoriteId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    favorite = new FavoriteProduct(
                        rs.getInt("Favorite_ID"),
                        rs.getInt("Customer_ID"),
                        rs.getInt("Product_ID"),
                        rs.getDate("Added_Date")
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
        return favorite;
    }

    // Xóa sản phẩm yêu thích theo Favorite_ID
    public boolean deleteFavoriteProduct(int favoriteId) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean deleted = false;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(DELETE_FAVORITE);
                stm.setInt(1, favoriteId);
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

    // Xóa sản phẩm yêu thích theo Customer_ID và Product_ID
    public boolean deleteFavoriteByCustomerAndProduct(int customerId, int productId) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean deleted = false;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(DELETE_FAVORITE_BY_CUSTOMER_AND_PRODUCT);
                stm.setInt(1, customerId);
                stm.setInt(2, productId);
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

    // Kiểm tra xem sản phẩm đã được yêu thích bởi khách hàng hay chưa
    public boolean isProductFavorited(int customerId, int productId) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT Favorite_ID FROM Favorite_Products WHERE Customer_ID=? AND Product_ID=?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, customerId);
                stm.setInt(2, productId);
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

    // Lấy danh sách sản phẩm yêu thích với thông tin đầy đủ từ bảng Product theo Customer_ID
    public List<Product> getFavoriteProductsWithDetailsByCustomer(int customerId) throws SQLException {
        List<Product> favoriteProducts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_FAVORITE_PRODUCTS_WITH_DETAILS);
                stm.setInt(1, customerId);
                rs = stm.executeQuery();

                while (rs.next()) {
                    Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Name"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock"),
                        rs.getString("Product_Description"),
                        rs.getInt("Product_Category_ID"),
                        rs.getInt("Supplier_ID"),
                        rs.getString("Product_img")
                    );
                    favoriteProducts.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return favoriteProducts;
    }
}