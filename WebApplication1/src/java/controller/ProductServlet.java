package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.ProductDAO;

@WebServlet(name = "ProductServlet", urlPatterns = {"/shop"})
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         List<Product> productList = ProductDAO.getAllProducts();
         request.setAttribute("productList", productList);
         RequestDispatcher dispatcher = request.getRequestDispatcher("shop.jsp");
             dispatcher.forward(request, response);

    }
}
