package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            try {
                listProducts(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
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
            } catch (SQLException ex) {
                Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            try {
                listProducts(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            switch (action) {
                case "add":
                {
                    try {
                        addProduct(request, response);
                    } catch (ClassNotFoundException ex) {
                        Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (SQLException ex) {
                        Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                    break;

                case "update":
                    updateProduct(request, response);
                    break;
                default:
                    try {
                        listProducts(request, response);
                    } catch (SQLException ex) {
                        Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    break;
            }
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ClassNotFoundException, SQLException {
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int supplierId = Integer.parseInt(request.getParameter("supplierId"));
        String productImg = request.getParameter("productImg");

        Product newProduct = new Product(0, name, price, stock, description, categoryId, supplierId, productImg);
        productDAO.addProduct(newProduct);

        response.sendRedirect("products");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int supplierId = Integer.parseInt(request.getParameter("supplierId"));
        String productImg = request.getParameter("productImg");

        Product updatedProduct = new Product(id, name, price, stock, description, categoryId, supplierId, productImg);
        productDAO.updateProduct(updatedProduct);

        response.sendRedirect("products");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
}