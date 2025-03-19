<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 280px;
            background: #2c3e50;
            padding: 20px;
            color: white;
        }
        .main-content {
            margin-left: 280px;
            padding: 20px;
        }
        .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 12px 20px;
            border-radius: 10px;
            margin-bottom: 5px;
        }
        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: white;
        }
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 15px;
        }
        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light">
    <!-- Sidebar -->
    <div class="sidebar">
        <h3 class="mb-4 text-center">Admin Panel</h3>
        <div class="d-flex flex-column">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">
                <i class="bi bi-speedometer2 me-2"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/customers" class="nav-link">
                <i class="bi bi-people me-2"></i> Customers
            </a>
            <a href="${pageContext.request.contextPath}/admin/statistics" class="nav-link">
                <i class="bi bi-graph-up me-2"></i> Statistics
            </a>
            <form action="${pageContext.request.contextPath}/admin/logout" method="post" class="mt-auto">
                <button type="submit" class="nav-link text-danger border-0 bg-transparent w-100 text-start">
                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                </button>
            </form>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Dashboard</h2>
            <div class="d-flex align-items-center">
                <i class="bi bi-person-circle me-2"></i>
                Welcome
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row">
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon bg-primary text-white">
                        <i class="bi bi-people"></i>
                    </div>
                    <h3 class="mb-2"></h3>
                    <p class="text-muted mb-0">Total Customers</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon bg-success text-white">
                        <i class="bi bi-cart"></i>
                    </div>
                    <h3 class="mb-2"></h3>
                    <p class="text-muted mb-0">Total Orders</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon bg-warning text-white">
                        <i class="bi bi-currency-dollar"></i>
                 
                    <p class="text-muted mb-0">Total Revenue</p>
                </div>
            </div>
        </div>

        <!-- Orders by Status -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="chart-container">
                    <h4 class="mb-4">Orders by Status</h4>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Status</th>
                                    <th>Count</th>
                                    <th>Percentage</th>
                                </tr>
                            </thead>
                            <tbody>
                               
                               
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 