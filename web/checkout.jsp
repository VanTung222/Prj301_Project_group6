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
        body {
            background-color: #f8f8f8;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h2 {
            color: #F4833B;
            text-align: center;
            font-size: 32px;
            margin-bottom: 30px;
            position: relative;
        }

        h2:after {
            content: '';
            display: block;
            width: 60px;
            height: 3px;
            background: #F4833B;
            margin: 15px auto;
        }

        .address-details {
            margin-top: 15px;
            padding: 15px;
            border: 1px solid #FFE4D6;
            background-color: #FFF9F5;
            border-radius: 8px;
            display: none;
            line-height: 1.6;
        }

        /* CSS cho phần Shipping Information */
        .shipping-section {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(244, 131, 59, 0.1);
            margin: 20px 0;
            border: 1px solid #FFE4D6;
        }

        .shipping-section h3 {
            color: #F4833B;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #FFE4D6;
            font-size: 24px;
        }

        .shipping-section select {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 2px solid #FFE4D6;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .shipping-section select:focus {
            border-color: #F4833B;
            outline: none;
            box-shadow: 0 0 0 3px rgba(244, 131, 59, 0.1);
        }

        .shipping-section label {
            display: block;
            margin: 12px 0 8px;
            color: #444;
            font-weight: 500;
            font-size: 15px;
        }

        .shipping-section input[type="text"],
        .shipping-section input[type="email"],
        .shipping-section textarea {
            width: 100%;
            padding: 12px;
            margin: 8px 0 20px;
            border: 2px solid #FFE4D6;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .shipping-section input[type="text"]:focus,
        .shipping-section input[type="email"]:focus,
        .shipping-section textarea:focus {
            border-color: #F4833B;
            outline: none;
            box-shadow: 0 0 0 3px rgba(244, 131, 59, 0.1);
        }

        .shipping-section textarea {
            height: 120px;
            resize: vertical;
        }

        /* CSS cho phần Payment Method */
        .payment-section {
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(244, 131, 59, 0.1);
            margin: 25px 0;
            border: 1px solid #FFE4D6;
        }

        .payment-section h3 {
            color: #F4833B;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #FFE4D6;
            font-size: 24px;
        }

        .payment-option {
            display: flex;
            align-items: center;
            margin: 15px 0;
            padding: 15px;
            border: 2px solid #FFE4D6;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .payment-option:hover {
            background-color: #FFF9F5;
            border-color: #F4833B;
            transform: translateY(-2px);
        }

        .payment-option input[type="radio"] {
            margin-right: 15px;
            width: 20px;
            height: 20px;
            accent-color: #F4833B;
        }

        .payment-option label {
            color: #444;
            font-size: 16px;
            font-weight: 500;
        }

        /* CSS cho nút bấm */
        .shipping-section button,
        .payment-section button {
            background-color: #F4833B;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin: 10px 10px 10px 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .shipping-section button:hover,
        .payment-section button:hover {
            background-color: #E67732;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(244, 131, 59, 0.2);
        }

        /* CSS cho form mới */
        #newAddressForm {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(244, 131, 59, 0.1);
            margin-top: 25px;
            border: 1px solid #FFE4D6;
        }

        /* CSS cho bảng Order Summary */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(244, 131, 59, 0.1);
        }

        th {
            background-color: #F4833B;
            color: white;
            padding: 15px;
            text-align: left;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #FFE4D6;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: #FFF9F5;
        }

        .cart-total {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin: 20px 0;
            box-shadow: 0 4px 6px rgba(244, 131, 59, 0.1);
            border: 1px solid #FFE4D6;
        }

        .cart-total p {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
            font-size: 16px;
            color: #444;
        }

        .cart-total p:last-child {
            font-weight: bold;
            color: #F4833B;
            font-size: 20px;
            border-top: 2px solid #FFE4D6;
            padding-top: 10px;
            margin-top: 10px;
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
                <div id="shippingInfoDisplay" class="shipping-section">
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
                        <div class="payment-section">
                            <div class="payment-option">
                                <input type="radio" name="paymentMethod" value="COD" required>
                                <label>Cash on Delivery (COD)</label>
                            </div>
                            <div class="payment-option">
                                <input type="radio" name="paymentMethod" value="Bank Transfer">
                                <label>Bank Transfer</label>
                            </div>
                        </div>

                        <button type="button" onclick="toggleNewAddress()">Use New Address</button>
                        <button type="submit">Place Order</button>
                    </form>
                </div>

                <!-- Form nhập địa chỉ mới (ẩn ban đầu) -->
                <div id="newAddressForm" style="display: none;" class="shipping-section">
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
                        <div class="payment-section">
                            <div class="payment-option">
                                <input type="radio" name="paymentMethod" value="COD" required>
                                <label>Cash on Delivery (COD)</label>
                            </div>
                            <div class="payment-option">
                                <input type="radio" name="paymentMethod" value="Bank Transfer">
                                <label>Bank Transfer</label>
                            </div>
                        </div>

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