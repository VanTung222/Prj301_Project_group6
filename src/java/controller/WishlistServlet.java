package controller;

import dao.FavoriteProductDAO;
import model.Customer;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.FavoriteProduct;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            request.setAttribute("error", "Please login to view your wishlist.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            FavoriteProductDAO dao = new FavoriteProductDAO();
            List<FavoriteProduct> favoriteProducts = dao.getFavoritesByCustomerId(customer.getCustomerId());

            if (favoriteProducts.isEmpty()) {
                request.setAttribute("message", "Your wishlist is empty. Browse our products to add some items!");
            } else {
                request.setAttribute("favoriteProducts", favoriteProducts);
            }
            
            request.getRequestDispatcher("heart.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in WishlistServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching your wishlist. Please try again later.");
            request.getRequestDispatcher("heart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle any POST requests if needed in the future
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST method is not supported on this URL");
    }
}