
package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Giả lập danh sách sản phẩm yêu thích
        List<Product> favoriteProducts = new ArrayList<>();
        favoriteProducts.add(new Product(1, "Dozen Cupcakes", 32.00, "A dozen delicious cupcakes", 10));
        favoriteProducts.add(new Product(2, "Cookies and Cream", 30.00, "Creamy cookies delight", 15));

        // Đặt danh sách vào request
        request.setAttribute("favoriteProducts", favoriteProducts);

        // Chuyển hướng đến heart.jsp
        request.getRequestDispatcher("heart.jsp").forward(request, response);
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
}
