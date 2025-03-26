package controller;

import dao.CustomerDAO;
import dao.ProductDAO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import model.Customer;

@WebServlet(name = "ProductServlet22", urlPatterns = {"/ProductServlet22"})
public class ProductServlet22 extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();
    private static final int PAGE_SIZE = 9; // Số sản phẩm trên mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            // Lấy thông tin admin từ CustomerDAO
            Customer admin = null;
            if (username != null) {
                admin = customerDAO.getCustomerByUsername(username);
            }
            ProductDAO productDAO = new ProductDAO();
            List<Product> products;
            
            // Lấy tham số trang từ request
            String pageParam = request.getParameter("page");
            int page = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
            if (page < 1) page = 1;
            
            // Lấy tham số tìm kiếm
            String search = request.getParameter("search");
            
            // Lấy danh sách sản phẩm
            if (search != null && !search.trim().isEmpty()) {
                products = ProductDAO.searchProductsByName(search);
            } else {
                products = productDAO.getAllProducts();
            }
            
            // Tính toán phân trang
            int totalProducts = products.size();
            int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);
            if (page > totalPages) page = totalPages;
            
            // Lấy danh sách sản phẩm cho trang hiện tại
            int offset = (page - 1) * PAGE_SIZE;
            int toIndex = Math.min(offset + PAGE_SIZE, totalProducts);
            products = products.subList(offset, toIndex);
            
            // Đặt các thuộc tính vào request
            request.setAttribute("productList", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("admin", admin);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/products.jsp");
            dispatcher.forward(request, response);
            
        } catch (SQLException e) {
            Logger.getLogger(ProductServlet22.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("error", "Lỗi khi lấy danh sách sản phẩm.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/products.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}