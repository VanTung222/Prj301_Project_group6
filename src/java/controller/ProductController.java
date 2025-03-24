package controller;

import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Product;
import com.google.gson.Gson;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "ProductController", urlPatterns = {"/ProductServlet22/*"})
public class ProductController extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads";
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        Logger.getLogger(ProductController.class.getName()).log(Level.INFO, "Received GET request to: " + pathInfo);

        if (pathInfo != null && pathInfo.startsWith("/get/")) {
            try {
                String idStr = pathInfo.substring(5);
                int productId = Integer.parseInt(idStr);
                Product product = productDAO.getProductById(productId);

                if (product != null) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    Gson gson = new Gson();
                    String json = gson.toJson(product);
                    response.getWriter().write(json);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            } catch (SQLException e) {
                Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, "Database error", e);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
            }
            return;
        }

        try {
            String search = request.getParameter("search");
            List<Product> products = (search != null && !search.trim().isEmpty()) 
                ? ProductDAO.searchProductsByName(search) 
                : productDAO.getAllProducts();
            request.setAttribute("productList", products);
            RequestDispatcher rd = request.getRequestDispatcher("/products.jsp");
            rd.forward(request, response);
        } catch (SQLException e) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, "Database error", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Logger.getLogger(ProductController.class.getName()).log(Level.INFO, "Received POST request to: " + request.getPathInfo());
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid URL pattern");
            return;
        }

        switch (pathInfo) {
            case "/add":
                handleAddProduct(request, response);
                break;
            case "/update":
                handleUpdateProduct(request, response);
                break;
            default:
                if (pathInfo.startsWith("/delete/")) {
                    handleDeleteProduct(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid URL pattern");
                }
        }
    }

    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));

            if (name == null || description == null) {
                throw new IllegalArgumentException("Missing required fields");
            }

            String productImg = uploadImage(request);
            Product newProduct = new Product(0, name, price, stock, description, categoryId, supplierId, productImg);

            if (productDAO.addProduct(newProduct)) {
                request.getSession().setAttribute("message", "Thêm sản phẩm thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Thêm sản phẩm thất bại!");
                request.getSession().setAttribute("messageType", "error");
            }
            response.sendRedirect(request.getContextPath() + "/ProductServlet22");
        } catch (Exception e) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, "Error adding product", e);
            request.getSession().setAttribute("message", "Lỗi khi thêm sản phẩm: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/ProductServlet22");
        }
    }

    private void handleUpdateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));

            String productImg = uploadImage(request);
            Product product = new Product(productId, name, price, stock, description, categoryId, supplierId, productImg);

            if (productDAO.updateProduct(product)) {
                request.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Cập nhật sản phẩm thất bại!");
                request.getSession().setAttribute("messageType", "error");
            }
            response.sendRedirect(request.getContextPath() + "/ProductServlet22");
        } catch (Exception e) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, "Error updating product", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating product");
        }
    }

    private void handleDeleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String pathInfo = request.getPathInfo();
            int productId = Integer.parseInt(pathInfo.substring(8));
            if (productDAO.deleteProduct(productId)) {
                request.getSession().setAttribute("message", "Xóa sản phẩm thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Không thể xóa sản phẩm!");
                request.getSession().setAttribute("messageType", "error");
            }
            response.sendRedirect(request.getContextPath() + "/ProductServlet22");
        } catch (Exception e) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, "Error deleting product", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID or error deleting");
        }
    }

    private String uploadImage(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("productImg");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + extractFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            filePart.write(uploadPath + File.separator + fileName);
            return UPLOAD_DIRECTORY + "/" + fileName;
        }
        return null;
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}