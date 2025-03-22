package controller;

import dao.OrderDAO;
import dao.CustomerDAO;
import dao.ProductDAO;
import model.Order;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.Customer;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/adminOrder"})
public class AdminOrderServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private CustomerDAO customerDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        customerDAO = new CustomerDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            // Lấy thông tin admin từ CustomerDAO
            Customer admin = null;
            if (username != null) {
                admin = customerDAO.getCustomerByUsername(username);
            }
            
            // Lấy danh sách đơn hàng
            List<Order> orders = orderDAO.getAllOrders();

            // 1. Tính tổng doanh thu
            double totalRevenue = calculateTotalRevenue(orders);

            // 2. Lấy tổng số đơn hàng
            int totalOrders = orders.size();

            // 3. Lấy tổng số khách hàng
            int totalCustomers = customerDAO.getTotalCustomers();

            // 4. Lấy tổng số sản phẩm
            int totalProducts = productDAO.getTotalProducts();

            // Đặt các thuộc tính vào request
            request.setAttribute("orders", orders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("admin", admin);

            // Debug
            System.out.println("Orders in OrderAdminServlet: " + orders.size());
            for (Order order : orders) {
                System.out.println("Order ID: " + order.getOrderId() + ", Customer ID: " + order.getCustomerId() + ", Details: " + (order.getOrderDetails() != null ? order.getOrderDetails().size() : 0));
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

    private double calculateTotalRevenue(List<Order> orders) {
        double totalRevenue = 0.0;
        if (orders != null) {
            for (Order order : orders) {
                totalRevenue += order.getTotalAmount();
            }
        }
        return totalRevenue;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}