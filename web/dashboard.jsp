
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard - Cake Shop</title>
    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <!-- Font Awesome -->
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
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
      .stat-card {
        border: none;
        border-radius: 15px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s, box-shadow 0.3s;
        background: white;
      }
      .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
      }
      .stat-card .icon {
        font-size: 2.5rem;
        color: var(--primary-color);
      }
      .chart-container {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
    </style>
  </head>
  <body>
    <div class="container-fluid">
      <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 sidebar">
          <div class="text-center mb-4">
            <img
              src="img/logo.png"
              alt="Cake Shop Logo"
              style="max-width: 150px"
            />
          </div>
          <ul class="nav flex-column">
            <li class="nav-item">
              <a class="nav-link active" href="dashboard.jsp">
                <i class="fas fa-chart-line me-2"></i> Dashboard
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="ProductServlet22">
                <i class="fas fa-birthday-cake me-2"></i> Quản lý Bánh
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="admin-orders">
                <i class="fas fa-shopping-cart me-2"></i> Quản lý Đơn hàng
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="CustomerManagerAd">
                <i class="fas fa-users me-2"></i> Quản lý Khách hàng
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="admin-reports">
                <i class="fas fa-chart-bar me-2"></i> Báo cáo & Thống kê
              </a>
            </li>
          </ul>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 main-content">
          <!-- Header -->
          <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Dashboard</h2>
            <div class="user-info">
              <span class="me-3">Xin chào, ${sessionScope.username}</span>
              <a href="LogoutServlet" class="btn btn-outline-danger btn-sm">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
              </a>
            </div>
          </div>

          <!-- Statistics Cards -->
          <div class="row mb-4">
            <div class="col-md-3">
              <div class="card stat-card">
                <div class="card-body">
                  <div
                    class="d-flex justify-content-between align-items-center"
                  >
                    <div>
                      <h6 class="card-subtitle mb-2 text-muted">Doanh thu</h6>
                      <h3 class="card-title mb-0">${totalRevenue}đ</h3>
                      <small class="text-success">
                        <i class="fas fa-arrow-up"></i> 12% so với tháng trước
                      </small>
                    </div>
                    <div class="icon">
                      <i class="fas fa-dollar-sign"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-3">
              <div class="card stat-card">
                <div class="card-body">
                  <div
                    class="d-flex justify-content-between align-items-center"
                  >
                    <div>
                      <h6 class="card-subtitle mb-2 text-muted">Đơn hàng</h6>
                      <h3 class="card-title mb-0">${totalOrders}</h3>
                      <small class="text-success">
                        <i class="fas fa-arrow-up"></i> 5 đơn hàng mới
                      </small>
                    </div>
                    <div class="icon">
                      <i class="fas fa-shopping-bag"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-3">
              <div class="card stat-card">
                <div class="card-body">
                  <div
                    class="d-flex justify-content-between align-items-center"
                  >
                    <div>
                      <h6 class="card-subtitle mb-2 text-muted">Khách hàng</h6>
                      <h3 class="card-title mb-0">${totalCustomers}</h3>
                      <small class="text-success">
                        <i class="fas fa-arrow-up"></i> 3 khách hàng mới
                      </small>
                    </div>
                    <div class="icon">
                      <i class="fas fa-users"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-3">
              <div class="card stat-card">
                <div class="card-body">
                  <div
                    class="d-flex justify-content-between align-items-center"
                  >
                    <div>
                      <h6 class="card-subtitle mb-2 text-muted">Sản phẩm</h6>
                      <h3 class="card-title mb-0">${totalProducts}</h3>
                      <small class="text-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        ${lowStockItems} sắp hết
                      </small>
                    </div>
                    <div class="icon">
                      <i class="fas fa-birthday-cake"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Charts -->
          <div class="row mb-4">
            <div class="col-md-8">
              <div class="chart-container">
                <h5 class="mb-4">Doanh thu theo tháng</h5>
                <canvas id="revenueChart"></canvas>
              </div>
            </div>
            <div class="col-md-4">
              <div class="chart-container">
                <h5 class="mb-4">Phân bố đơn hàng</h5>
                <canvas id="ordersPieChart"></canvas>
              </div>
            </div>
          </div>

          <!-- Recent Orders Table -->
          <div class="table-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
              <h5 class="mb-0">Đơn hàng gần đây</h5>
              <a href="orders.jsp" class="btn btn-primary btn-sm">
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
                      <td>${order.customerName}</td>
                      <td>${order.orderDate}</td>
                      <td>${order.totalAmount}đ</td>
                      <td>
                        <span class="badge bg-${order.statusColor}"
                          >${order.status}</span
                        >
                      </td>
                      <td>
                        <a
                          href="orders.jsp?id=${order.orderId}"
                          class="btn btn-sm btn-primary"
                        >
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

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Initialize Charts -->
    <script>
      // Revenue Chart
      const revenueCtx = document
        .getElementById("revenueChart")
        .getContext("2d");
      new Chart(revenueCtx, {
        type: "bar",
        data: {
          labels: [
            "T1",
            "T2",
            "T3",
            "T4",
            "T5",
            "T6",
            "T7",
            "T8",
            "T9",
            "T10",
            "T11",
            "T12",
          ],
          datasets: [
            {
              label: "Doanh thu (triệu đồng)",
              data: [65, 59, 80, 81, 56, 55, 40, 88, 96, 67, 71, 92],
              backgroundColor: "#f08632",
              borderColor: "#cf6f29",
              borderWidth: 1,
            },
          ],
        },
        options: {
          responsive: true,
          scales: {
            y: {
              beginAtZero: true,
            },
          },
        },
      });

      // Orders Pie Chart
      const ordersCtx = document
        .getElementById("ordersPieChart")
        .getContext("2d");
      new Chart(ordersCtx, {
        type: "doughnut",
        data: {
          labels: ["Hoàn thành", "Đang xử lý", "Đã hủy"],
          datasets: [
            {
              data: [65, 25, 10],
              backgroundColor: ["#28a745", "#ffc107", "#dc3545"],
            },
          ],
        },
        options: {
          responsive: true,
          plugins: {
            legend: {
              position: "bottom",
            },
          },
        },
      });
    </script>
  </body>
</html>
