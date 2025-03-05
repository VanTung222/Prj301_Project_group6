package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.DBUtils;
import model.Review;
import model.ReviewDAO;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/review"})
public class ReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("user_id");

        // Nếu chưa đăng nhập thì chuyển hướng đến trang login
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId;
        int rating;
        String comment = request.getParameter("comment");

        try {
            productId = Integer.parseInt(request.getParameter("product_id"));
            rating = Integer.parseInt(request.getParameter("rating"));
        } catch (NumberFormatException e) {
            response.sendRedirect("shop-details.jsp?error=invalid_input");
            return;
        }

        // Tạo đối tượng Review
        Review review = new Review(customerId, productId, rating, comment);

        // Lưu review vào cơ sở dữ liệu thông qua ReviewDAO
        boolean result = ReviewDAO.addReview(review);

        if (result) {
            // Sau khi thêm review thành công, chuyển hướng lại trang chi tiết sản phẩm
            response.sendRedirect("shop-details.jsp?product_id=" + productId);
        } else {
            // Nếu có lỗi trong quá trình thêm review, trả về trang lỗi
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add review.");
        }
    }

    // Lấy các review của sản phẩm theo productId
    public static List<Review> getReviewsByProductId(int productId) {
        return ReviewDAO.getReviewsByProductId(productId);
    }
}