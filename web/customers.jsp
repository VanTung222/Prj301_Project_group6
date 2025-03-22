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
            body {
                background-color: #f8f9fa;
            }
            .container-fluid {
                padding: 20px;
            }
            .table {
                background-color: white;
                border-radius: 8px;
                overflow: hidden;
            }
            .table th {
                background-color: #f8f9fa;
                border-bottom: 2px solid #dee2e6;
            }
            .btn-home {
                background-color: #0d6efd;
                color: white;
                border-radius: 5px;
                padding: 8px 16px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                margin-right: 15px;
            }
            .btn-home:hover {
                background-color: #0b5ed7;
                color: white;
            }
            .search-section {
                background-color: white;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
            }
            .search-box {
                max-width: 500px;
            }
            .search-button {
                background-color: #0d6efd;
                color: white;
                border: none;
                padding: 8px 20px;
                border-radius: 5px;
            }
            .badge.bg-danger {
                background-color: #dc3545 !important;
            }
            .badge.bg-info {
                background-color: #0dcaf0 !important;
            }
            .modal-header {
                background-color: #0d6efd;
                color: white;
            }
            .btn-close {
                filter: brightness(0) invert(1);
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="d-flex align-items-center">
                    <a href="index.jsp" class="btn-home">
                        <i class="fas fa-home me-2"></i>
                        Về trang chủ
                    </a>
                    <h2 class="mb-0">Quản lý Khách hàng</h2>
                </div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#customerModal">
                    <i class="fas fa-user-plus me-2"></i>Thêm Khách hàng
                </button>
            </div>

            <!-- Search Section -->
            <div class="search-section">
                <form class="d-flex align-items-center" action="admin-customers" method="get">
                    <div class="search-box me-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white">
                                <i class="fas fa-search"></i>
                            </span>
                            <input type="text" class="form-control" name="search" 
                                   placeholder="Tìm kiếm khách hàng..." value="${param.search}">
                        </div>
                    </div>
                    <button type="submit" class="search-button">
                        <i class="fas fa-search me-2"></i>Tìm kiếm
                    </button>
                </form>
            </div>

            <!-- Customers Table -->
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Customer_ID</th>
                            <th>GoogleID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>FirstName</th>
                            <th>LastName</th>
                            <th>Password</th>
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
                                <td>${customer.googleId != null ? customer.googleId : 'NULL'}</td>
                                <td>${customer.username}</td>
                                <td>${customer.email}</td>
                                <td>${customer.firstName != null ? customer.firstName : 'NULL'}</td>
                                <td>${customer.lastName != null ? customer.lastName : 'NULL'}</td>
                                <td>${customer.password != null ? '***' : 'NULL'}</td>
                                <td>
                                    <c:if test="${not empty customer.profilePicture}">
                                        <img src="${customer.profilePicture}" alt="Profile" class="img-thumbnail" style="max-width: 50px;">
                                    </c:if>
                                    <c:if test="${empty customer.profilePicture}">
                                        NULL
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
                                <td>
                                    <button type="button" class="btn btn-warning btn-sm" 
                                            onclick="editCustomer(${customer.customerId})">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button type="button" class="btn btn-danger btn-sm" 
                                            onclick="deleteCustomer(${customer.customerId})">
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