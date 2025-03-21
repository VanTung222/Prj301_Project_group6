<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản lý Đơn hàng - Cake Shop</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #f08632;
            --secondary-color: #cf6f29;
            --dark-color: #343a40;
        }
        .sidebar {
            min-height: 100vh;
            background-color: var(--dark-color);
            padding-top: 20px;
        }
        .sidebar .nav-link {
            color: #fff;
            padding: 12px 20px;
            margin: 8px 0;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .sidebar .nav-link:hover {
            background-color: var(--primary-color);
            transform: translateX(5px);
        }
        .sidebar .nav-link.active {
            background-color: var(--primary-color);
        }
        .main-content {
            padding: 20px;
            background-color: #f8f9fa;
        }
        .user-info {
            background: white;
            padding: 10px 20px;
            border-radius: 30px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="text-center mb-4">
                    <img src="${pageContext.request.contextPath}/img/logo.png" alt="Cake Shop Logo" style="max-width: 150px" />
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                            <i class="fas fa-chart-line me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ProductServlet22">
                            <i class="fas fa-birthday-cake me-2"></i> Quản lý Bánh
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/adminOrder">
                            <i class="fas fa-shopping-cart me-2"></i> Quản lý Đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/customers.jsp">
                            <i class="fas fa-users me-2"></i> Quản lý Khách hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin-reports">
                            <i class="fas fa-chart-bar me-2"></i> Báo cáo & Thống kê
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Quản lý Đơn hàng</h2>
                    <div class="user-info">
                        <span class="me-3">Xin chào, ${sessionScope.username}</span>
                        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-outline-danger btn-sm">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </div>
                </div>

                <!-- Orders Table -->
                <div class="table-container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="mb-0">Danh sách đơn hàng</h5>
                        <a href="#" class="btn btn-primary btn-sm">
                            Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                    <p>Debug: Số lượng đơn hàng: ${orders != null ? orders.size() : 0}</p>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Order> orders = (List<Order>) request.getAttribute("orders");
                                    if (orders != null && !orders.isEmpty()) {
                                        for (Order order : orders) {
                                %>
                                <tr>
                                    <td>#<%= order.getOrderId() %></td>
                                    <td><%= order.getCustomerId() %></td>
                                    <td><%= order.getOrderDate() %></td>
                                    <td><strong><%= order.getTotalAmount() %>đ</strong></td>
                                    <td>
                                        <span class="badge bg-<%= order.getStatus().equals("Hoàn thành") ? "success" : order.getStatus().equals("Đang xử lý") ? "warning" : "danger" %>">
                                            <%= order.getStatus() %>
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/orders?action=edit&id=<%= order.getOrderId() %>" class="btn btn-sm btn-primary me-2">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/orders?action=delete&id=<%= order.getOrderId() %>" class="btn btn-sm btn-danger">
                                            <i class="fas fa-trash-alt"></i> Xoá
                                        </a>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center">Không có đơn hàng nào.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>