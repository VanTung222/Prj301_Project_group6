<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="model.Review" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Customer" %>

<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Cake Template">
    <meta name="keywords" content="Cake, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Write a Review</title>

    <style>
        /* Review Form Styles */
        .review-form {
            background-color: #f8f9fa;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            width: 60%;
            margin: 20px auto;
            max-width: 800px;
            border: 1px solid #ddd;
        }

        .review-form h2 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
            font-weight: 600;
        }

        .review-form .form-group {
            margin-bottom: 25px;
        }

        .review-form label {
            font-weight: 500;
            font-size: 16px;
            color: #444;
            display: block;
            margin-bottom: 10px;
        }

        .review-form select,
        .review-form textarea {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #fff;
            transition: border 0.3s;
        }

        .review-form select:focus,
        .review-form textarea:focus {
            border-color: #007bff;
            outline: none;
        }

        .review-form textarea {
            height: 150px;
            resize: vertical;
        }

        .review-form button {
            padding: 12px 30px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            margin-top: 20px;
            transition: background-color 0.3s;
        }

        .review-form button:hover {
            background-color: #0056b3;
        }

        .review-form p {
            text-align: center;
            font-size: 16px;
            color: #777;
        }

        .review-form a {
            color: #007bff;
            text-decoration: none;
        }

        .review-form a:hover {
            text-decoration: underline;
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
    %>

    <div class="review-form">
        <h2>Write a Review</h2>

        <% 
            // Nếu chưa đăng nhập, hiển thị thông báo và link đến login.jsp
            if (username == null) {
        %>
        <p><a href="login.jsp">Log in</a> to write a review.</p>
        <% 
            } else if (productId != 0) { 
                // Nếu đã đăng nhập và productId hợp lệ, hiển thị form
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(productId);
                if (product != null) {
        %>
        <form action="review" method="post">
            <input type="hidden" name="customer_id" value="<%= customer.getCustomerId() %>">
            <input type="hidden" name="product_id" value="<%= productId %>">

            <!-- Product Info -->
            <p>Reviewing: <strong><%= product.getName() %></strong></p>

            <!-- Rating Section -->
            <div class="form-group">
                <label for="rating">Rating:</label>
                <select name="rating" id="rating" required>
                    <option value="1">1 ⭐</option>
                    <option value="2">2 ⭐⭐</option>
                    <option value="3">3 ⭐⭐⭐</option>
                    <option value="4">4 ⭐⭐⭐⭐</option>
                    <option value="5">5 ⭐⭐⭐⭐⭐</option>
                </select>
            </div>

            <!-- Comment Section -->
            <div class="form-group">
                <label for="comment">Your review:</label>
                <textarea name="comment" id="comment" required></textarea>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary mt-3">Submit Review</button>
        </form>

        <% 
                } else { 
        %>
        <p>Product not found!</p>
        <% 
                } 
            } else { 
        %>
        <p>Invalid product ID!</p>
        <% 
            } 
        %>
    </div>
</body>
</html>