<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Khách hàng - Cake Shop</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #f08632;
                --secondary-color: #cf6f29;
                --dark-color: #343a40;
                --light-gray: #f8f9fa;
                --border-radius: 8px;
                --box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            
            body {
                background-color: var(--light-gray);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .sidebar {
                min-height: 100vh;
                background-color: var(--dark-color);
                padding-top: 20px;
                position: fixed;
                left: 0;
                top: 0;
                width: 250px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
                z-index: 1000;
            }

            .sidebar .brand {
                color: var(--primary-color);
                text-decoration: none;
                font-size: 24px;
                padding: 0 20px 20px;
                display: flex;
                align-items: center;
                gap: 10px;
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
                margin-left: 250px;
                padding: 30px;
                background-color: var(--light-gray);
            }

            .table-container {
                background: white;
                border-radius: var(--border-radius);
                padding: 25px;
                box-shadow: var(--box-shadow);
            }

            .table {
                margin-bottom: 0;
                vertical-align: middle;
            }

            .table th {
                background-color: #f8f9fa;
                font-weight: 600;
                padding: 15px;
                border-bottom: 2px solid #dee2e6;
                white-space: nowrap;
            }

            .table td {
                padding: 15px;
                vertical-align: middle;
            }

            .table tbody tr:hover {
                background-color: rgba(240, 134, 50, 0.05);
            }

            .table .profile-pic {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #fff;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .badge {
                padding: 8px 12px;
                font-weight: 500;
                border-radius: 20px;
            }

            .badge.bg-danger {
                background-color: #dc3545 !important;
            }

            .badge.bg-info {
                background-color: #0dcaf0 !important;
            }

            .search-section {
                background: white;
                border-radius: var(--border-radius);
                padding: 25px;
                margin-bottom: 25px;
                box-shadow: var(--box-shadow);
            }

            .search-box .input-group {
                border-radius: var(--border-radius);
                overflow: hidden;
            }

            .search-box .input-group-text {
                border: none;
                background-color: #fff;
                padding-left: 15px;
            }

            .search-box .form-control {
                border: 1px solid #ced4da;
                padding: 12px;
                font-size: 1rem;
            }

            .search-box .form-control:focus {
                box-shadow: none;
                border-color: var(--primary-color);
            }

            .btn {
                padding: 8px 16px;
                border-radius: var(--border-radius);
                transition: all 0.3s ease;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-primary:hover {
                background-color: var(--secondary-color);
                border-color: var(--secondary-color);
                transform: translateY(-1px);
            }

            .btn-sm {
                padding: 5px 10px;
                font-size: 0.875rem;
            }

            .btn-warning {
                background-color: #ffc107;
                border-color: #ffc107;
                color: #000;
            }

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
                color: #fff;
            }

            .action-buttons .btn {
                margin: 0 3px;
            }

            .pagination {
                margin-top: 25px;
                margin-bottom: 0;
            }

            .page-link {
                color: var(--primary-color);
                padding: 8px 16px;
            }

            .page-item.active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .modal-content {
                border-radius: var(--border-radius);
                overflow: hidden;
            }

            .modal-header {
                background-color: var(--primary-color);
                color: white;
                padding: 15px 25px;
            }

            .modal-body {
                padding: 25px;
            }

            .form-label {
                font-weight: 500;
                margin-bottom: 8px;
            }

            .form-control {
                padding: 10px;
                border-radius: var(--border-radius);
            }

            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 15px;
                }

                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                }

                .sidebar.show {
                    transform: translateX(0);
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <a href="index.jsp" class="brand mb-4">
                <img
              src="img/logo.png"
              alt="Cake Shop Logo"
              style="max-width: 150px"
            />
                <span></span>
            </a>
            <nav class="nav flex-column">
                <a class="nav-link" href="dashboard.jsp">
                    <i class="fas fa-chart-line"></i>
                    <span>Dashboard</span>
                </a>
                <a class="nav-link" href="ProductServlet22">
                    <i class="fas fa-birthday-cake"></i>
                    <span>Quản lý Bánh</span>
                </a>
                <a class="nav-link" href="orders.jsp">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Quản lý Đơn hàng</span>
                </a>
                <a class="nav-link active" href="customers.jsp">
                    <i class="fas fa-users"></i>
                    <span>Quản lý Khách hàng</span>
                </a>
                <a class="nav-link" href="reports.jsp">
                    <i class="fas fa-chart-bar"></i>
                    <span>Báo cáo & Thống kê</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="container-fluid">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Quản lý Khách hàng</h2>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#customerModal">
                        <i class="fas fa-user-plus me-2"></i>Thêm Khách hàng
                    </button>
                </div>

                <!-- Search Section -->
                <div class="search-section">
                    <form class="d-flex align-items-center" action="admin-customers" method="get">
                        <div class="search-box me-2 flex-grow-1">
                            <div class="input-group">
                                <span class="input-group-text bg-white">
                                    <i class="fas fa-search"></i>
                                </span>
                                <input type="text" class="form-control" name="search" 
                                       placeholder="Tìm kiếm khách hàng..." value="${param.search}">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Tìm kiếm
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Customers Table -->
                <div class="table-container">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Customer_ID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>FirstName</th>
                                    <th>LastName</th>
                                    <th>ProfilePicture</th>
                                    <th>Address</th>
                                    <th>Phone</th>
                                    <th>Registration_Date</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${customers}" var="customer">
                                    <tr>
                                        <td>${customer.customerId}</td>
                                        <td>${customer.username}</td>
                                        <td>${customer.email}</td>
                                        <td>${customer.firstName != null ? customer.firstName : 'NULL'}</td>
                                        <td>${customer.lastName != null ? customer.lastName : 'NULL'}</td>
                                        <td>
                                            <c:if test="${not empty customer.profilePicture}">
                                                <img src="${customer.profilePicture}" alt="Profile" class="profile-pic">
                                            </c:if>
                                            <c:if test="${empty customer.profilePicture}">
                                                <img src="img/default-avatar.jpg" alt="Default Profile" class="profile-pic">
                                            </c:if>
                                        </td>
                                        <td>${customer.address != null ? customer.address : 'NULL'}</td>
                                        <td>${customer.phone != null ? customer.phone : 'NULL'}</td>
                                        <td>${customer.registrationDate != null ? customer.registrationDate : 'NULL'}</td>
                                        <td>
                                            <span class="badge ${customer.role == 0 ? 'bg-danger' : 'bg-info'}">
                                                ${customer.role == 0 ? 'Admin' : 'Member'}
                                            </span>
                                        </td>
                                        <td class="action-buttons">
                                            <button type="button" class="btn btn-warning btn-sm" onclick="editCustomer(${customer.customerId})">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button type="button" class="btn btn-danger btn-sm" onclick="deleteCustomer(${customer.customerId})">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <nav class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!-- Add/Edit Customer Modal -->
        <div class="modal fade" id="customerModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Thông tin Khách hàng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="customerForm" action="admin-customers" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="customerId" id="customerId">
                            
                            <!-- Profile Picture Section -->
                            <div class="text-center mb-4">
                                <div class="position-relative d-inline-block">
                                    <img id="profilePreview" src="img/default-avatar.jpg" 
                                         class="rounded-circle mb-3" 
                                         style="width: 150px; height: 150px; object-fit: cover;">
                                    <label for="profilePicture" 
                                           class="position-absolute bottom-0 end-0 bg-primary text-white rounded-circle p-2" 
                                           style="cursor: pointer;">
                                        <i class="fas fa-camera"></i>
                                    </label>
                                    <input type="file" id="profilePicture" name="profilePicture" 
                                           accept="image/*" style="display: none;"
                                           onchange="previewImage(this)">
                                </div>
                            </div>

                            <!-- Form Fields -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Tên đăng nhập <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="username" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" name="email" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Họ <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="firstName" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Tên <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="lastName" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Mật khẩu</label>
                                    <input type="password" class="form-control" name="password">
                                    <small class="text-muted">Để trống nếu không muốn thay đổi mật khẩu</small>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Xác nhận mật khẩu</label>
                                    <input type="password" class="form-control" name="confirmPassword">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" name="phone">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Vai trò <span class="text-danger">*</span></label>
                                    <select class="form-select" name="role" required>
                                        <option value="">Chọn vai trò</option>
                                        <option value="1">Khách hàng</option>
                                        <option value="0">Admin</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Địa chỉ</label>
                                    <textarea class="form-control" name="address" rows="3"></textarea>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" form="customerForm" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            function previewImage(input) {
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('profilePreview').src = e.target.result;
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }

            function viewCustomer(id) {
                fetch(`admin-customers/get/${id}`)
                        .then(response => response.json())
                        .then(customer => {
                            // Populate modal with customer data
                            document.getElementById('customerId').value = customer.customerId;
                            document.querySelector('[name="username"]').value = customer.username;
                            document.querySelector('[name="email"]').value = customer.email;
                            document.querySelector('[name="firstName"]').value = customer.firstName;
                            document.querySelector('[name="lastName"]').value = customer.lastName;
                            document.querySelector('[name="phone"]').value = customer.phone;
                            document.querySelector('[name="role"]').value = customer.role;
                            document.querySelector('[name="address"]').value = customer.address;

                            // Show modal
                            const modal = new bootstrap.Modal(document.getElementById('customerModal'));
                            modal.show();
                        });
            }

            function editCustomer(id) {
                viewCustomer(id); // Reuse view function as it already populates the form
            }

            function deleteCustomer(id) {
                if (confirm('Bạn có chắc muốn xóa khách hàng này?')) {
                    fetch(`admin-customers/delete/${id}`, {method: 'POST'})
                            .then(response => {
                                if (response.ok) {
                                    window.location.reload();
                                } else {
                                    alert('Có lỗi xảy ra khi xóa khách hàng');
                                }
                            });
                }
            }
        </script>

        <script>
            document.getElementById("searchBox").addEventListener("keyup", function () {
                let filter = this.value.toLowerCase();
                let rows = document.querySelectorAll("tbody tr");
                rows.forEach(row => {
                    let text = row.innerText.toLowerCase();
                    row.style.display = text.includes(filter) ? "" : "none";
                });
            });
        </script>

    </body>
</html> 