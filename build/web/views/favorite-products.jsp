<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Favorite Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .favorite-product {
            transition: transform 0.3s ease;
        }
        .favorite-product:hover {
            transform: translateY(-5px);
        }
        .remove-favorite {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 50%;
            padding: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .remove-favorite:hover {
            background: #dc3545;
            color: white;
        }
        .product-img {
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp"/>

    <div class="container my-5">
        <h2 class="text-center mb-4">My Favorite Products</h2>
        
        <c:if test="${empty favorites}">
            <div class="text-center">
                <p class="lead">You haven't added any products to your favorites yet.</p>
                <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
                    Browse Products
                </a>
            </div>
        </c:if>
        
        <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
            <c:forEach items="${favorites}" var="favorite">
                <div class="col">
                    <div class="card h-100 favorite-product">
                        <div class="remove-favorite" onclick="removeFavorite(${favorite.product.productId})">
                            <i class="fas fa-times"></i>
                        </div>
                        <img src="${pageContext.request.contextPath}/${favorite.product.productImg}" 
                             class="card-img-top product-img" alt="${favorite.product.name}">
                        <div class="card-body">
                            <h5 class="card-title">${favorite.product.name}</h5>
                            <p class="card-text">$${favorite.product.price}</p>
                            <p class="card-text small text-muted">
                                ${favorite.product.productDescription}
                            </p>
                            <a href="${pageContext.request.contextPath}/product?id=${favorite.product.productId}" 
                               class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function removeFavorite(productId) {
            if (confirm('Are you sure you want to remove this product from favorites?')) {
                fetch('${pageContext.request.contextPath}/favorite/remove', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'productId=' + productId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Reload the page to show updated favorites
                        window.location.reload();
                    } else {
                        alert('Failed to remove product from favorites');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while removing the product from favorites');
                });
            }
        }
    </script>
</body>
</html> 