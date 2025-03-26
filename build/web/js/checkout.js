<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="css/style.css"> <!-- Điều chỉnh theo CSS của bạn -->
</head>
<body>
    <section class="checkout">
        <div class="container">
            <h2 class="checkout-title">Checkout</h2>
            <div class="row">
                <!-- Danh sách sản phẩm trong giỏ hàng -->
                <div class="col-lg-6">
                    <h3>Your Cart</h3>
                    <div class="cart-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody id="cart-items"></tbody>
                        </table>
                        <h4>Total: <span id="cart-total">$0.00</span></h4>
                    </div>
                </div>

                <!-- Form thông tin giao hàng -->
                <div class="col-lg-6">
                    <h3>Shipping Information</h3>
                    <form id="checkout-form" action="CheckoutServlet" method="POST">
                        <div class="form-group">
                            <label>First Name *</label>
                            <input type="text" name="firstName" id="firstName" required>
                        </div>
                        <div class="form-group">
                            <label>Last Name *</label>
                            <input type="text" name="lastName" id="lastName" required>
                        </div>
                        <div class="form-group">
                            <label>Address *</label>
                            <input type="text" name="address" id="address" required>
                        </div>
                        <div class="form-group">
                            <label>City *</label>
                            <input type="text" name="city" id="city" required>
                        </div>
                        <div class="form-group">
                            <label>Country/State *</label>
                            <input type="text" name="countryState" id="countryState" required>
                        </div>
                        <div class="form-group">
                            <label>Postcode *</label>
                            <input type="text" name="postcode" id="postcode" required>
                        </div>
                        <div class="form-group">
                            <label>Phone *</label>
                            <input type="text" name="phone" id="phone" required>
                        </div>
                        <div class="form-group">
                            <label>Email *</label>
                            <input type="email" name="email" id="email" required>
                        </div>
                        <div class="form-group">
                            <label>Order Notes</label>
                            <textarea name="orderNotes" id="orderNotes"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Payment Method *</label>
                            <select name="paymentMethod" required>
                                <option value="Credit Card">Credit Card</option>
                                <option value="Cash on Delivery">Cash on Delivery</option>
                            </select>
                        </div>
                        <button type="submit" class="primary-btn">Place Order</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            fetch("CartServlet")
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        alert(data.error);
                        window.location.href = "login.jsp";
                    } else {
                        renderCart(data.cart);
                        document.getElementById("cart-total").textContent = `$${parseFloat(data.total).toFixed(2)}`;
                        fetchUserInfo();
                    }
                })
                .catch(error => console.error("Error fetching cart:", error));
        });

        function renderCart(cart) {
            const cartItems = document.getElementById("cart-items");
            cartItems.innerHTML = "";
            cart.forEach(item => {
                const total = (item.price * item.quantity).toFixed(2); // Tính tổng trong JavaScript
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${item.name}</td>
                    <td>${item.quantity}</td>
                    <td>$${parseFloat(item.price).toFixed(2)}</td>
                    <td>$${total}</td>
                `;
                cartItems.appendChild(row);
            });
        }

        function fetchUserInfo() {
            fetch("CheckoutServlet?action=getUserInfo")
                .then(response => response.json())
                .then(data => {
                    if (!data.error) {
                        document.getElementById("firstName").value = data.firstName || "";
                        document.getElementById("lastName").value = data.lastName || "";
                        document.getElementById("address").value = data.address || "";
                        document.getElementById("city").value = data.city || "";
                        document.getElementById("countryState").value = data.countryState || "";
                        document.getElementById("postcode").value = data.postcode || "";
                        document.getElementById("phone").value = data.phone || "";
                        document.getElementById("email").value = data.email || "";
                    }
                })
                .catch(error => console.error("Error fetching user info:", error));
        }
    </script>
</body>
</html>