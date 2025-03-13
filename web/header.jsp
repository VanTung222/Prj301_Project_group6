<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container">
    <a class="navbar-brand" href="home">Cake Shop</a>
    <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#navbarNav"
    >
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="home">Trang chủ</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="products">Sản phẩm</a>
        </li>
      </ul>
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="cart">
            <i class="fas fa-shopping-cart"></i>
            <span class="badge bg-danger">${sessionScope.cartSize}</span>
          </a>
        </li>
        <% if (session != null && session.getAttribute("Customer_ID") != null) {
        %>
        <li class="nav-item">
          <a class="nav-link" href="profile">
            <i class="fas fa-user"></i>
            ${sessionScope.fullName}
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="logout">Đăng xuất</a>
        </li>
        <% } else { %>
        <li class="nav-item">
          <a class="nav-link" href="login.jsp">Đăng nhập</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="register.jsp">Đăng ký</a>
        </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>
