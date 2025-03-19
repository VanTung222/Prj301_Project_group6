package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import org.json.JSONObject;
import utils.DBUtils;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int productId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBUtils.getConnection()) {
            String deleteCartQuery = "DELETE FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteCartQuery);
            deleteStmt.setInt(1, customerId);
            deleteStmt.setInt(2, productId);
            deleteStmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("message", "Product removed successfully");
        response.getWriter().write(jsonResponse.toString());
    }
}
