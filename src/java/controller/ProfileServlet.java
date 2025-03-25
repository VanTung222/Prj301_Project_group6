package controller;

import dao.CustomerDAO;
import dao.OrderDAO;
import model.Customer;
import model.Order;
import model.OrderDetail;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import utils.DBUtils;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "img/uploads";

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

            OrderDAO orderDAO = new OrderDAO();

            // Get order statistics
            try (Connection conn = DBUtils.getConnection()) {
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
            }

            // Get recent order (latest one)
            Order recentOrderEntity = orderDAO.getRecentOrderByCustomerId(customerId);
            Map<String, Object> recentOrder = null;
            if (recentOrderEntity != null && !recentOrderEntity.getOrderDetails().isEmpty()) {
                recentOrder = new HashMap<>();
                recentOrder.put("Order_ID", recentOrderEntity.getOrderId());
                recentOrder.put("Order_Date", recentOrderEntity.getOrderDate());
                recentOrder.put("Status", recentOrderEntity.getStatus());
                OrderDetail firstDetail = recentOrderEntity.getOrderDetails().get(0);
                recentOrder.put("Quantity", firstDetail.getQuantity());
                recentOrder.put("Subtotal", firstDetail.getSubtotal());
                // Lấy tên sản phẩm từ OrderDetail (cần đảm bảo OrderDetail có ProductName)
                recentOrder.put("ProductName", firstDetail.getProductName() != null ? firstDetail.getProductName() : "Unknown Product");
            }
            request.setAttribute("recentOrder", recentOrder);

            // Get all orders using OrderDAO
            List<Order> allOrdersEntities = orderDAO.getAllOrdersByCustomerId(customerId);
            List<Map<String, Object>> allOrders = new ArrayList<>();
            for (Order order : allOrdersEntities) {
                if (!order.getOrderDetails().isEmpty()) {
                    Map<String, Object> orderMap = new HashMap<>();
                    orderMap.put("Order_ID", order.getOrderId());
                    orderMap.put("Order_Date", order.getOrderDate());
                    orderMap.put("Status", order.getStatus());
                    OrderDetail firstDetail = order.getOrderDetails().get(0);
                    orderMap.put("Quantity", firstDetail.getQuantity());
                    orderMap.put("Subtotal", firstDetail.getSubtotal());
                    orderMap.put("ProductName", firstDetail.getProductName() != null ? firstDetail.getProductName() : "Unknown Product");
                    allOrders.add(orderMap);
                }
            }
            request.setAttribute("allOrders", allOrders);

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
                handleUpdateProfile(request, response, customerId, session);
            } catch (SQLException e) {
                e.printStackTrace();
                session.setAttribute("message", "Lỗi cơ sở dữ liệu khi xử lý yêu cầu");
                session.setAttribute("messageType", "error");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            response.sendRedirect("profile");
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, int customerId, HttpSession session)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        request.setCharacterEncoding("UTF-8");

        // Get form data
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        Part filePart = request.getPart("profilePicture");

        // Validate input
        if (email == null || email.trim().isEmpty() || firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() || phone == null || phone.trim().isEmpty() ||
                address == null || address.trim().isEmpty()) {
            session.setAttribute("message", "Vui lòng điền đầy đủ thông tin bắt buộc");
            session.setAttribute("messageType", "error");
            doGet(request, response);
            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            session.setAttribute("message", "Email không hợp lệ");
            session.setAttribute("messageType", "error");
            doGet(request, response);
            return;
        }

        if (!phone.matches("(84|0[3|5|7|8|9])+([0-9]{8})")) {
            session.setAttribute("message", "Số điện thoại không hợp lệ");
            session.setAttribute("messageType", "error");
            doGet(request, response);
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        Customer existingCustomer = customerDAO.getCustomerById(customerId);

        if (existingCustomer == null) {
            session.setAttribute("message", "Không tìm thấy thông tin khách hàng");
            session.setAttribute("messageType", "error");
            doGet(request, response);
            return;
        }

        // Handle profile picture upload
        String profilePicturePath = existingCustomer.getProfilePicture();
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            filePart.write(uploadPath + File.separator + fileName);
            profilePicturePath = UPLOAD_DIRECTORY + "/" + fileName;
        }

        // Update customer information
        existingCustomer.setEmail(email);
        existingCustomer.setFirstName(firstName);
        existingCustomer.setLastName(lastName);
        existingCustomer.setPhone(phone);
        existingCustomer.setAddress(address);
        existingCustomer.setProfilePicture(profilePicturePath);

        if (customerDAO.updateCustomer(existingCustomer)) {
            session.setAttribute("customer", existingCustomer);
            session.setAttribute("message", "Cập nhật thông tin thành công");
            session.setAttribute("messageType", "success");
            response.sendRedirect("profile");
        } else {
            session.setAttribute("message", "Không thể cập nhật thông tin");
            session.setAttribute("messageType", "error");
            doGet(request, response);
        }
    }
}