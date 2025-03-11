package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Review;
import dao.ReviewDAO;
import model.Customer;
import java.util.Date;
import dao.CustomerDAO;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/review"})
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            int reviewId = Integer.parseInt(request.getParameter("id"));
            Review review = reviewDAO.getReviewById(reviewId);
            if (review != null) {
                request.setAttribute("review", review);
                request.getRequestDispatcher("review.jsp").forward(request, response);
            } else {
                response.sendRedirect("shop-details.jsp?error=not_found");
            }
        } else {
            response.sendRedirect("shop-details.jsp");
        }
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

        // Lấy customer_id từ database dựa vào username
        Customer customer = customerDAO.getCustomerByUsername(username);
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = customer.getCustomerId();
        
        if ("add".equals(action)) {
            handleAddReview(request, response, customerId);
        } else if ("edit".equals(action)) {
            handleEditReview(request, response, customerId);
        } else if ("delete".equals(action)) {
            handleDeleteReview(request, response, customerId);
        }
    }

    private void handleAddReview(HttpServletRequest request, HttpServletResponse response, int customerId) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            // Kiểm tra xem người dùng đã đánh giá sản phẩm này chưa
            if (reviewDAO.hasUserReviewed(productId, customerId)) {
                response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=duplicate");
                return;
            }

            // Validate input
            if (rating < 1 || rating > 5 || comment == null || comment.trim().length() < 10) {
                response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=invalid");
                return;
            }

            Review review = new Review();
            review.setProductId(productId);
            review.setCustomerId(customerId);
            review.setRating(rating);
            review.setComment(comment.trim());

            if (reviewDAO.addReview(review)) {
                response.sendRedirect("shop-details.jsp?product_id=" + productId + "&success=added");
            } else {
                response.sendRedirect("shop-details.jsp?product_id=" + productId + "&error=failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("shop-details.jsp?error=invalid");
        }
    }

    private void handleEditReview(HttpServletRequest request, HttpServletResponse response, int customerId) 
            throws ServletException, IOException {
        try {
            int reviewId = Integer.parseInt(request.getParameter("id"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            // Validate input
            if (rating < 1 || rating > 5 || comment == null || comment.trim().length() < 10) {
                response.sendRedirect("shop-details.jsp?error=invalid");
                return;
            }

            Review review = new Review();
            review.setReviewId(reviewId);
            review.setCustomerId(customerId);
            review.setRating(rating);
            review.setComment(comment.trim());

            if (reviewDAO.updateReview(review)) {
                response.sendRedirect("shop-details.jsp?success=updated");
            } else {
                response.sendRedirect("shop-details.jsp?error=failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("shop-details.jsp?error=invalid");
        }
    }

    private void handleDeleteReview(HttpServletRequest request, HttpServletResponse response, int customerId) 
            throws ServletException, IOException {
        try {
            int reviewId = Integer.parseInt(request.getParameter("id"));
            
            if (reviewDAO.deleteReview(reviewId, customerId)) {
                response.getWriter().write("success");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    // Lấy các review của sản phẩm theo productId
    public List<Review> getReviewsByProductId(int productId) {
        return reviewDAO.getReviewsByProductId(productId);
    }
}