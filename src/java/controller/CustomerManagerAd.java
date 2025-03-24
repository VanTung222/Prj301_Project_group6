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

    private static final int PAGE_SIZE = 8; // Số khách hàng trên mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CustomerDAO dao = new CustomerDAO();
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