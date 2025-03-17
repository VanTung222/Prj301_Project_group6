<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Shopping Cart - Cake Shop</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="includes/navbar.jsp"></jsp:include>
        
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shopping Cart</h1>
                    <p class="lead fw-normal text-white-50 mb-0">Review your items</p>
                </div>
            </div>
        </header>
        
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Your Cart Items</h5>
                                <c:if test="${empty sessionScope.cart}">
                                    <p class="text-center">Your cart is empty</p>
                                </c:if>
                                <c:if test="${not empty sessionScope.cart}">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Product</th>
                                                    <th>Price</th>
                                                    <th>Quantity</th>
                                                    <th>Total</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${sessionScope.cart}" var="item">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="${item.product.image}" alt="${item.product.name}" 
                                                                     class="img-thumbnail" style="width: 80px; height: 80px; object-fit: cover;">
                                                                <div class="ms-3">
                                                                    <h6 class="mb-0">${item.product.name}</h6>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="$"/>
                                                        </td>
                                                        <td>
                                                            <div class="input-group" style="width: 120px;">
                                                                <button class="btn btn-outline-secondary btn-sm" type="button" 
                                                                        onclick="updateQuantity(${item.product.id}, ${item.quantity - 1})">-</button>
                                                                <input type="number" class="form-control form-control-sm text-center" 
                                                                       value="${item.quantity}" readonly>
                                                                <button class="btn btn-outline-secondary btn-sm" type="button"
                                                                        onclick="updateQuantity(${item.product.id}, ${item.quantity + 1})">+</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="$"/>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-danger btn-sm" 
                                                                    onclick="removeFromCart(${item.product.id})">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Order Summary</h5>
                                <c:set var="total" value="0"/>
                                <c:forEach items="${sessionScope.cart}" var="item">
                                    <c:set var="total" value="${total + item.totalPrice}"/>
                                </c:forEach>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Subtotal:</span>
                                    <span><fmt:formatNumber value="${total}" type="currency" currencySymbol="$"/></span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Shipping:</span>
                                    <span>Free</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between mb-3">
                                    <strong>Total:</strong>
                                    <strong><fmt:formatNumber value="${total}" type="currency" currencySymbol="$"/></strong>
                                </div>
                                <a href="checkout.jsp" class="btn btn-primary w-100">Proceed to Checkout</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Footer-->
        <jsp:include page="includes/footer.jsp"></jsp:include>
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        
        <script>
            function updateQuantity(productId, newQuantity) {
                if (newQuantity < 1) return;
                
                fetch('cart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `action=update&productId=${productId}&quantity=${newQuantity}`
                })
                .then(response => response.text())
                .then(result => {
                    if (result === 'success') {
                        location.reload();
                    }
                });
            }
            
            function removeFromCart(productId) {
                if (confirm('Are you sure you want to remove this item from your cart?')) {
                    fetch('cart', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `action=remove&productId=${productId}`
                    })
                    .then(response => response.text())
                    .then(result => {
                        if (result === 'success') {
                            location.reload();
                        }
                    });
                }
            }
        </script>
    </body>
</html> 