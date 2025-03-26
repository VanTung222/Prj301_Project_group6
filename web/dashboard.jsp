<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard - Cake Shop</title>
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

        /* Header styles (copied from order.jsp) */
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

        /* Other styles from dashboard.jsp (kept as is) */
        .stat-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            background: white;
            padding: 20px;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .stat-card .icon {
            font-size: 2rem;
            color: var(--primary-color);
        }

        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .table-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .badge-success {
            background-color: #28a745;
        }

        .badge-warning {
            background-color: #ffc107;
        }

        .badge-danger {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="text-center mb-4">
                    <img src="${pageContext.request.contextPath}/img/logo.png" alt="Cake Shop Logo" style="max-width: 150px" />
                </div>
                <nav class="nav flex-column">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/ProductServlet22">
                        <i class="fas fa-birthday-cake"></i>
                        <span>Quản lý Bánh</span>
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/adminOrder">
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
                    <!-- Header (updated to match order.jsp) -->
                    <div class="header">
                        <h2 class="header-title">Dashboard</h2>
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

                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="stat-card">
                                <div class="d-flex align-items-center">
                                    <div class="icon me-3">
                                        <i class="fas fa-dollar-sign"></i>
                                    </div>
                                    <div>
                                        <h6 class="card-subtitle mb-2 text-muted">Doanh thu</h6>
                                        <h5 class="card-title mb-0">
                                            <fmt:formatNumber value="${totalRevenue}" type="number" pattern="#,##0.00"/>đ
                                        </h5>
                                        <small class="text-success">
                                            <i class="fas fa-arrow-up"></i> 12% so với tháng trước
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-card">
                                <div class="d-flex align-items-center">
                                    <div class="icon me-3">
                                        <i class="fas fa-shopping-bag"></i>
                                    </div>
                                    <div>
                                        <h6 class="card-subtitle mb-2 text-muted">Đơn hàng</h6>
                                        <h5 class="card-title mb-0">${totalOrders}</h5>
                                        <small class="text-success">
                                            <i class="fas fa-arrow-up"></i> ${totalOrders} đơn hàng mới
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-card">
                                <div class="d-flex align-items-center">
                                    <div class="icon me-3">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <div>
                                        <h6 class="card-subtitle mb-2 text-muted">Khách hàng</h6>
                                        <h5 class="card-title mb-0">${totalCustomers}</h5>
                                        <small class="text-success">
                                            <i class="fas fa-arrow-up"></i> ${totalCustomers} khách hàng mới
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-card">
                                <div class="d-flex align-items-center">
                                    <div class="icon me-3">
                                        <i class="fas fa-birthday-cake"></i>
                                    </div>
                                    <div>
                                        <h6 class="card-subtitle mb-2 text-muted">Sản phẩm</h6>
                                        <h5 class="card-title mb-0">${totalProducts}</h5>
                                        <small class="text-danger">
                                            <i class="fas fa-exclamation-circle"></i>
                                            <c:if test="${lowStockItems > 0}">
                                                ${lowStockItems} sắp hết
                                            </c:if>
                                            <c:if test="${lowStockItems == 0}">
                                                Không có sản phẩm sắp hết
                                            </c:if>
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Charts -->
                    <div class="row mb-4">
                        <div class="col-md-8">
                            <div class="chart-container">
                                <h5 class="mb-4">Doanh thu theo tuần trong tháng</h5>
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="chart-container">
                                <h5 class="mb-4">Phân bố đơn hàng theo ngày</h5>
                                <canvas id="ordersLineChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Orders Table -->
                    <div class="table-container">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="mb-0">Đơn hàng gần đây</h5>
                            <a href="${pageContext.request.contextPath}/adminOrder" class="btn btn-primary btn-sm">
                                Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
                            </a>
                        </div>
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
                                    <c:forEach items="${recentOrders}" var="order">
                                        <tr>
                                            <td>#${order.orderId}</td>
                                            <td>${order.shippingFirstName} ${order.shippingLastName}</td>
                                            <td>
                                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,##0.00"/>đ
                                            </td>
                                            <td>
                                                <span class="badge bg-${order.status == 'Delivered' ? 'success' : order.status == 'Processing' ? 'warning' : 'danger'}">
                                                    ${order.status}
                                                </span>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/adminOrder?id=${order.orderId}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Initialize Charts -->
    <script>
        // Revenue Chart (Doanh thu theo tuần trong tháng)
        const revenueCtx = document.getElementById("revenueChart").getContext("2d");
        new Chart(revenueCtx, {
            type: "bar",
            data: {
                labels: [
                    <c:forEach items="${revenueByWeekInMonth}" var="entry" varStatus="loop">
                        "T${entry.key.substring(5, 7)} - Tuần ${entry.key.substring(8)}"${loop.last ? '' : ','}
                    </c:forEach>
                ],
                datasets: [{
                    label: "Doanh thu (đ)",
                    data: [
                        <c:forEach items="${revenueByWeekInMonth}" var="entry" varStatus="loop">
                            ${entry.value}${loop.last ? '' : ','}
                        </c:forEach>
                    ],
                    backgroundColor: "#f08632",
                    borderColor: "#cf6f29",
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: "Doanh thu (đ)"
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: "Tháng - Tuần"
                        }
                    }
                }
            }
        });

        // Orders Line Chart (Phân bố đơn hàng theo ngày)
        const ordersCtx = document.getElementById("ordersLineChart").getContext("2d");
        new Chart(ordersCtx, {
            type: "line",
            data: {
                labels: [
                    <c:forEach items="${ordersByDate}" var="entry" varStatus="loop">
                        "Ngày ${entry.key.substring(8)}"${loop.last ? '' : ','}
                    </c:forEach>
                ],
                datasets: [{
                    label: "Số lượng đơn hàng",
                    data: [
                        <c:forEach items="${ordersByDate}" var="entry" varStatus="loop">
                            ${entry.value}${loop.last ? '' : ','}
                        </c:forEach>
                    ],
                    backgroundColor: "rgba(40, 167, 69, 0.2)",
                    borderColor: "#28a745",
                    borderWidth: 2,
                    fill: false
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: "bottom"
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: "Số lượng đơn hàng"
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: "Ngày"
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>