package controller;

import dao.FavoriteProductDAO;
import model.Customer;
import model.Product;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            FavoriteProductDAO dao = new FavoriteProductDAO();
            List<Product> favoriteProducts = dao.getFavoriteProductsWithDetailsByCustomer(customer.getCustomerId());

            request.setAttribute("favoriteProducts", favoriteProducts);
            request.getRequestDispatcher("heart.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching favorite products.");
            request.getRequestDispatcher("heart.jsp").forward(request, response);
        }
    }
}