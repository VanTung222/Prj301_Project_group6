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

        .form-control, .form-select {
            padding: 10px;
            border-radius: var(--border-radius);
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
            border-radius: var(--border-radius);
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
                <a class="nav-link" href="${pageContext.request.contextPath}/adminOrder">
                    <i class="fas fa-shopping-cart me-2"></i> Quản lý Đơn hàng
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/CustomerManagerAd">
                    <i class="fas fa-users me-2"></i> Quản lý Khách hàng
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <!-- Hiển thị thông báo -->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-${sessionScope.messageType == 'success' ? 'success' : 'danger'} alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="message" scope="session"/>
                <c:remove var="messageType" scope="session"/>
            </c:if>

            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">Quản lý Khách hàng</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#customerModal" onclick="resetForm()">
                    <i class="fas fa-user-plus me-2"></i>Thêm Khách hàng
                </button>
            </div>

            <!-- Search Section -->
            <div class="search-section">
                <form class="d-flex align-items-center" action="${pageContext.request.contextPath}/EditCustomerServlet" method="get">
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
                                            <img src="${pageContext.request.contextPath}/img/default-avatar.jpg" alt="Default Profile" class="profile-pic">
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

                <!-- Pagination -->
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
                <div class="modal-header bg-primary text-white">
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
    </script>

    <script>
        document.getElementById("searchBox")?.addEventListener("keyup", function () {
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