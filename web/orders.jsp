<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            --border-color: #e5e7eb;
            --background-color: #f9fafb;
        }

        body {
            background-color: var(--background-color);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            display: flex;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        .container-fluid {
            display: flex;
            width: 100%;
            margin: 0;
            padding: 0;
        }

        .row {
            display: flex;
            width: 100%;
            margin: 0;
            padding: 0;
        }

        .sidebar {
            width: 250px;
            min-height: 100vh;
            background-color: var(--dark-color);
            padding: 20px;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
        }

        .sidebar .nav-link {
            color: #fff;
            padding: 12px 20px;
            margin: 8px 0;
            border-radius: 5px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .sidebar .nav-link:hover {
            background-color: var(--primary-color);
            transform: translateX(5px);
        }

        .sidebar .nav-link.active {
            background-color: var(--primary-color);
        }

        .main-content {
            flex: 1;
            padding: 32px;
            margin-left: 250px;
            background-color: var(--background-color);
        }

        .content-wrapper {
            background: white;
            border-radius: 24px;
            padding: 32px;
            height: calc(100vh - 64px);
            overflow-y: auto;
        }

        /* Update header styles */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background: white;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .header-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
            margin: 0;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-left: 1.5rem;
            padding-left: 1.5rem;
            border-left: 1px solid #eee;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .user-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .user-name {
            font-size: 0.9rem;
            color: #333;
            font-weight: 500;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #666;
            font-size: 0.85rem;
            text-decoration: none;
            transition: color 0.2s;
        }

        .logout-btn:hover {
            color: #ff4757;
        }

        .logout-btn i {
            font-size: 0.9rem;
        }

        .date-filter select {
            padding: 0.5rem 1rem;
            border: 1px solid #eee;
            border-radius: 6px;
            color: #666;
            font-size: 0.9rem;
            outline: none;
            cursor: pointer;
        }

        .export-btn, .connect-wallet {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border: 1px solid #eee;
            border-radius: 6px;
            background: white;
            color: #666;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .export-btn:hover, .connect-wallet:hover {
            background: #f8f9fa;
            border-color: #ddd;
        }

        .table-container {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            overflow: hidden;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: white;
            padding: 24px;
            border-radius: 16px;
            border: 1px solid var(--border-color);
        }

        .stat-card p {
            color: #6b7280;
            margin: 0 0 8px 0;
            font-size: 14px;
        }

        .stat-card h3 {
            font-size: 32px;
            font-weight: 600;
            margin: 0 0 12px 0;
            color: #111827;
        }

        .stat-card .trend {
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 13px;
        }

        .trend.up {
            color: #22c55e;
        }

        /* Filter Tabs */
        .filter-tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 24px;
            padding: 4px;
            background-color: #f9fafb;
            border-radius: 8px;
            width: fit-content;
        }

        .filter-tabs .tab {
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            color: #6b7280;
            background: transparent;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-tabs .tab.active {
            background: white;
            color: #111827;
            font-weight: 500;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        /* Orders Table */
        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 14px;
        }

        .table th {
            padding: 12px 24px;
            font-weight: 500;
            color: #6b7280;
            background-color: #f9fafb;
            border-bottom: 1px solid var(--border-color);
            text-align: left;
        }

        .table td {
            padding: 16px 24px;
            color: #111827;
            border-bottom: 1px solid var(--border-color);
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
            display: inline-block;
        }

        .status-badge.completed {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .status-badge.processing {
            background-color: #fef9c3;
            color: #ca8a04;
        }

        .status-badge.delivery {
            background-color: #dbeafe;
            color: #2563eb;
        }

        /* Search and Actions */
        .actions-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            gap: 16px;
        }

        /* Pagination */
        .pagination {
            display: flex;
            gap: 4px;
            align-items: center;
            margin-top: 24px;
            justify-content: center;
        }

        .pagination button {
            padding: 8px 12px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            background: white;
            color: #111827;
            font-size: 14px;
            cursor: pointer;
        }

        .pagination button.active {
            background-color: #f3f4f6;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="text-center mb-4">
                <img src="${pageContext.request.contextPath}/img/logo.png" alt="Cake Shop Logo" style="max-width: 150px" />
            </div>
            <nav class="nav flex-column">
                <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                    <i class="fas fa-chart-line"></i>
                    <span>Dashboard</span>
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/ProductServlet22">
                    <i class="fas fa-birthday-cake"></i>
                    <span>Quản lý Bánh</span>
                </a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/adminOrder">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Quản lý Đơn hàng</span>
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/CustomerManagerAd">
                    <i class="fas fa-users"></i>
                    <span>Quản lý Khách hàng</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="content-wrapper">
                <!-- Header -->
                <div class="header">
                    <h2 class="header-title">Orders</h2>
                    <div class="header-actions">
                        <div class="user-profile">
                            <c:choose>
                                <c:when test="${not empty admin and not empty admin.profilePicture}">
                                    <img src="${admin.profilePicture}" alt="Admin Avatar" class="avatar">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/img/default-avatar.jpg" alt="Admin Avatar" class="avatar">
                                </c:otherwise>
                            </c:choose>
                            <div class="user-info">
                                <span class="user-name">Xin chào, ${sessionScope.username}</span>
                                <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn">
                                    <i class="fas fa-sign-out-alt"></i>
                                    Đăng xuất
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Stats Section -->
                <div class="stats-container">
                    <div class="stat-card">
                        <p>Doanh thu</p>
                        <h5 class="card-title mb-0">
                            <fmt:formatNumber value="${totalRevenue}" type="number" pattern="#,##0.00"/>đ
                        </h5>
                        <div class="trend up">
                            <i class="fas fa-arrow-up"></i>
                            <span>4.3% from last week</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <p>Total customers</p>
                        <h3>${totalCustomers}</h3>
                        <div class="trend up">
                            <i class="fas fa-arrow-up"></i>
                            <span>3.2% from last week</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <p>Total transactions</p>
                        <h3>${totalOrders}</h3>
                        <div class="trend up">
                            <i class="fas fa-arrow-up"></i>
                            <span>2.1% from last week</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <p>Total products</p>
                        <h3>${totalProducts}</h3>
                        <div class="trend up">
                            <i class="fas fa-arrow-up"></i>
                            <span>1.2% from last week</span>
                        </div>
                    </div>
                </div>

                <!-- Orders Table -->
                <div class="table-container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="mb-0">Danh sách đơn hàng</h5>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Payment</th>
                                    <th>Discount Amount</th>
                                    <th>Trạng thái</th>
                                    <th>City</th>
                                    <th>Tổng tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty orders}">
                                        <c:forEach items="${orders}" var="order">
                                            <tr>
                                                <td>#${order.orderId}</td>
                                                <td>${order.shippingFirstName} ${order.shippingLastName}</td>
                                                <td>
                                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td>${order.paymentMethod}</td>
                                                <td>
                                                    <fmt:formatNumber value="${order.discountAmount}" type="number" pattern="#,##0.00"/>đ
                                                </td>
                                                <td>
                                                    <span class="status-badge ${order.status == 'Delivered' ? 'completed' : order.status == 'Processing' ? 'processing' : 'delivery'}">
                                                        ${order.status}
                                                    </span>
                                                </td>
                                                <td>${order.city}</td>
                                                <td>
                                                    <strong><fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,##0.00"/>đ</strong>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8" class="text-center">Không có đơn hàng nào.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
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