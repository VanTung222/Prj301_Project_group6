<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/checkout.css">
    <style>
        .address-details {
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            display: none;
        }
    </style>
    <script>
        function showAddressDetails() {
            const selectedAddressId = document.getElementById("shippingAddressSelect").value;
            // Ẩn tất cả các phần chi tiết địa chỉ
            document.querySelectorAll(".address-details").forEach(div => {
                div.style.display = "none";
            });
            // Hiển thị phần chi tiết của địa chỉ được chọn
            const selectedDetailsDiv = document.getElementById("address-details-" + selectedAddressId);
            if (selectedDetailsDiv) {
                selectedDetailsDiv.style.display = "block";
            }
        }

        function toggleNewAddress() {
            document.getElementById("shippingInfoDisplay").style.display = "none";
            document.getElementById("newAddressForm").style.display = "block";
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Checkout</h2>
        <c:if test="${not empty error}">
            <p style="color: red;">${error}</p>
        </c:if>

        <h3>Order Summary</h3>
        <table>
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty cartItems}">
                        <tr>
                            <td colspan="4">Your cart is empty. <a href="cart.jsp">Go to Cart</a></td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${cartItems}">
                            <tr>
                                <td>${item.product.name}</td>
                                <td>${item.quantity}</td>
                                <td><fmt:formatNumber value="${item.product.price}" type="number" minFractionDigits="2" maxFractionDigits="2" />$</td>
                                <td><fmt:formatNumber value="${item.quantity * item.product.price}" type="number" minFractionDigits="2" maxFractionDigits="2" />$</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div class="cart-total">
            <p>Subtotal: <fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2" />$</p>
            <p>Discount: <fmt:formatNumber value="${discountAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" />$</p>
            <p>Total: <fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2" />$</p>
        </div>

        <h3>Shipping Information</h3>
        <c:choose>
            <c:when test="${hasShippingInfo}">
                <!-- Hiển thị danh sách địa chỉ giao hàng -->
                <div id="shippingInfoDisplay">
                    <form action="CheckoutServlet" method="post">
                        <label>Select Shipping Address:</label>
                        <select id="shippingAddressSelect" name="selectedAddressId" required onchange="showAddressDetails()">
                            <c:forEach var="address" items="${shippingAddresses}">
                                <option value="${address.addressId}">
                                    ${address.firstName != null ? address.firstName : 'N/A'} ${address.lastName != null ? address.lastName : 'N/A'}, 
                                    ${address.address != null ? address.address : 'N/A'}, 
                                    ${address.city != null ? address.city : 'N/A'}, 
                                    ${address.countryState != null ? address.countryState : 'N/A'}, 
                                    ${address.postcode != null ? address.postcode : 'N/A'} 
                                    (Phone: ${address.phone != null ? address.phone : 'N/A'}, Email: ${address.email != null ? address.email : 'N/A'})
                                </option>
                            </c:forEach>
                        </select>

                        <!-- Hiển thị chi tiết địa chỉ đã chọn -->
                        <c:forEach var="address" items="${shippingAddresses}">
                            <div id="address-details-${address.addressId}" class="address-details">
                                <strong>Selected Address Details:</strong><br>
                                Name: ${address.firstName != null ? address.firstName : 'N/A'} ${address.lastName != null ? address.lastName : 'N/A'}<br>
                                Address: ${address.address != null ? address.address : 'N/A'}<br>
                                City: ${address.city != null ? address.city : 'N/A'}<br>
                                Country/State: ${address.countryState != null ? address.countryState : 'N/A'}<br>
                                Postcode: ${address.postcode != null ? address.postcode : 'N/A'}<br>
                                Phone: ${address.phone != null ? address.phone : 'N/A'}<br>
                                Email: ${address.email != null ? address.email : 'N/A'}<br>
                            </div>
                        </c:forEach>

                        <input type="hidden" name="orderNotes" value="">

                        <h3>Payment Method</h3>
                        <input type="radio" name="paymentMethod" value="COD" required> Cash on Delivery (COD)<br>
                        <input type="radio" name="paymentMethod" value="Bank Transfer"> Bank Transfer<br>

                        <button type="button" onclick="toggleNewAddress()">Use New Address</button>
                        <button type="submit">Place Order</button>
                    </form>
                </div>

                <!-- Form nhập địa chỉ mới (ẩn ban đầu) -->
                <div id="newAddressForm" style="display: none;">
                    <form action="CheckoutServlet" method="post">
                        <label>First Name:</label>
                        <input type="text" name="firstName" required><br>
                        <label>Last Name:</label>
                        <input type="text" name="lastName" required><br>
                        <label>Address:</label>
                        <input type="text" name="address" required><br>
                        <label>City:</label>
                        <input type="text" name="city" required><br>
                        <label>Country/State:</label>
                        <input type="text" name="countryState" required><br>
                        <label>Postcode:</label>
                        <input type="text" name="postcode" required><br>
                        <label>Phone:</label>
                        <input type="text" name="phone" required><br>
                        <label>Email:</label>
                        <input type="email" name="email" required><br>
                        <label>Order Notes:</label>
                        <textarea name="orderNotes"></textarea><br>

                        <h3>Payment Method</h3>
                        <input type="radio" name="paymentMethod" value="COD" required> Cash on Delivery (COD)<br>
                        <input type="radio" name="paymentMethod" value="Bank Transfer"> Bank Transfer<br>

                        <button type="submit">Place Order</button>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Form nhập thông tin lần đầu -->
                <form action="CheckoutServlet" method="post">
                    <label>First Name:</label>
                    <input type="text" name="firstName" required><br>
                    <label>Last Name:</label>
                    <input type="text" name="lastName" required><br>
                    <label>Address:</label>
                    <input type="text" name="address" required><br>
                    <label>City:</label>
                    <input type="text" name="city" required><br>
                    <label>Country/State:</label>
                    <input type="text" name="countryState" required><br>
                    <label>Postcode:</label>
                    <input type="text" name="postcode" required><br>
                    <label>Phone:</label>
                    <input type="text" name="phone" required><br>
                    <label>Email:</label>
                    <input type="email" name="email" required><br>
                    <label>Order Notes:</label>
                    <textarea name="orderNotes"></textarea><br>

                    <h3>Payment Method</h3>
                    <input type="radio" name="paymentMethod" value="COD" required> Cash on Delivery (COD)<br>
                    <input type="radio" name="paymentMethod" value="Bank Transfer"> Bank Transfer<br>

                    <button type="submit">Place Order</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Gọi hàm showAddressDetails() khi trang tải để hiển thị chi tiết địa chỉ mặc định -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            showAddressDetails();
        });
    </script>
</body>
</html>