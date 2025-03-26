<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        /* Filter Tabs (copied from order.jsp) */
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

        /* Search and Actions (copied from order.jsp) */
        .actions-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            gap: 16px;
        }

        .search-bar {
            padding: 0.5rem 1rem;
            border: 1px solid #eee;
            border-radius: 6px;
            color: #666;
            font-size: 0.9rem;
            outline: none;
            width: 300px;
        }

        .export-btn {
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

        .export-btn:hover {
            background: #f8f9fa;
            border-color: #ddd;
        }

        /* Table styles (copied from order.jsp) */
        .table-container {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            overflow: hidden;
        }

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

        .status-badge.admin {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .status-badge.member {
            background-color: #e0f2fe;
            color: #0284c7;
        }

        /* Pagination styles (restored from original) */
        .pagination {
            margin-top: 24px;
            margin-bottom: 0;
            justify-content: center;
        }

        .page-link {
            color: var(--primary-color);
            padding: 8px 16px;
            border: 1px solid var(--border-color);
            transition: all 0.2s;
        }

        .page-link:hover {
            background-color: #f3f4f6;
            border-color: var(--primary-color);
        }

        .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .page-item.disabled .page-link {
            color: #6b7280;
            background-color: #f9fafb;
            border-color: var(--border-color);
        }

        /* Modal styles */
        .modal-content {
            border-radius: 12px;
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

        .form-control, .form-select {
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(240, 134, 50, 0.25);
        }

        .invalid-feedback {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .alert {
            margin-bottom: 20px;
            border-radius: 8px;
            padding: 15px;
        }

        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }

        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
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
    </style>
</head>
<body>
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
            <a class="nav-link" href="${pageContext.request.contextPath}/adminOrder">
                <i class="fas fa-shopping-cart"></i>
                <span>Quản lý Đơn hàng</span>
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/CustomerManagerAd">
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
                <h2 class="header-title">Customers</h2>
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

            <!-- Nội dung chính -->
            <div class="content">
                <!-- Hiển thị thông báo -->
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-${sessionScope.messageType == 'success' ? 'success' : 'danger'} alert-dismissible fade show" role="alert">
                        ${sessionScope.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="message" scope="session"/>
                    <c:remove var="messageType" scope="session"/>
                </c:if>

                <!-- Nút Thêm Khách hàng -->
                <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#customerModal" onclick="resetForm()">
                    <i class="fas fa-user-plus me-2"></i>Thêm Khách hàng
                </button>

                <!-- Filter Tabs -->
                <div class="filter-tabs">
                    <button class="tab active" onclick="filterCustomers('all')">Tất cả</button>
                    <button class="tab" onclick="filterCustomers('0')">Admin</button>
                    <button class="tab" onclick="filterCustomers('1')">Khách hàng</button>
                </div>

                <!-- Actions Container -->
                <div class="actions-container">
                    <input type="text" class="search-bar" placeholder="Tìm kiếm khách hàng..." onkeyup="searchCustomers(this.value)">
                </div>

                <!-- Customers Table -->
                <div class="table-container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="mb-0">Danh sách khách hàng</h5>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover" id="customerTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên đăng nhập</th>
                                    <th>Email</th>
                                    <th>Họ</th>
                                    <th>Tên</th>
                                    <th>Ảnh đại diện</th>
                                    <th>Địa chỉ</th>
                                    <th>Số điện thoại</th>
                                    <th>Ngày đăng ký</th>
                                    <th>Vai trò</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${customers}" var="customer">
                                    <tr data-role="${customer.role}">
                                        <td>#${customer.customerId}</td>
                                        <td>${customer.username}</td>
                                        <td>${customer.email}</td>
                                        <td>${customer.firstName != null ? customer.firstName : 'N/A'}</td>
                                        <td>${customer.lastName != null ? customer.lastName : 'N/A'}</td>
                                        <td>
                                            <c:if test="${not empty customer.profilePicture}">
                                                <img src="${customer.profilePicture}" alt="Profile" class="avatar">
                                            </c:if>
                                            <c:if test="${empty customer.profilePicture}">
                                                <img src="${pageContext.request.contextPath}/img/default-avatar.jpg" alt="Default Profile" class="avatar">
                                            </c:if>
                                        </td>
                                        <td>${customer.address != null ? customer.address : 'N/A'}</td>
                                        <td>${customer.phone != null ? customer.phone : 'N/A'}</td>
                                        <td>${customer.registrationDate != null ? customer.registrationDate : 'N/A'}</td>
                                        <td>
                                            <span class="status-badge ${customer.role == 0 ? 'admin' : 'member'}">
                                                ${customer.role == 0 ? 'Admin' : 'Khách hàng'}
                                            </span>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/EditCustomerServlet/get/${customer.customerId}" method="get" style="display:inline;">
                                                <button type="submit" class="btn btn-warning btn-sm">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/EditCustomerServlet/delete/${customer.customerId}" method="post" style="display:inline;">
                                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa khách hàng này?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination (restored from original) -->
                <nav class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/CustomerManagerAd?page=${currentPage - 1}">
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/CustomerManagerAd?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/CustomerManagerAd?page=${currentPage + 1}">
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
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Thông tin Khách hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="customerForm" action="${pageContext.request.contextPath}/EditCustomerServlet" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <input type="hidden" name="customerId" id="customerId">

                        <!-- Profile Picture Section -->
                        <div class="text-center mb-4">
                            <div class="position-relative d-inline-block">
                                <img id="profilePreview" src="${pageContext.request.contextPath}/img/default-avatar.jpg" 
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
                                <input type="text" class="form-control" name="username" id="usernameInput" required 
                                       pattern="^[A-Za-z0-9_]{3,}$" />
                                <div class="invalid-feedback">Tên đăng nhập phải có ít nhất 3 ký tự và không chứa ký tự đặc biệt</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" name="email" required 
                                       pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" />
                                <div class="invalid-feedback">Vui lòng nhập email hợp lệ</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Họ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="firstName" required 
                                       pattern="^[A-Za-zÀ-ỹ\s]{2,}$" />
                                <div class="invalid-feedback">Họ phải có ít nhất 2 ký tự và không chứa số hoặc ký tự đặc biệt</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="lastName" required 
                                       pattern="^[A-Za-zÀ-ỹ\s]{2,}$" />
                                <div class="invalid-feedback">Tên phải có ít nhất 2 ký tự và không chứa số hoặc ký tự đặc biệt</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Mật khẩu</label>
                                <input type="password" class="form-control" name="password" id="passwordInput" 
                                       pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$" />
                                <small class="text-muted">Để trống nếu không muốn thay đổi mật khẩu (ít nhất 6 ký tự, bao gồm chữ và số)</small>
                                <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Xác nhận mật khẩu</label>
                                <input type="password" class="form-control" name="confirmPassword" id="confirmPasswordInput" />
                                <div class="invalid-feedback">Mật khẩu xác nhận không khớp</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" name="phone" required 
                                       pattern="(84|0[3|5|7|8|9])+([0-9]{8})" />
                                <div class="invalid-feedback">Số điện thoại phải có 10 số, bắt đầu bằng 84 hoặc 03, 05, 07, 08, 09</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Vai trò <span class="text-danger">*</span></label>
                                <select class="form-select" name="role" required>
                                    <option value="">Chọn vai trò</option>
                                    <option value="1">Khách hàng</option>
                                    <option value="0">Admin</option>
                                </select>
                                <div class="invalid-feedback">Vui lòng chọn vai trò</div>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                <textarea class="form-control" name="address" rows="3" required minlength="10"></textarea>
                                <div class="invalid-feedback">Địa chỉ phải có ít nhất 10 ký tự</div>
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
        const contextPath = "${pageContext.request.contextPath}";

        // Kiểm tra nếu có dữ liệu khách hàng trong session thì hiển thị modal
        <c:if test="${not empty sessionScope.editCustomer}">
            window.addEventListener('DOMContentLoaded', (event) => {
                const customer = {
                    customerId: "${sessionScope.editCustomer.customerId}",
                    username: "${sessionScope.editCustomer.username}",
                    email: "${sessionScope.editCustomer.email}",
                    firstName: "${sessionScope.editCustomer.firstName}",
                    lastName: "${sessionScope.editCustomer.lastName}",
                    phone: "${sessionScope.editCustomer.phone}",
                    role: "${sessionScope.editCustomer.role}",
                    address: "${sessionScope.editCustomer.address}",
                    profilePicture: "${sessionScope.editCustomer.profilePicture}"
                };

                // Populate modal with customer data
                document.getElementById('customerId').value = customer.customerId;
                document.querySelector('[name="username"]').value = customer.username;
                document.querySelector('[name="email"]').value = customer.email;
                document.querySelector('[name="firstName"]').value = customer.firstName;
                document.querySelector('[name="lastName"]').value = customer.lastName;
                document.querySelector('[name="phone"]').value = customer.phone;
                document.querySelector('[name="role"]').value = customer.role;
                document.querySelector('[name="address"]').value = customer.address;

                // Handle password fields
                document.getElementById('passwordInput').removeAttribute('required');
                document.getElementById('confirmPasswordInput').removeAttribute('required');

                // Handle profile picture
                if (customer.profilePicture) {
                    document.getElementById('profilePreview').src = customer.profilePicture;
                } else {
                    document.getElementById('profilePreview').src = `${contextPath}/img/default-avatar.jpg`;
                }

                // Update modal title and make username readonly
                document.getElementById('modalTitle').textContent = 'Chỉnh sửa Khách hàng';
                document.getElementById('usernameInput').setAttribute('readonly', 'readonly');

                // Show modal
                const modal = new bootstrap.Modal(document.getElementById('customerModal'));
                modal.show();
            });
            <%
                // Xóa dữ liệu khách hàng khỏi session sau khi đã sử dụng
                session.removeAttribute("editCustomer");
            %>
        </c:if>

        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profilePreview').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function resetForm() {
            document.getElementById('customerForm').reset();
            document.getElementById('customerId').value = '';
            document.getElementById('profilePreview').src = `${contextPath}/img/default-avatar.jpg`;
            document.getElementById('modalTitle').textContent = 'Thêm Khách hàng';
            document.getElementById('usernameInput').removeAttribute('readonly');
            document.getElementById('passwordInput').setAttribute('required', 'required');
            document.getElementById('confirmPasswordInput').setAttribute('required', 'required');
        }

        // Form validation
        (function () {
            "use strict";
            const forms = document.querySelectorAll(".needs-validation");
            Array.from(forms).forEach((form) => {
                form.addEventListener("submit", (event) => {
                    const password = form.querySelector('[name="password"]').value;
                    const confirmPassword = form.querySelector('[name="confirmPassword"]').value;
                    const confirmPasswordInput = form.querySelector('[name="confirmPassword"]');

                    // Validate password match
                    if (password !== confirmPassword) {
                        confirmPasswordInput.setCustomValidity("Mật khẩu xác nhận không khớp");
                    } else {
                        confirmPasswordInput.setCustomValidity("");
                    }

                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add("was-validated");
                }, false);

                // Reset custom validity on input change
                form.querySelector('[name="confirmPassword"]').addEventListener("input", function () {
                    this.setCustomValidity("");
                });
            });
        })();

        function filterCustomers(role) {
            const rows = document.querySelectorAll("#customerTable tbody tr");
            const tabs = document.querySelectorAll(".filter-tabs .tab");

            // Update active tab
            tabs.forEach(tab => tab.classList.remove("active"));
            event.target.classList.add("active");

            // Filter rows
            rows.forEach(row => {
                const rowRole = row.getAttribute("data-role");
                if (role === "all" || rowRole === role) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

        function searchCustomers(query) {
            const rows = document.querySelectorAll("#customerTable tbody tr");
            query = query.toLowerCase();

            rows.forEach(row => {
                const username = row.cells[1].textContent.toLowerCase();
                const email = row.cells[2].textContent.toLowerCase();
                if (username.includes(query) || email.includes(query)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
</body>
</html>