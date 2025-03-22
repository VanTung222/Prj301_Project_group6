<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Checkout</title>
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/style.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/checkout.css"
    />
  </head>
  <body>
    <section class="checkout">
      <div class="container">
        <h2 class="checkout-title">Checkout</h2>
        <c:if test="${not empty error}">
          <p style="color: red">${error}</p>
        </c:if>
        <div class="row">
          <!-- Danh sách sản phẩm trong giỏ hàng -->
          <div class="col-lg-6">
            <h3>Your Cart</h3>
            <c:choose>
              <c:when test="${empty cartItems}">
                <p>
                  Your cart is currently empty.
                  <a href="cart.jsp">Go to Cart</a>
                </p>
              </c:when>
              <c:otherwise>
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
                    <tbody>
                      <c:forEach var="item" items="${cartItems}">
                        <tr>
                          <td>${item.product.name}</td>
                          <td>${item.quantity}</td>
                          <td>
                            <fmt:formatNumber
                              value="${item.product.price}"
                              type="currency"
                              currencySymbol="$"
                            />
                          </td>
                          <td>
                            <fmt:formatNumber
                              value="${item.product.price * item.quantity}"
                              type="currency"
                              currencySymbol="$"
                            />
                          </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                  <h4>
                    Total:
                    <fmt:formatNumber
                      value="${total}"
                      type="currency"
                      currencySymbol="$"
                    />
                  </h4>
                </div>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- Form thông tin giao hàng -->
          <div class="col-lg-6">
            <h3>Shipping Information</h3>
            <form action="CheckoutServlet" method="POST">
              <div class="form-group">
                <label>First Name *</label>
                <input
                  type="text"
                  name="firstName"
                  value="${shippingInfo.firstName}"
                  required
                />
              </div>
              <div class="form-group">
                <label>Last Name *</label>
                <input
                  type="text"
                  name="lastName"
                  value="${shippingInfo.lastName}"
                  required
                />
              </div>
              <div class="form-group">
                <label>Address *</label>
                <input
                  type="text"
                  name="address"
                  value="${shippingInfo.address}"
                  required
                />
              </div>
              <div class="form-group">
                <label>City *</label>
                <input
                  type="text"
                  name="city"
                  value="${shippingInfo.city}"
                  required
                />
              </div>
              <div class="form-group">
                <label>Country/State *</label>
                <input
                  type="text"
                  name="countryState"
                  value="${shippingInfo.countryState}"
                  required
                />
              </div>
              <div class="form-group">
                <label>Postcode *</label>
                <input
                  type="text"
                  name="postcode"
                  value="${shippingInfo.postcode}"
                  required
                />
              </div>
              <div class="form-group">
                <label>Phone *</label>
                <input
                  type="text"
                  name="phone"
                  value="${shippingInfo.phone}"
                  required
                />
              </div>
              <div class="form-group">
                <label>Email *</label>
                <input
                  type="email"
                  name="email"
                  value="${shippingInfo.email}"
                  required
                />
              </div>
              <div class="form-group">
                <label>Order Notes</label>
                <textarea name="orderNotes"></textarea>
              </div>
              <div class="form-group">
                <label>Payment Method *</label>
                <select name="paymentMethod" required>
                  <option value="Bank Transfer">Chuyển khoản</option>
                  <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                </select>
              </div>
              <button type="submit" class="primary-btn">Place Order</button>
            </form>
          </div>
        </div>
      </div>
    </section>
  </body>
</html>
