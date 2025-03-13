/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
//
//import com.sun.jdi.connect.spi.Connection;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.DatabaseInfo;
//import java.sql.*;
//import java.util.ArrayList;
//import java.io.IOException;
//import java.util.ArrayList;
//import model.Cake;
//
///**
// *
// * @author admin
// */
//@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})




//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import org.json.JSONArray;
//import org.json.JSONObject;
//
//@WebServlet("/CartServlet")
//public class CartServlet extends HttpServlet {
//
//    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=cakeManagement;user=sa;password=1357910;encrypt=false;trustServerCertificate=true";
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer customerId = (Integer) session.getAttribute("customerId");
//        if (customerId == null) {
//            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập");
//            return;
//        }
//        
//        int productId;
//        try {
//            productId = Integer.parseInt(request.getParameter("id"));
//        } catch (NumberFormatException e) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ");
//            return;
//        }
//
//        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
//            String checkCartQuery = "SELECT Quantity FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
//            PreparedStatement checkStmt = conn.prepareStatement(checkCartQuery);
//            checkStmt.setInt(1, customerId);
//            checkStmt.setInt(2, productId);
//            ResultSet rs = checkStmt.executeQuery();
//
//            if (rs.next()) {
//                int quantity = rs.getInt("Quantity") + 1;
//                String updateCartQuery = "UPDATE Shopping_Cart SET Quantity = ? WHERE Customer_ID = ? AND Product_ID = ?";
//                PreparedStatement updateStmt = conn.prepareStatement(updateCartQuery);
//                updateStmt.setInt(1, quantity);
//                updateStmt.setInt(2, customerId);
//                updateStmt.setInt(3, productId);
//                updateStmt.executeUpdate();
//            } else {
//                String insertCartQuery = "INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date) VALUES (?, ?, ?, GETDATE())";
//                PreparedStatement insertStmt = conn.prepareStatement(insertCartQuery);
//                insertStmt.setInt(1, customerId);
//                insertStmt.setInt(2, productId);
//                insertStmt.setInt(3, 1);
//                insertStmt.executeUpdate();
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi máy chủ khi xử lý giỏ hàng");
//            return;
//        }
//        doGet(request, response);
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer customerId = (Integer) session.getAttribute("customerId");
//        if (customerId == null) {
//            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập");
//            return;
//        }
//        
//        JSONArray cartArray = new JSONArray();
//        double totalAmount = 0;
//        int totalItems = 0;
//
//        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
//            String query = "SELECT p.Product_ID, p.Name, p.Price, p.Product_img, c.Quantity FROM Shopping_Cart c "
//                    + "JOIN Product p ON c.Product_ID = p.Product_ID WHERE c.Customer_ID = ?";
//            PreparedStatement stmt = conn.prepareStatement(query);
//            stmt.setInt(1, customerId);
//            ResultSet rs = stmt.executeQuery();
//
//            while (rs.next()) {
//                JSONObject item = new JSONObject();
//                item.put("id", rs.getInt("Product_ID"));
//                item.put("name", rs.getString("Name"));
//                item.put("price", rs.getDouble("Price"));
//                item.put("image", rs.getString("Product_img"));
//                item.put("quantity", rs.getInt("Quantity"));
//                cartArray.put(item);
//                totalAmount += rs.getDouble("Price") * rs.getInt("Quantity");
//                totalItems += rs.getInt("Quantity");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi máy chủ khi lấy giỏ hàng");
//            return;
//        }
//
//        JSONObject jsonResponse = new JSONObject();
//        jsonResponse.put("cart", cartArray);
//        jsonResponse.put("total", String.format("%.2f", totalAmount));
//        jsonResponse.put("count", totalItems);
//
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        response.getWriter().write(jsonResponse.toString());
//    }
//}






import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=cakeManagement;user=sa;password=1357910;encrypt=false;trustServerCertificate=true";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập");
            return;
        }
        
        String action = request.getParameter("action");
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ");
            return;
        }
        
        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
            if ("update".equals(action)) {
                int quantityChange = Integer.parseInt(request.getParameter("quantity"));
                updateCartQuantity(conn, customerId, productId, quantityChange);
            } else if ("remove".equals(action)) {
                removeCartItem(conn, customerId, productId);
            } else {
                addToCart(conn, customerId, productId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi máy chủ khi xử lý giỏ hàng");
            return;
        }
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập");
            return;
        }
        
        JSONArray cartArray = new JSONArray();
        double totalAmount = 0;
        int totalItems = 0;

        try (Connection conn = DriverManager.getConnection(JDBC_URL)) {
            String query = "SELECT p.Product_ID, p.Name, p.Price, p.Product_img, c.Quantity FROM Shopping_Cart c "
                    + "JOIN Product p ON c.Product_ID = p.Product_ID WHERE c.Customer_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JSONObject item = new JSONObject();
                item.put("id", rs.getInt("Product_ID"));
                item.put("name", rs.getString("Name"));
                item.put("price", rs.getDouble("Price"));
                item.put("image", rs.getString("Product_img"));
                item.put("quantity", rs.getInt("Quantity"));
                cartArray.put(item);
                totalAmount += rs.getDouble("Price") * rs.getInt("Quantity");
                totalItems += rs.getInt("Quantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi máy chủ khi lấy giỏ hàng");
            return;
        }

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("cart", cartArray);
        jsonResponse.put("total", String.format("%.2f", totalAmount));
        jsonResponse.put("count", totalItems);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }
    
    private void addToCart(Connection conn, int customerId, int productId) throws Exception {
        String checkCartQuery = "SELECT Quantity FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkCartQuery);
        checkStmt.setInt(1, customerId);
        checkStmt.setInt(2, productId);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            int quantity = rs.getInt("Quantity") + 1;
            String updateCartQuery = "UPDATE Shopping_Cart SET Quantity = ? WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateCartQuery);
            updateStmt.setInt(1, quantity);
            updateStmt.setInt(2, customerId);
            updateStmt.setInt(3, productId);
            updateStmt.executeUpdate();
        } else {
            String insertCartQuery = "INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date) VALUES (?, ?, ?, GETDATE())";
            PreparedStatement insertStmt = conn.prepareStatement(insertCartQuery);
            insertStmt.setInt(1, customerId);
            insertStmt.setInt(2, productId);
            insertStmt.setInt(3, 1);
            insertStmt.executeUpdate();
        }
    }
    
    private void updateCartQuantity(Connection conn, int customerId, int productId, int quantityChange) throws Exception {
        String updateCartQuery = "UPDATE Shopping_Cart SET Quantity = Quantity + ? WHERE Customer_ID = ? AND Product_ID = ? AND Quantity + ? > 0";
        PreparedStatement updateStmt = conn.prepareStatement(updateCartQuery);
        updateStmt.setInt(1, quantityChange);
        updateStmt.setInt(2, customerId);
        updateStmt.setInt(3, productId);
        updateStmt.setInt(4, quantityChange);
        updateStmt.executeUpdate();
    }
    
    private void removeCartItem(Connection conn, int customerId, int productId) throws Exception {
        String deleteCartQuery = "DELETE FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
        PreparedStatement deleteStmt = conn.prepareStatement(deleteCartQuery);
        deleteStmt.setInt(1, customerId);
        deleteStmt.setInt(2, productId);
        deleteStmt.executeUpdate();
    }
}












// code đang bị lỗi 

//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.CartDAO;
//import model.CartItem;
//import org.json.JSONArray;
//import org.json.JSONObject;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.List;
//
//@WebServlet("/CartServlet")
//public class CartServlet extends HttpServlet {
//    private final CartDAO cartDAO = new CartDAO();
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer customerId = (Integer) session.getAttribute("customerId");
//        if (customerId == null) {
//            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập");
//            return;
//        }
//
//        String action = request.getParameter("action");
//        int productId;
//        try {
//            productId = Integer.parseInt(request.getParameter("id"));
//        } catch (NumberFormatException e) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ");
//            return;
//        }
//
//        if ("add".equals(action)) {
//            cartDAO.addToCart(customerId, productId);
//        } else if ("remove".equals(action)) {
//            cartDAO.removeFromCart(customerId, productId);
//        } else if ("update".equals(action)) {
//            int quantity;
//            try {
//                quantity = Integer.parseInt(request.getParameter("quantity"));
//                if (quantity > 0) {
//                    cartDAO.updateCart(customerId, productId, quantity);
//                }
//            } catch (NumberFormatException e) {
//                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số lượng không hợp lệ");
//                return;
//            }
//        }
//        doGet(request, response);
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer customerId = (Integer) session.getAttribute("customerId");
//        if (customerId == null) {
//            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập");
//            return;
//        }
//
//        List<CartItem> cartItems = cartDAO.getCartItems(customerId);
//        JSONArray cartArray = new JSONArray();
//        double totalAmount = 0;
//        int totalItems = 0;
//
//        for (CartItem item : cartItems) {
//            JSONObject jsonItem = new JSONObject();
//            jsonItem.put("id", item.getProduct().getId());
//            jsonItem.put("name", item.getProduct().getName());
//            jsonItem.put("price", item.getProduct().getPrice());
//            jsonItem.put("image", item.getProduct().getImage());
//            jsonItem.put("quantity", item.getQuantity());
//            cartArray.put(jsonItem);
//            totalAmount += item.getTotalPrice();
//            totalItems += item.getQuantity();
//        }
//
//        JSONObject jsonResponse = new JSONObject();
//        jsonResponse.put("cart", cartArray);
//        jsonResponse.put("total", String.format("%.2f", totalAmount));
//        jsonResponse.put("count", totalItems);
//
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        PrintWriter out = response.getWriter();
//        out.write(jsonResponse.toString());
//        out.flush();
//    }
//}





//theem xoa cart
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.CartDAO;
//import model.CartItem;
//import org.json.JSONArray;
//import org.json.JSONObject;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.List;
//
//@WebServlet("/CartServlet")
//public class CartServlet extends HttpServlet {
//    private final CartDAO cartDAO = new CartDAO();
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer customerId = (Integer) session.getAttribute("customerId");
//        if (customerId == null) {
//            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập");
//            return;
//        }
//
//        String action = request.getParameter("action");
//        int productId = Integer.parseInt(request.getParameter("id"));
//
//        if ("add".equals(action)) {
//            cartDAO.addToCart(customerId, productId);
//        } else if ("remove".equals(action)) {
//            cartDAO.removeFromCart(customerId, productId);
//        } else if ("update".equals(action)) {
//            int quantity = Integer.parseInt(request.getParameter("quantity"));
//            if (quantity > 0) {
//                cartDAO.updateCart(customerId, productId, quantity);
//            }
//        }
//        doGet(request, response);
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer customerId = (Integer) session.getAttribute("customerId");
//        if (customerId == null) {
//            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập");
//            return;
//        }
//
//        List<CartItem> cartItems = cartDAO.getCartItems(customerId);
//        JSONArray cartArray = new JSONArray();
//        double totalAmount = 0;
//        int totalItems = 0;
//
//        for (CartItem item : cartItems) {
//            JSONObject jsonItem = new JSONObject();
//            jsonItem.put("id", item.getProduct().getId());
//            jsonItem.put("name", item.getProduct().getName());
//            jsonItem.put("price", item.getProduct().getPrice());
//            jsonItem.put("image", item.getProduct().getImage());
//            jsonItem.put("quantity", item.getQuantity());
//            cartArray.put(jsonItem);
//            totalAmount += item.getTotalPrice();
//            totalItems += item.getQuantity();
//        }
//
//        JSONObject jsonResponse = new JSONObject();
//        jsonResponse.put("cart", cartArray);
//        jsonResponse.put("total", String.format("%.2f", totalAmount));
//        jsonResponse.put("count", totalItems);
//
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        PrintWriter out = response.getWriter();
//        out.write(jsonResponse.toString());
//        out.flush();
//    }
//}
