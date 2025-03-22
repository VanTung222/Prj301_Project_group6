/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/adminOrder"})
public class AdminOrderServlet extends HttpServlet {
private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        try {
            // Lấy danh sách đơn hàng
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);

            // Debug
            System.out.println("Orders in OrderAdminServlet: " + orders.size());
            for (Order order : orders) {
                System.out.println("Order ID: " + order.getOrderId() + ", Customer ID: " + order.getCustomerId() + ", Details: " + order.getOrderDetails().size());
            }

            // Chuyển hướng đến orders.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/orders.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi lấy danh sách đơn hàng: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}