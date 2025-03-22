package controller;

import dao.CustomerDAO;
import model.Customer;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
                String orderSql = "SELECT COUNT(*) as total, "
                        + "SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END) as completed, "
                        + "SUM(CASE WHEN Status = 'Processing' THEN 1 ELSE 0 END) as processing "
                        + "FROM Orders WHERE Customer_ID = ?";
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

                // Get recent orders and store in a List
                List<Map<String, Object>> recentOrders = new ArrayList<>();
                String recentOrdersSql = "SELECT TOP 5 o.Order_ID, o.Order_Date, o.Status, "
                        + "od.Quantity, od.Subtotal, p.Name as ProductName "
                        + "FROM Orders o "
                        + "JOIN OrderDetail od ON o.Order_ID = od.Order_ID "
                        + "JOIN Product p ON od.Product_ID = p.Product_ID "
                        + "WHERE o.Customer_ID = ? "
                        + "ORDER BY o.Order_Date DESC";
                try (PreparedStatement recentPs = conn.prepareStatement(recentOrdersSql)) {
                    recentPs.setInt(1, customerId);
                    try (ResultSet recentRs = recentPs.executeQuery()) {
                        while (recentRs.next()) {
                            Map<String, Object> order = new HashMap<>();
                            order.put("Order_ID", recentRs.getInt("Order_ID"));
                            order.put("Order_Date", recentRs.getDate("Order_Date"));
                            order.put("Status", recentRs.getString("Status"));
                            order.put("Quantity", recentRs.getInt("Quantity"));
                            order.put("Subtotal", recentRs.getDouble("Subtotal"));
                            order.put("ProductName", recentRs.getString("ProductName"));
                            recentOrders.add(order);
                        }
                    }
                }
                request.setAttribute("recentOrders", recentOrders);
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

        Customer currentCustomer = (Customer) session.getAttribute("customer");
        int customerId = currentCustomer.getCustomerId();
        
        String action = request.getParameter("action");
        if ("update-profile".equals(action)) {
            try {
                handleUpdateProfile(request, response, customerId);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi cơ sở dữ liệu khi xử lý yêu cầu");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            response.sendRedirect("profile");
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, int customerId)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        request.setCharacterEncoding("UTF-8");
        
        // Lấy dữ liệu từ form
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Validate input
        if (email == null || email.trim().isEmpty() ||
            firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
            doGet(request, response);
            return;
        }

        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Email không hợp lệ");
            doGet(request, response);
            return;
        }

        // Validate phone number format
        if (!phone.matches("(84|0[3|5|7|8|9])+([0-9]{8})")) {
            request.setAttribute("error", "Số điện thoại không hợp lệ");
            doGet(request, response);
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        Customer existingCustomer = customerDAO.getCustomerById(customerId);

        if (existingCustomer == null) {
            request.setAttribute("error", "Không tìm thấy thông tin khách hàng");
            doGet(request, response);
            return;
        }

        // Cập nhật thông tin mới vào đối tượng Customer
        existingCustomer.setEmail(email);
        existingCustomer.setFirstName(firstName);
        existingCustomer.setLastName(lastName);
        existingCustomer.setPhone(phone);
        existingCustomer.setAddress(address);

        // Cập nhật thông tin vào database
        if (customerDAO.updateCustomer(existingCustomer)) {
            // Cập nhật session với thông tin mới
            request.getSession().setAttribute("customer", existingCustomer);
            request.setAttribute("success", "Cập nhật thông tin thành công");
            response.sendRedirect("profile");
        } else {
            request.setAttribute("error", "Không thể cập nhật thông tin");
            doGet(request, response);
        }
    }
}
