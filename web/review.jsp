<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="model.Review" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Customer" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Cake Template">
    <meta name="keywords" content="Cake, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Product Reviews</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/flaticon.css" type="text/css">
    <link rel="stylesheet" href="css/barfiller.css" type="text/css">
    <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">

    <style>
        .review-section {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .review-form {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }

        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
        }

        .rating > input {
            display: none;
        }

        .rating > label {
            position: relative;
            width: 1.1em;
            font-size: 30px;
            color: #FFD700;
            cursor: pointer;
        }

        .rating > label::before {
            content: "★";
            position: absolute;
            opacity: 0;
        }

        .rating > label:hover:before,
        .rating > label:hover ~ label:before {
            opacity: 1 !important;
        }

        .rating > input:checked ~ label:before {
            opacity: 1;
        }

        .reviews-list {
            margin-top: 40px;
        }

        .review-item {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .review-meta {
            font-size: 0.9em;
            color: #666;
        }

        .star-rating {
            color: #FFD700;
            font-size: 1.2em;
        }

        .review-actions {
            margin-top: 10px;
        }

        .review-actions button {
            margin-left: 10px;
            padding: 5px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .edit-btn {
            background-color: #4CAF50;
            color: white;
        }

        .delete-btn {
            background-color: #f44336;
            color: white;
        }

        .average-rating {
            text-align: center;
            margin-bottom: 30px;
        }

        .average-rating .rating-number {
            font-size: 48px;
            font-weight: bold;
            color: #333;
        }

        .average-rating .stars {
            font-size: 24px;
            color: #FFD700;
            margin: 10px 0;
        }

        .rating-distribution {
            margin: 20px 0;
        }

        .rating-bar {
            display: flex;
            align-items: center;
            margin: 5px 0;
        }

        .rating-label {
            min-width: 60px;
        }

        .progress {
            flex-grow: 1;
            height: 20px;
            margin: 0 10px;
            background-color: #f0f0f0;
            border-radius: 10px;
        }

        .progress-bar {
            height: 100%;
            background-color: #FFD700;
            border-radius: 10px;
        }

        .rating-count {
            min-width: 50px;
            text-align: right;
        }
    </style>
</head>
<body>
    <%
        Customer customer = (Customer) session.getAttribute("customer");
        String username = (customer != null) ? customer.getUsername() : null;
        String productIdParam = request.getParameter("product_id");
        int productId = 0;
        
        if (productIdParam != null && !productIdParam.trim().isEmpty()) {
            try {
                productId = Integer.parseInt(productIdParam);
            } catch (NumberFormatException e) {
                productId = 0;
            }
        }

        ProductDAO productDAO = new ProductDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        Product product = null;
        List<Review> reviews = null;
        double averageRating = 0;
        int[] ratingDistribution = new int[5];

        if (productId != 0) {
            product = productDAO.getProductById(productId);
            if (product != null) {
                reviews = reviewDAO.getReviewsByProductId(productId);
                // Calculate average rating and distribution
                if (reviews != null && !reviews.isEmpty()) {
                    int totalRating = 0;
                    for (Review review : reviews) {
                        totalRating += review.getRating();
                        ratingDistribution[review.getRating() - 1]++;
                    }
                    averageRating = (double) totalRating / reviews.size();
                }
            }
        }
    %>

    <div class="review-section">
        <% if (product != null) { %>
            <h2 class="text-center mb-4">Reviews for <%= product.getName() %></h2>

            <!-- Average Rating Section -->
            <div class="average-rating">
                <div class="rating-number"><%= String.format("%.1f", averageRating) %></div>
                <div class="stars">
                    <% for (int i = 0; i < 5; i++) { %>
                        <% if (i < Math.round(averageRating)) { %>
                            ★
                        <% } else { %>
                            ☆
                        <% } %>
                    <% } %>
                </div>
                <div>Based on <%= reviews != null ? reviews.size() : 0 %> reviews</div>

                <!-- Rating Distribution -->
                <div class="rating-distribution">
                    <% for (int i = 4; i >= 0; i--) { %>
                        <div class="rating-bar">
                            <span class="rating-label"><%= i + 1 %> stars</span>
                            <div class="progress">
                                <div class="progress-bar" style="width: <%= reviews != null && reviews.size() > 0 ? (ratingDistribution[i] * 100 / reviews.size()) : 0 %>%"></div>
                            </div>
                            <span class="rating-count"><%= ratingDistribution[i] %></span>
                        </div>
                    <% } %>
                </div>
            </div>

            <!-- Review Form -->
            <% if (username != null) { %>
                <div class="review-form">
                    <h3>Write a Review</h3>
                    <form action="review" method="post" onsubmit="return validateForm()">
                        <input type="hidden" name="customer_id" value="<%= customer.getCustomerId() %>">
                        <input type="hidden" name="product_id" value="<%= productId %>">

                        <div class="form-group">
                            <label>Your Rating</label>
                            <div class="rating">
                                <input type="radio" id="star5" name="rating" value="5" required/>
                                <label for="star5" title="5 stars">★</label>
                                <input type="radio" id="star4" name="rating" value="4"/>
                                <label for="star4" title="4 stars">★</label>
                                <input type="radio" id="star3" name="rating" value="3"/>
                                <label for="star3" title="3 stars">★</label>
                                <input type="radio" id="star2" name="rating" value="2"/>
                                <label for="star2" title="2 stars">★</label>
                                <input type="radio" id="star1" name="rating" value="1"/>
                                <label for="star1" title="1 star">★</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="comment">Your Review</label>
                            <textarea class="form-control" name="comment" id="comment" rows="4" required 
                                    minlength="10" maxlength="1000" placeholder="Write your review here (minimum 10 characters)"></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Submit Review</button>
                    </form>
                </div>
            <% } else { %>
                <div class="alert alert-info text-center">
                    Please <a href="login.jsp">log in</a> to write a review.
                </div>
            <% } %>

            <!-- Reviews List -->
            <div class="reviews-list">
                <h3>Customer Reviews</h3>
                <% if (reviews != null && !reviews.isEmpty()) { %>
                    <% for (Review review : reviews) { %>
                        <div class="review-item">
                            <div class="review-header">
                                <div class="review-meta">
                                    <strong><%= review.getCustomerName() %></strong>
                                    <span class="text-muted">- <%= new SimpleDateFormat("MMM dd, yyyy").format(review.getReviewDate()) %></span>
                                </div>
                                <div class="star-rating">
                                    <% for (int i = 0; i < review.getRating(); i++) { %>★<% } %>
                                    <% for (int i = review.getRating(); i < 5; i++) { %>☆<% } %>
                                </div>
                            </div>
                            <div class="review-content">
                                <%= review.getComment() %>
                            </div>
                            <% if (customer != null && customer.getCustomerId() == review.getCustomerId()) { %>
                                <div class="review-actions">
                                    <button class="edit-btn" onclick="editReview(<%= review.getReviewId() %>)">Edit</button>
                                    <button class="delete-btn" onclick="deleteReview(<%= review.getReviewId() %>)">Delete</button>
                                </div>
                            <% } %>
                        </div>
                    <% } %>
                <% } else { %>
                    <p class="text-center">No reviews yet. Be the first to review this product!</p>
                <% } %>
            </div>
        <% } else { %>
            <div class="alert alert-danger">Product not found!</div>
        <% } %>
    </div>

    <!-- Js Plugins -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery.barfiller.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.nicescroll.min.js"></script>
    <script src="js/main.js"></script>

    <script>
        function validateForm() {
            var comment = document.getElementById('comment').value;
            if (comment.length < 10) {
                alert('Your review must be at least 10 characters long.');
                return false;
            }
            return true;
        }

        function editReview(reviewId) {
            // Implement edit functionality
            if (confirm('Do you want to edit this review?')) {
                window.location.href = 'editReview?id=' + reviewId;
            }
        }

        function deleteReview(reviewId) {
            if (confirm('Are you sure you want to delete this review?')) {
                fetch('review?action=delete&id=' + reviewId, {
                    method: 'POST'
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        alert('Error deleting review');
                    }
                });
            }
        }
    </script>
</body>
</html>