package controller;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import dao.CustomerDAO;
import dao.ProductDAO;
import model.Product;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import model.Customer;

@WebServlet(name = "ProductController", urlPatterns = {"/products"})
@MultipartConfig(
    fileSizeThreshold = 2 * 1024 * 1024, // 2MB
    maxFileSize = 10 * 1024 * 1024,     // 10MB
    maxRequestSize = 50 * 1024 * 1024   // 50MB
)
public class ProductController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ProductController.class.getName());
    private static final String UPLOAD_DIR = "uploads";
    private ProductDAO productDAO;
    
    
            
            
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        CustomerDAO customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        String action = request.getParameter("action");
        try {
            if (action == null) {
                listProducts(request, response);
            } else {
                switch (action) {
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteProduct(request, response);
                        break;
                    default:
                        listProducts(request, response);
                        break;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Database error", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null) {
                listProducts(request, response);
            } else {
                switch (action) {
                    case "add":
                        addProduct(request, response);
                        break;
                    case "update":
                        updateProduct(request, response);
                        break;
                    default:
                        listProducts(request, response);
                        break;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Database error", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, SQLException {
        Product product = getProductFromRequest(request, true);
        productDAO.addProduct(product);
        response.sendRedirect("products");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, SQLException {
        Product product = getProductFromRequest(request, false);
        productDAO.updateProduct(product);
        response.sendRedirect("products");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("productId"));
        productDAO.deleteProduct(id);
        response.sendRedirect("products");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("productId"));
        Product product = productDAO.getProductById(id);
        if (product != null) {
            request.setAttribute("product", product);
            listProducts(request, response);
        } else {
            response.sendRedirect("products");
        }
    }

    private Product getProductFromRequest(HttpServletRequest request, boolean isAdd)
            throws IOException, ServletException {
        int id = request.getParameter("productId") != null && !request.getParameter("productId").isEmpty()
                ? Integer.parseInt(request.getParameter("productId")) : 0;
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int supplierId = Integer.parseInt(request.getParameter("supplierId"));

        String imagePath = uploadFile(request);
        if (imagePath.isEmpty() && !isAdd) {
            // Nếu không upload ảnh mới khi cập nhật, giữ nguyên ảnh cũ
            imagePath = request.getParameter("currentImg") != null ? request.getParameter("currentImg") : "";
        }

        return new Product(id, name, price, stock, description, categoryId, supplierId, imagePath);
    }

    private String uploadFile(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("productImgFile"); // Tên trường khớp với JSP
        if (filePart == null || filePart.getSize() == 0) {
            return ""; // Không có file upload
        }

        // Lấy tên file gốc và thêm timestamp để tránh trùng lặp
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = System.currentTimeMillis() + fileExtension;

        // Đường dẫn lưu file
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Tạo thư mục nếu chưa tồn tại
        }

        // Lưu file vào thư mục uploads
        String filePath = uploadPath + File.separator + uniqueFileName;
        filePart.write(filePath);

        // Trả về đường dẫn tương đối để lưu vào DB
        return UPLOAD_DIR + "/" + uniqueFileName;
    }
}