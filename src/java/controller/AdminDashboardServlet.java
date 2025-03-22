package controller;

import dao.OrderDAO;
import dao.CustomerDAO;
import dao.ProductDAO;
import model.Order;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/dashboard"})
public class AdminDashboardServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private CustomerDAO customerDAO = new CustomerDAO();
    private ProductDAO productDAO = new ProductDAO();

    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1. Lấy tổng doanh thu
            double totalRevenue = calculateTotalRevenue();

            // 2. Lấy tổng số đơn hàng
            List<Order> allOrders = orderDAO.getAllOrders();
            int totalOrders = allOrders.size();

            // 3. Lấy tổng số khách hàng
            int totalCustomers = customerDAO.getTotalCustomers();

            // 4. Lấy tổng số sản phẩm và số sản phẩm sắp hết hàng
            int totalProducts = productDAO.getTotalProducts();
            int lowStockItems = productDAO.getLowStockItemsCount();

            // 5. Lấy danh sách đơn hàng gần đây (giới hạn 5 đơn hàng)
            List<Order> recentOrders = getRecentOrders(allOrders);

            // 6. Lấy dữ liệu đơn hàng theo ngày
            Map<String, Integer> ordersByDate = orderDAO.getOrdersByDate();

            // 7. Lấy dữ liệu doanh thu theo tuần trong tháng
            Map<String, Double> revenueByWeekInMonth = orderDAO.getRevenueByWeekInMonth();

            // Đặt các thuộc tính vào request
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("lowStockItems", lowStockItems);
            request.setAttribute("recentOrders", recentOrders);
            request.setAttribute("ordersByDate", ordersByDate);
            request.setAttribute("revenueByWeekInMonth", revenueByWeekInMonth);

            // Debug
            System.out.println("AdminDashboardServlet: Processing request for /dashboard");
            System.out.println("Total Revenue: " + totalRevenue);
            System.out.println("Total Orders: " + totalOrders);
            System.out.println("Total Customers: " + totalCustomers);
            System.out.println("Total Products: " + totalProducts);
            System.out.println("Low Stock Items: " + lowStockItems);
            System.out.println("Orders By Date: " + ordersByDate);
            System.out.println("Revenue By Week In Month: " + revenueByWeekInMonth);

            // Chuyển hướng đến dashboard.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/dashboard.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi lấy dữ liệu dashboard: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        }
    }

    private double calculateTotalRevenue() throws SQLException, ClassNotFoundException {
        List<Order> orders = orderDAO.getAllOrders();
        double totalRevenue = 0.0;
        for (Order order : orders) {
            totalRevenue += order.getTotalAmount();
        }
        return totalRevenue;
    }

    private List<Order> getRecentOrders(List<Order> allOrders) {
        int limit = Math.min(5, allOrders.size());
        return allOrders.subList(0, limit);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}               