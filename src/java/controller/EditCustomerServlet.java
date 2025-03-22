package controller;

import java.io.IOException;
import java.io.PrintWriter;
import dao.CustomerDAO;
import jakarta.servlet.RequestDispatcher;
import model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "EditCustomerServlet", urlPatterns = {"/EditCustomerServlet"})
public class EditCustomerServlet extends HttpServlet {

    // 1) doGet: Lấy ID khách hàng, lấy thông tin từ DB, forward sang edit-customer.jsp
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy customerId từ param
        String idParam = request.getParameter("customerId");
        int customerId = 0;
        if (idParam != null) {
            customerId = Integer.parseInt(idParam);
        }

        // Gọi DAO để lấy thông tin khách hàng
        CustomerDAO dao = new CustomerDAO();
        Customer customer = null;
        try {
            customer = dao.getCustomerById(customerId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Đưa customer lên request attribute
        request.setAttribute("customer", customer);

        // Chuyển tiếp sang edit-customer.jsp
        RequestDispatcher rd = request.getRequestDispatcher("edit-customer.jsp");
        rd.forward(request, response);
    }

    // 2) doPost: Nhận dữ liệu form gửi lên, update DB
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy các tham số từ form
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password"); // có thể rỗng

        // Tạo DAO
        CustomerDAO dao = new CustomerDAO();
        try {
            // Lấy customer hiện tại
            Customer customer = dao.getCustomerById(customerId);
            if (customer != null) {
                // Cập nhật các trường
                customer.setUsername(username);
                customer.setEmail(email);
                customer.setFirstName(firstName);
                customer.setLastName(lastName);
                customer.setAddress(address);
                customer.setPhone(phone);

                // Nếu password không rỗng => cập nhật
                if (password != null && !password.trim().isEmpty()) {
                    customer.setPassword(password);
                }

                // Gọi phương thức updateCustomer (hoặc updateCustomerProfile)
                boolean updated = dao.updateCustomer(customer);

                if (updated) {
                    // Cập nhật thành công -> chuyển hướng về trang danh sách
                    response.sendRedirect("CustomerManagerAd");
                } else {
                    // Thất bại -> thông báo lỗi
                    response.getWriter().println("Cập nhật thất bại!");
                }
            } else {
                response.getWriter().println("Không tìm thấy khách hàng với ID=" + customerId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Đã xảy ra lỗi khi cập nhật!");
        }
    }
}
