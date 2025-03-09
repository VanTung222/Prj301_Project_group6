<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="model.Product" %>
<%@page import="dao.FavoriteProductDAO" %>
<%@page import="model.Customer" %>

<% 
    HttpSession sess = request.getSession();
    Customer customer = (Customer) sess.getAttribute("customer");
    List<Product> favoriteProducts = new ArrayList<>();

    if (customer != null) {
        FavoriteProductDAO favoriteDAO = new FavoriteProductDAO();
        favoriteProducts = favoriteDAO.getFavoriteProductsWithDetailsByCustomer(customer.getCustomerId());
    } else {
        response.sendRedirect("login.jsp"); // Chuyển hướng nếu chưa đăng nhập
        return;
    }

    if (favoriteProducts == null) {
        favoriteProducts = new ArrayList<>(); // Khởi tạo ArrayList nếu favoriteProducts là null
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách yêu thích</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container my-5">
        <div class="row">
            <div class="col-12">
                <h3 id="tops-section" class="text-center">FAVORITE PRODUCTS</h3>
                <div class="row">
                    <% if (favoriteProducts != null && !favoriteProducts.isEmpty()) { 
                        for (Product p : favoriteProducts) { %>
                            <div class="col-md-3">
                                <div class="card">
                                    <a href="productdetails.jsp?id=<%= p.getProductId() %>">
                                        <img src="<%= p.getProductImg() %>" class="card-img-top" alt="<%= p.getName() %>">
                                    </a>
                                    <div class="card-body text-center">
                                        <h5 class="card-title"><%= p.getName() %></h5>
                                        <p class="card-text">Giá: <%= String.format("%.2f", p.getPrice()) %> $</p>
                                        <p class="card-text"><%= p.getDescription() %></p>
                                        <a href="productdetails.jsp?id=<%= p.getProductId() %>" class="btn btn-primary">Mua ngay</a>
                                    </div>
                                </div>
                            </div>
                    <%  } 
                    } else { %>
                        <p class="text-center">Không có sản phẩm nào trong danh sách yêu thích!</p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <style>
        .col-md-3 {
            padding: 15px; 
        }
    </style>
</body>
</html>