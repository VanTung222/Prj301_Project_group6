package controller;

import dao.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartItem;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("customerId") == null) {
            JSONObject error = new JSONObject();
            error.put("error", "Please login to view your cart");
            out.print(error.toString());
            return;
        }

        int customerId = (int) session.getAttribute("customerId");
        try {
            JSONObject cartData = getCartData(customerId);
            out.print(cartData.toString());
        } catch (SQLException | ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("customerId") == null) {
            JSONObject error = new JSONObject();
            error.put("error", "Please login to add items to cart");
            out.print(error.toString());
            return;
        }

        int customerId = (int) session.getAttribute("customerId");
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("id"));
        int quantity = 1; // Default quantity
        if (request.getParameter("quantity") != null) {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        }

        try {
            if ("add".equals(action)) {
                cartDAO.addToCartWithQuantity(customerId, productId, quantity);
            } else if ("remove".equals(action)) {
                cartDAO.removeFromCart(customerId, productId);
            } else if ("update".equals(action)) {
                cartDAO.updateCart(customerId, productId, quantity);
            }
            JSONObject cartData = getCartData(customerId);
            out.print(cartData.toString());
        } catch (SQLException | ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }

    private JSONObject getCartData(int customerId) throws SQLException, ClassNotFoundException {
        List<CartItem> cartItems = cartDAO.getCartItems(customerId);
        JSONObject cartData = new JSONObject();
        JSONArray cartArray = new JSONArray();
        double totalAmount = 0;
        int totalItems = 0;

        for (CartItem item : cartItems) {
            JSONObject itemJson = new JSONObject();
            itemJson.put("id", item.getProduct().getProductId());
            itemJson.put("name", item.getProduct().getName());
            itemJson.put("price", item.getProduct().getPrice());
            itemJson.put("image", item.getProduct().getProductImg());
            itemJson.put("quantity", item.getQuantity());
            cartArray.put(itemJson);

            totalAmount += item.getTotalPrice();
            totalItems += item.getQuantity();
        }

        cartData.put("cart", cartArray);
        cartData.put("total", String.format("%.2f", totalAmount));
        cartData.put("count", totalItems);
        return cartData;
    }

    @Override
    public String getServletInfo() {
        return "CartServlet handles shopping cart operations.";
    }
}