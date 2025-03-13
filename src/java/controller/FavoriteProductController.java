package controller;

import dao.FavoriteProductDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.FavoriteProduct;
import model.Customer;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "FavoriteProductController", urlPatterns = {"/favorite/*"})
public class FavoriteProductController extends HttpServlet {
    private FavoriteProductDAO favoriteProductDAO;
    private Gson gson;

    @Override
    public void init() {
        favoriteProductDAO = new FavoriteProductDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all favorites for the current user
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");
            
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            List<FavoriteProduct> favorites = favoriteProductDAO.getFavoritesByCustomerId(customer.getCustomerId());
            request.setAttribute("favorites", favorites);
            request.getRequestDispatcher("/views/favorite-products.jsp").forward(request, response);
        } else if (pathInfo.equals("/check")) {
            // Check if a product is in favorites
            handleCheckFavorite(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/add")) {
            handleAddFavorite(request, response);
        } else if (pathInfo.equals("/remove")) {
            handleRemoveFavorite(request, response);
        }
    }

    private void handleCheckFavorite(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        JsonObject jsonResponse = new JsonObject();
        if (customer != null) {
            try {
                boolean isFavorite = favoriteProductDAO.isFavorite(customer.getCustomerId(), productId);
                jsonResponse.addProperty("isFavorite", isFavorite);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(FavoriteProductController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            jsonResponse.addProperty("error", "User not logged in");
        }
        
        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());
    }

    private void handleAddFavorite(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        JsonObject jsonResponse = new JsonObject();
        if (customer != null) {
            try {
                boolean success = favoriteProductDAO.addToFavorites(customer.getCustomerId(), productId);
                jsonResponse.addProperty("success", success);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(FavoriteProductController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            jsonResponse.addProperty("error", "User not logged in");
        }
        
        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());
    }

    private void handleRemoveFavorite(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        JsonObject jsonResponse = new JsonObject();
        if (customer != null) {
            try {
                boolean success = favoriteProductDAO.removeFromFavorites(customer.getCustomerId(), productId);
                jsonResponse.addProperty("success", success);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(FavoriteProductController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            jsonResponse.addProperty("error", "User not logged in");
        }
        
        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());
    }
} 