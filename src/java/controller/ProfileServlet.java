package controller;

import dao.CustomerDAO;
import model.Customer;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.DBUtils;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("customer");
        int customerId = customer.getCustomerId();

        try {
            // Refresh customer information
            CustomerDAO customerDAO = new CustomerDAO();
            Customer updatedCustomer = customerDAO.getCustomerById(customerId);
            if (updatedCustomer != null) {
                session.setAttribute("customer", updatedCustomer);
                request.setAttribute("customer", updatedCustomer);
            } else {
                request.setAttribute("error", "Không tìm thấy thông tin khách hàng");
            }

            try (Connection conn = DBUtils.getConnection()) {
                // Get order statistics
                String orderSql = "SELECT COUNT(*) as total, " +
                                "SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END) as completed, " +
                                "SUM(CASE WHEN Status = 'Processing' THEN 1 ELSE 0 END) as processing " +
                                "FROM Orders WHERE Customer_ID = ?";
                try (PreparedStatement orderPs = conn.prepareStatement(orderSql)) {
                    orderPs.setInt(1, customerId);
                    try (ResultSet orderRs = orderPs.executeQuery()) {
                        if (orderRs.next()) {
                            request.setAttribute("totalOrders", orderRs.getInt("total"));
                            request.setAttribute("completedOrders", orderRs.getInt("completed"));
                            request.setAttribute("processingOrders", orderRs.getInt("processing"));
                        }
                    }
                }

                // Get recent orders
                String recentOrdersSql = "SELECT TOP 5 o.Order_ID, o.Order_Date, o.Status, " +
                                       "od.Quantity, od.Subtotal, p.Name as ProductName " +
                                       "FROM Orders o " +
                                       "JOIN OrderDetail od ON o.Order_ID = od.Order_ID " +
                                       "JOIN Product p ON od.Product_ID = p.Product_ID " +
                                       "WHERE o.Customer_ID = ? " +
                                       "ORDER BY o.Order_Date DESC";
                try (PreparedStatement recentPs = conn.prepareStatement(recentOrdersSql)) {
                    recentPs.setInt(1, customerId);
                    ResultSet recentRs = recentPs.executeQuery();
                    request.setAttribute("recentOrders", recentRs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tải thông tin người dùng");
        }
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("customer");
        int customerId = customer.getCustomerId();

        // Check action parameter
        String action = request.getParameter("action");
        if ("edit-profile".equals(action)) {
            try {
                CustomerDAO customerDAO = new CustomerDAO();
                Customer updatedCustomer = customerDAO.getCustomerById(customerId);
                if (updatedCustomer != null) {
                    request.setAttribute("customer", updatedCustomer);
                    request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không tìm thấy thông tin khách hàng để chỉnh sửa");
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi cơ sở dữ liệu khi tải trang chỉnh sửa thông tin");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("profile");
        }
    }
}