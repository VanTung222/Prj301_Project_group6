package controller;

import dao.ProductDAO;
import model.Product;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ProductServlet22", urlPatterns = {"/ProductServlet22"})
public class ProductServlet22 extends HttpServlet {
    private ProductDAO productDAO;
    private static final int RECORDS_PER_PAGE = 8;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String search = request.getParameter("search");
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            List<Product> products;
            int totalRecords;

            if (search != null && !search.trim().isEmpty()) {
                products = productDAO.searchProducts(search);
                totalRecords = products.size();
            } else {
                products = productDAO.getAllProducts();
                totalRecords = products.size();
            }

            int totalPages = (int) Math.ceil(totalRecords * 1.0 / RECORDS_PER_PAGE);
            
            int start = (page - 1) * RECORDS_PER_PAGE;
            int end = Math.min(start + RECORDS_PER_PAGE, totalRecords);
            
            List<Product> currentPageProducts = products.subList(start, end);

            request.setAttribute("products", currentPageProducts);
            request.setAttribute("search", search);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recordsPerPage", RECORDS_PER_PAGE);
            request.setAttribute("totalRecords", totalRecords);

            // Lấy sản phẩm đang được chỉnh sửa từ session (nếu có)
            HttpSession session = request.getSession();
            Product editProduct = (Product) session.getAttribute("editProduct");
            if (editProduct != null) {
                request.setAttribute("editProduct", editProduct);
                session.removeAttribute("editProduct");
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("products.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Đã xảy ra lỗi khi tải danh sách sản phẩm!");
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/ProductServlet22");
        }
    }
}