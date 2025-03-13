package controller;

import dao.CustomerDAO;
import model.Customer;
import utils.DBUtils;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Customer_ID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = (int) session.getAttribute("Customer_ID");
        CustomerDAO customerDAO = new CustomerDAO();
        
        try {
            Customer customer = customerDAO.getCustomerById(customerId);
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
            } else {
                response.sendRedirect("profile");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("Customer_ID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = (int) session.getAttribute("Customer_ID");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
            doGet(request, response);
            return;
        }

        // Validate phone number format
        if (!phone.matches("\\d{10}")) {
            request.setAttribute("error", "Số điện thoại không hợp lệ");
            doGet(request, response);
            return;
        }

        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Email không hợp lệ");
            doGet(request, response);
            return;
        }

        // Check if passwords match when changing password
        if (password != null && !password.trim().isEmpty()) {
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp");
                doGet(request, response);
                return;
            }
            if (password.length() < 6) {
                request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
                doGet(request, response);
                return;
            }
        }

        try {
            CustomerDAO customerDAO = new CustomerDAO();
            
            // Check if username is already taken by another user
            Customer existingCustomer = customerDAO.getCustomerByUsername(username);
            if (existingCustomer != null && existingCustomer.getCustomerId() != customerId) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại");
                doGet(request, response);
                return;
            }

            // Update customer information
            boolean updated = customerDAO.updateCustomerProfile(
                customerId,
                username,
                email,
                firstName,
                lastName,
                phone,
                address,
                password
            );

            if (updated) {
                request.setAttribute("success", "Cập nhật thông tin thành công");
                response.sendRedirect("profile");
            } else {
                request.setAttribute("error", "Không thể cập nhật thông tin");
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi cập nhật thông tin");
            doGet(request, response);
        }
    }
}
