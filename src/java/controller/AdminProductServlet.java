package controller;

import dao.ProductDAO;
import model.Product;
import com.google.gson.Gson;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/products/*"})
@MultipartConfig
public class AdminProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private Gson gson;
    private static final int PAGE_SIZE = 8;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && pathInfo.startsWith("/get/")) {
            try {
                int productId = Integer.parseInt(pathInfo.substring(5));
                Product product = productDAO.getProductById(productId);
                
                if (product != null) {
                    request.getSession().setAttribute("editProduct", product);
                    response.sendRedirect(request.getContextPath() + "/ProductServlet22");
                } else {
                    request.getSession().setAttribute("message", "Không tìm thấy sản phẩm");
                    request.getSession().setAttribute("messageType", "error");
                    response.sendRedirect(request.getContextPath() + "/ProductServlet22");
                }
            } catch (SQLException e) {
                request.getSession().setAttribute("message", "Lỗi khi lấy thông tin sản phẩm: " + e.getMessage());
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/ProductServlet22");
            }
            return;
        }

        // Xử lý tìm kiếm
        try {
            String search = request.getParameter("search");
            List<Product> products = productDAO.getAllProducts();
            if (search != null && !search.trim().isEmpty()) {
                products.removeIf(product -> 
                    !product.getName().toLowerCase().contains(search.toLowerCase()) &&
                    !product.getDescription().toLowerCase().contains(search.toLowerCase())
                );
            }
            request.setAttribute("products", products);
            RequestDispatcher rd = request.getRequestDispatcher("/products.jsp");
            rd.forward(request, response);
        } catch (SQLException e) {
            Logger.getLogger(AdminProductServlet.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tìm kiếm sản phẩm");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && pathInfo.startsWith("/delete/")) {
            try {
                int productId = Integer.parseInt(pathInfo.substring(8));
                if (productDAO.deleteProduct(productId)) {
                    request.getSession().setAttribute("message", "Xóa sản phẩm thành công!");
                    request.getSession().setAttribute("messageType", "success");
                } else {
                    request.getSession().setAttribute("message", "Không thể xóa sản phẩm!");
                    request.getSession().setAttribute("messageType", "error");
                }
                response.sendRedirect(request.getContextPath() + "/ProductServlet22");
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("message", "ID sản phẩm không hợp lệ!");
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/ProductServlet22");
            }
        } else {
            // Xử lý thêm/sửa sản phẩm
            request.setCharacterEncoding("UTF-8");
            
            int productId = request.getParameter("productId") != null && !request.getParameter("productId").isEmpty() ?
                           Integer.parseInt(request.getParameter("productId")) : 0;
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            String productImg = request.getParameter("productImg");

            if (productId > 0) {
                // Cập nhật sản phẩm
                Product product = new Product(productId, name, price, stock, description, categoryId, supplierId, productImg);
                if (productDAO.updateProduct(product)) {
                    request.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
                    request.getSession().setAttribute("messageType", "success");
                } else {
                    request.getSession().setAttribute("message", "Không thể cập nhật sản phẩm!");
                    request.getSession().setAttribute("messageType", "error");
                }
            } else {
                // Thêm sản phẩm mới
                Product product = new Product(0, name, price, stock, description, categoryId, supplierId, productImg);
                if (productDAO.addProduct(product)) {
                    request.getSession().setAttribute("message", "Thêm sản phẩm mới thành công!");
                    request.getSession().setAttribute("messageType", "success");
                } else {
                    request.getSession().setAttribute("message", "Thêm sản phẩm mới thất bại!");
                    request.getSession().setAttribute("messageType", "error");
                }
            }
            response.sendRedirect(request.getContextPath() + "/ProductServlet22");
        }
    }
} 