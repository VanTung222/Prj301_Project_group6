<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm - Cake Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-card {
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .product-card:hover {
            transform: scale(1.05);
        }
        .product-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="container py-4">
        <h2 class="text-center mb-4">Danh sách sản phẩm</h2>
        <div class="row g-4">
            <c:forEach var="product" items="${products}">
                <div class="col-md-4 col-lg-3">
                    <div class="card product-card">
                        <img src="${product.image}" alt="${product.name}" class="product-img">
                        <div class="card-body text-center">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="text-muted">${product.description}</p>
                            <h6 class="text-danger">${product.price} VNĐ</h6>
                            <button class="btn btn-primary">Mua ngay</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
