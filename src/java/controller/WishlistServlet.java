package controller;

import model.CustomerDAO;
import model.Customer;
import model.Product;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.DBUtils;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Product> favoriteProducts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                // Truy vấn lấy danh sách sản phẩm yêu thích dựa trên Customer_ID
                String sql = "SELECT p.Product_ID, p.Name, p.Price, p.Product_Description, p.Product_img, " +
                             "(SELECT COUNT(*) FROM Favorite_Products fp2 WHERE fp2.Product_ID = p.Product_ID) as FavoriteCount " +
                             "FROM Product p " +
                             "INNER JOIN Favorite_Products fp ON p.Product_ID = fp.Product_ID " +
                             "WHERE fp.Customer_ID = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, customer.getCustomerId());
                rs = stm.executeQuery();

                while (rs.next()) {
                    Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Name"),
                        rs.getDouble("Price"),
                        rs.getString("Product_Description"),
                        rs.getInt("FavoriteCount"),
                        rs.getString("Product_img")
                    );
                    favoriteProducts.add(product);
                }
            }

            // Đặt danh sách sản phẩm yêu thích vào request
            request.setAttribute("favoriteProducts", favoriteProducts);

            // Chuyển hướng đến heart.jsp
            request.getRequestDispatcher("heart.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching favorite products.");
            request.getRequestDispatcher("heart.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stm != null) stm.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}