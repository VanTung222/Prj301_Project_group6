package controller;

import dao.CustomerDAO;
import model.Customer;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response); // Hiển thị login.jsp khi GET
    }

    @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
        request.setAttribute("error", "Username and password are required!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return;
    }

    try {
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.checkLogin(username, password);

        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            session.setAttribute("username", customer.getUsername());
            session.setAttribute("customerId", customer.getCustomerId());

            // Lấy role từ database
            int role = customerDAO.getRoleByCustomerId(customer.getCustomerId());
            session.setAttribute("role", role);

            // Debug: Kiểm tra giá trị role
            System.out.println("Login Success: " + username + " | Role: " + role);

            // Kiểm tra role để chuyển hướng
            if (role == 0) { // Giả sử 1 là role của admin
                response.sendRedirect("dashboard");
            } else {
                response.sendRedirect("home");
            }
        } else {
            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "An error occurred. Please try again!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    }
}