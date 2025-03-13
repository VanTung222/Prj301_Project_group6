package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login") // Đảm bảo action trong login.jsp trỏ đúng URL này
public class LoginServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:sqlserver://127.0.0.1:1433;databaseName=cakeManagement1;encrypt=false;trustServerCertificate=true";
    private static final String JDBC_USER = "sa";
    private static final String JDBC_PASSWORD = "123456789";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Không tìm thấy JDBC Driver.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email và mật khẩu không được để trống.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD); PreparedStatement stmt = conn.prepareStatement("SELECT Customer_ID, Username FROM Customers WHERE Email = ? AND Password = ?")) {

            stmt.setString(1, email);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int customerId = rs.getInt("Customer_ID");
                    String username = rs.getString("Username");

                    HttpSession session = request.getSession();
                    session.setAttribute("customerId", customerId);
                    session.setAttribute("username", username);

                    response.sendRedirect("index.jsp"); // Điều hướng về trang chính
                } else {
                    request.setAttribute("error", "Email hoặc mật khẩu không đúng.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi chi tiết ra console
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }
}
