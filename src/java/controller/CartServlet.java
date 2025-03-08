/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
//public class CartServlet extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet CartServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        ArrayList<Cake> cart = (session.getAttribute("cart") == null) ? new ArrayList<>() : (ArrayList<Cake>) session.getAttribute("cart");
//
//        // Kiểm tra dữ liệu đầu vào
//        String idParam = request.getParameter("id");
//        String name = request.getParameter("name");
//        String priceParam = request.getParameter("price");
//        String description = request.getParameter("description");
//
//        System.out.println("Dữ liệu nhận được từ request: ID = " + idParam + ", Name = " + name + ", Price = " + priceParam);
//
//        if (idParam == null || priceParam == null) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu dữ liệu sản phẩm");
//            return;
//        }
//
//        int id = Integer.parseInt(idParam);
//        double price = Double.parseDouble(priceParam);
//
//        boolean found = false;
//        for (Cake cake : cart) {
//            if (cake.getId() == id) {
//                cake.setStock(cake.getStock() + 1);
//                found = true;
//                break;
//            }
//        }
//        if (!found) {
//            cart.add(new Cake(id, name, price, 1, description));
//        }
//
//        session.setAttribute("cart", cart);
//
//        // In danh sách giỏ hàng để kiểm tra
//        System.out.println("Giỏ hàng hiện tại:");
//        for (Cake c : cart) {
//            System.out.println(" - " + c.getName() + " | Giá: " + c.getPrice() + " | Số lượng: " + c.getStock());
//        }
//
//        // Tính tổng tiền
//        double total = cart.stream().mapToDouble(c -> c.getPrice() * c.getStock()).sum();
//        System.out.println("Tổng tiền: " + total); // Log tổng tiền
//
//        response.getWriter().write(String.format("%.2f", total));
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;



@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Lớp Product đại diện cho sản phẩm trong giỏ hàng
    public static class Product {
        String name;
        double price;
        int quantity;
        String description;

        public Product(String name, double price, int quantity, String description) {
            this.name = name;
            this.price = price;
            this.quantity = quantity;
            this.description = description;
        }
    }

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Lấy giỏ hàng từ session, nếu chưa có thì tạo mới
        Map<String, Product> cart = (Map<String, Product>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        // Lấy thông tin sản phẩm từ request
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));

        // Kiểm tra sản phẩm đã có trong giỏ hàng chưa
        if (cart.containsKey(id)) {
            Product existingProduct = cart.get(id);
            existingProduct.quantity += 1; // Tăng số lượng sản phẩm lên
        } else {
            cart.put(id, new Product(name, price, 1, description));
        }

        // Lưu giỏ hàng vào session
        session.setAttribute("cart", cart);

        // Tính tổng tiền và tổng số lượng
        double totalAmount = 0.0;
        int totalItems = 0;

        for (Product product : cart.values()) {
            totalAmount += product.price * product.quantity;
            totalItems += product.quantity;
        }

        // Trả về JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("total", String.format("%.2f", totalAmount)); // Định dạng 2 số sau dấu thập phân
        jsonResponse.put("count", totalItems);

        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }
}

