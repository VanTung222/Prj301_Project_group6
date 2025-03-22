package controller;

import dao.CustomerDAO;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "EditProfileServlet", urlPatterns = {"/editProfile"})
public class EditProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer currentUser = (Customer) session.getAttribute("loggedInUser");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp"); // Chưa đăng nhập
            return;
        }

        currentUser.setEmail(request.getParameter("email"));
        currentUser.setFirstName(request.getParameter("firstName"));
        currentUser.setLastName(request.getParameter("lastName"));
        currentUser.setAddress(request.getParameter("address"));
        currentUser.setPhone(request.getParameter("phone"));

        CustomerDAO customerDAO = new CustomerDAO();
        boolean isUpdated;
        try {
            isUpdated = customerDAO.updateCustomer(currentUser);
            if (isUpdated) {
                session.setAttribute("successMessage", "Cập nhật hồ sơ thành công!");
                session.setAttribute("loggedInUser", currentUser);
            } else {
                session.setAttribute("errorMessage", "Cập nhật thất bại. Vui lòng thử lại!");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Lỗi hệ thống! Vui lòng thử lại sau.");
        }
        response.sendRedirect("profile.jsp");
    }
}