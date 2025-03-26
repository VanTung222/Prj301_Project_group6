//package controller;
//
//import dao.CartDAO;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.SQLException;
//import java.util.List;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.CartItem;
//import org.json.JSONArray;
//import org.json.JSONObject;
//
//@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
//public class CartServlet extends HttpServlet {
//
//    private CartDAO cartDAO = new CartDAO();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("application/json");
//        PrintWriter out = response.getWriter();
//        HttpSession session = request.getSession(false);
//
//        if (session == null || session.getAttribute("customerId") == null) {
//            JSONObject error = new JSONObject();
//            error.put("error", "Please login to view your cart");
//            out.print(error.toString());
//            return;
//        }
//
//        int customerId = (int) session.getAttribute("customerId");
//        try {
//            JSONObject cartData = getCartData(customerId);
//            out.print(cartData.toString());
//        } catch (SQLException | ClassNotFoundException e) {
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("application/json");
//        PrintWriter out = response.getWriter();
//        HttpSession session = request.getSession(false);
//
//        if (session == null || session.getAttribute("customerId") == null) {
//            JSONObject error = new JSONObject();
//            error.put("error", "Please login to add items to cart");
//            out.print(error.toString());
//            return;
//        }
//
//        int customerId = (int) session.getAttribute("customerId");
//        String action = request.getParameter("action");
//        int productId = Integer.parseInt(request.getParameter("id"));
//        int quantity = 1; // Default quantity
//        if (request.getParameter("quantity") != null) {
//            quantity = Integer.parseInt(request.getParameter("quantity"));
//        }
//
//        try {
//            if ("add".equals(action)) {
//                cartDAO.addToCartWithQuantity(customerId, productId, quantity);
//            } else if ("remove".equals(action)) {
//                cartDAO.removeFromCart(customerId, productId);
//            } else if ("update".equals(action)) {
//                cartDAO.updateCart(customerId, productId, quantity);
//            } else {
//                throw new IllegalArgumentException("Invalid action: " + action);
//            }
//            JSONObject cartData = getCartData(customerId);
//            out.print(cartData.toString());
//        } catch (SQLException | ClassNotFoundException e) {
//            JSONObject error = new JSONObject();
//            error.put("error", e.getMessage());
//            out.print(error.toString());
//        } catch (IllegalArgumentException e) {
//            JSONObject error = new JSONObject();
//            error.put("error", e.getMessage());
//            out.print(error.toString());
//        } catch (Exception e) {
//            JSONObject error = new JSONObject();
//            error.put("error", "An unexpected error occurred");
//            out.print(error.toString());
//        }
//    }
//
//    private JSONObject getCartData(int customerId) throws SQLException, ClassNotFoundException {
//        List<CartItem> cartItems = cartDAO.getCartItems(customerId);
//        JSONObject cartData = new JSONObject();
//        JSONArray cartArray = new JSONArray();
//        double totalAmount = 0;
//        int totalItems = 0;
//
//        for (CartItem item : cartItems) {
//            JSONObject itemJson = new JSONObject();
//            itemJson.put("id", item.getProduct().getProductId());
//            itemJson.put("name", item.getProduct().getName());
//            itemJson.put("price", item.getProduct().getPrice());
//            itemJson.put("image", item.getProduct().getProductImg());
//            itemJson.put("quantity", item.getQuantity());
//            cartArray.put(itemJson);
//
//            totalAmount += item.getTotalPrice();
//            totalItems += item.getQuantity();
//        }
//
//        cartData.put("cart", cartArray);
//        cartData.put("total", String.format("%.2f", totalAmount));
//        cartData.put("count", totalItems);
//        return cartData;
//    }
//
//    @Override
//    public String getServletInfo() {
//        return "CartServlet handles shopping cart operations.";
//    }
//}





package controller;

import dao.CartDAO;
import dao.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import model.CartItem;
import model.DiscountCode;
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
        System.out.println("Customer ID in CartServlet (GET): " + customerId); // Debug

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
        System.out.println("Customer ID in CartServlet: " + customerId); // Debug

        String action = request.getParameter("action");

        try {
            if ("applyDiscount".equals(action)) {
                String discountCode = request.getParameter("discountCode");
                DiscountDAO discountDAO = new DiscountDAO();
                DiscountCode discount = discountDAO.getDiscountCode(discountCode, customerId);

                JSONObject responseData = new JSONObject();
                if (discount != null && !discount.isUsed() && discount.getExpiryDate().after(new java.util.Date())) {
                    double discountPercentage = discount.getDiscountPercentage();
                    session.setAttribute("appliedDiscount", discountPercentage);
                    session.setAttribute("discountCode", discountCode);

                    List<CartItem> cartItems = cartDAO.getCartItems(customerId);
                    double subtotal = cartItems.stream()
                            .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                            .sum();
                    double discountAmount = subtotal * (discountPercentage / 100);
                    double finalTotal = subtotal - discountAmount;

                    responseData.put("discountPercentage", discountPercentage);
                    responseData.put("discountAmount", String.format("%.2f", discountAmount));
                    responseData.put("subtotal", String.format("%.2f", subtotal));
                    responseData.put("finalTotal", String.format("%.2f", finalTotal));
                } else {
                    responseData.put("error", "Invalid or expired discount code.");
                }
                out.print(responseData.toString());
                return;
            }

            int productId = Integer.parseInt(request.getParameter("id"));
            System.out.println("Product ID: " + productId + ", Action: " + action); // Debug

            int quantity = 1;
            if (request.getParameter("quantity") != null) {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            }
            System.out.println("Quantity: " + quantity); // Debug

            if ("add".equals(action)) {
                cartDAO.addToCartWithQuantity(customerId, productId, quantity);
            } else if ("remove".equals(action)) {
                cartDAO.removeFromCart(customerId, productId);
            } else if ("update".equals(action)) {
                cartDAO.updateCart(customerId, productId, quantity);
            } else {
                throw new IllegalArgumentException("Invalid action: " + action);
            }
            JSONObject cartData = getCartData(customerId);
            out.print(cartData.toString());
        } catch (SQLException | ClassNotFoundException e) {
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.print(error.toString());
        } catch (IllegalArgumentException e) {
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.print(error.toString());
        } catch (Exception e) {
            JSONObject error = new JSONObject();
            error.put("error", "An unexpected error occurred");
            out.print(error.toString());
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