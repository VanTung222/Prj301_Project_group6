package controller;

import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ProductServlet22", urlPatterns = {"/ProductServlet22"})
public class ProductServlet22 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        try {
            List<Product> productList = productDAO.getAllProducts();
            request.setAttribute("productList", productList);
        } catch (SQLException e) {
            e.printStackTrace(); // Hiển thị lỗi trong console
            request.setAttribute("error", "Lỗi khi lấy danh sách sản phẩm.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("products.jsp");
        dispatcher.forward(request, response);
    }
}