package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userID = (int) session.getAttribute("userID");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DriverManager.getConnection("jdbc:sqlserver://LAPTOP-CGID9TIO;databaseName=managementSignUpz", "sa", "123")) {
            String sql = password.isEmpty()
                    ? "UPDATE Users SET fullName=?, email=? WHERE userID=?"
                    : "UPDATE Users SET fullName=?, email=?, password=? WHERE userID=?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, fullName);
                ps.setString(2, email);
                if (!password.isEmpty()) {
                    ps.setString(3, password);
                    ps.setInt(4, userID);
                } else {
                    ps.setInt(3, userID);
                }
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        session.setAttribute("fullName", fullName);
        session.setAttribute("email", email);
        response.sendRedirect("profile.jsp");
    }
}
