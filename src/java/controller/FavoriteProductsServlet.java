package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import utils.DBUtils;


@WebServlet(name = "FavoriteProductsServlet", urlPatterns = {"/favoriteProducts"})
public class FavoriteProductsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> favoriteProducts = new ArrayList<>();
        boolean hasFavorites = false;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DBUtils.getConnection();
                    Statement stmt = conn.createStatement()) {

                String sql = "SELECT TOP 6 p.Product_ID, p.Name AS ProductName, p.Price, p.Product_Description, "
                        + "COUNT(fp.Favorite_ID) AS FavoriteCount "
                        + "FROM Product p "
                        + "LEFT JOIN Favorite_Products fp ON p.Product_ID = fp.Product_ID "
                        + "GROUP BY p.Product_ID, p.Name, p.Price, p.Product_Description "
                        + "HAVING COUNT(fp.Favorite_ID) > 0 "
                        + "ORDER BY FavoriteCount DESC";
                ResultSet rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("Product_ID"),
                            rs.getString("ProductName"),
                            rs.getDouble("Price"),
                            rs.getString("Product_Description"),
                            rs.getInt("FavoriteCount")
                    );
                    favoriteProducts.add(product);
                }

                hasFavorites = !favoriteProducts.isEmpty();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database connection error", e);
        }

        request.setAttribute("favoriteProducts", favoriteProducts);
        request.setAttribute("hasFavorites", hasFavorites);
        request.getRequestDispatcher("/favorite-products.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
