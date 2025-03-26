package controller;

import dao.CustomerDAO;
import model.Customer;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "CustomerManagerAd", urlPatterns = {"/CustomerManagerAd"})
public class CustomerManagerAd extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Số khách hàng trên mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CustomerDAO dao = new CustomerDAO();

            // Lấy tham số trang và bộ lọc vai trò từ request
            String pageParam = request.getParameter("page");
            String roleFilter = request.getParameter("roleFilter");
            int page = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
            if (page < 1) page = 1;

            // Tính toán offset
            int offset = (page - 1) * PAGE_SIZE;

            // Lấy danh sách khách hàng với phân trang và lọc vai trò
            List<Customer> customers;
            int totalCustomers;
            if (roleFilter != null && !roleFilter.isEmpty()) {
                int role = Integer.parseInt(roleFilter);
                if (role == 0 || role == 1) { // Chỉ xử lý Role=0 hoặc Role=1
                    customers = dao.getCustomersByRoleAndPage(role, offset, PAGE_SIZE);
                    totalCustomers = dao.getTotalCustomersByRole(role);
                } else {
                    customers = dao.getCustomersByPage(offset, PAGE_SIZE);
                    totalCustomers = dao.getTotalActiveCustomers();
                }
            } else {
                customers = dao.getCustomersByPage(offset, PAGE_SIZE);
                totalCustomers = dao.getTotalActiveCustomers();
            }

            int totalPages = (int) Math.ceil((double) totalCustomers / PAGE_SIZE);

            // Đặt các thuộc tính vào request
            request.setAttribute("customers", customers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("roleFilter", roleFilter); // Lưu roleFilter để JSP sử dụng

            RequestDispatcher dispatcher = request.getRequestDispatcher("customers.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(CustomerManagerAd.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Đã xảy ra lỗi khi tải danh sách khách hàng!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CustomerManagerAd.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            try {
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                CustomerDAO dao = new CustomerDAO();
                boolean success = dao.deleteAccount(customerId); // Cập nhật Role=2
                String currentPage = request.getParameter("currentPage");
                String roleFilter = request.getParameter("roleFilter");
                if (success) {
                    String redirectUrl = "CustomerManagerAd?page=" + (currentPage != null ? currentPage : "1");
                    if (roleFilter != null && !roleFilter.isEmpty()) {
                        redirectUrl += "&roleFilter=" + roleFilter;
                    }
                    response.sendRedirect(redirectUrl);
                } else {
                    request.setAttribute("error", "Không thể đánh dấu tài khoản là hết hạn!");
                    doGet(request, response);
                }
            } catch (SQLException | ClassNotFoundException ex) {
                Logger.getLogger(CustomerManagerAd.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("error", "Đã xảy ra lỗi khi xử lý yêu cầu!");
                doGet(request, response);
            }
        } else {
            doGet(request, response);
        }
    }
}