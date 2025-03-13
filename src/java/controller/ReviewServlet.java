package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Review;
import dao.ReviewDAO;
import model.Customer;
import dao.CustomerDAO;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/review"})
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("product_id"));
        
        // Chuyển hướng về trang chi tiết sản phẩm
        response.sendRedirect("shop-details.jsp?product_id=" + productId);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Customer customer = customerDAO.getCustomerByUsername(username);
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = customer.getCustomerId();
        int productId = Integer.parseInt(request.getParameter("product_id"));

        try {
            switch (action) {
                case "add":
                    handleAddReview(request, response, customerId);
                    break;
                case "edit":
                    handleEditReview(request, response, customerId);
                    break;
                case "delete":
                    handleDeleteReview(request, response, customerId, productId);
                    break;
                default:
                    response.sendRedirect("shop-details.jsp?product_id=" + productId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=error_processing");
        }
    }

    private void handleAddReview(HttpServletRequest request, HttpServletResponse response, int customerId)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        if (reviewDAO.hasUserReviewed(productId, customerId)) {
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=already_reviewed");
            return;
        }

        Review review = new Review();
        review.setProductId(productId);
        review.setCustomerId(customerId);
        review.setRating(rating);
        review.setComment(comment);

        if (reviewDAO.addReview(review)) {
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&success=added");
        } else {
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=add_failed");
        }
    }

    private void handleEditReview(HttpServletRequest request, HttpServletResponse response, int customerId)
            throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("id"));
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Review existingReview = reviewDAO.getReviewById(reviewId);
        if (existingReview == null || existingReview.getCustomerId() != customerId) {
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=unauthorized");
            return;
        }

        Review review = new Review();
        review.setReviewId(reviewId);
        review.setCustomerId(customerId);
        review.setRating(rating);
        review.setComment(comment);
        review.setProductId(productId);

        if (reviewDAO.updateReview(review)) {
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&success=updated");
        } else {
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=update_failed");
        }
    }

    private void handleDeleteReview(HttpServletRequest request, HttpServletResponse response, int customerId, int productId)
            throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("id"));
        Review review = reviewDAO.getReviewById(reviewId);
        
        if (review == null || review.getCustomerId() != customerId) {
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=unauthorized");
            return;
        }

        if (reviewDAO.deleteReview(reviewId, customerId)) {
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&success=deleted");
        } else {
            response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=delete_failed");
        }
    }

    // Lấy các review của sản phẩm theo productId
    public List<Review> getReviewsByProductId(int productId) {
        return reviewDAO.getReviewsByProductId(productId);
    }
}