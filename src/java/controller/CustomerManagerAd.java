package controller;

import dao.CustomerDAO;
import model.Customer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CustomerManagerAd", urlPatterns = {"/CustomerManagerAd"})
public class CustomerManagerAd extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Số khách hàng trên mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CustomerDAO dao = new CustomerDAO();
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            // Lấy thông tin admin từ CustomerDAO
            Customer admin = null;
            if (username != null) {
                admin = dao.getCustomerByUsername(username);
            }
            List<Customer> customers;
            // Lấy tham số trang từ request
            String pageParam = request.getParameter("page");
            int page = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
            if (page < 1) page = 1;
            // Tính toán offset
            int offset = (page - 1) * PAGE_SIZE;
            // Lấy danh sách khách hàng với phân trang
            customers = dao.getAllCustomers(); // Cần sửa DAO để hỗ trợ phân trang
            int totalCustomers = customers.size();
            int totalPages = (int) Math.ceil((double) totalCustomers / PAGE_SIZE);
            // Lấy danh sách khách hàng cho trang hiện tại
            int toIndex = Math.min(offset + PAGE_SIZE, totalCustomers);
            customers = customers.subList(offset, toIndex);
            // Đặt các thuộc tính vào request
            request.setAttribute("customers", customers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("admin", admin);
            RequestDispatcher dispatcher = request.getRequestDispatcher("customers.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CustomerManagerAd.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}