<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #f08632;
            --secondary-color: #cf6f29;
            --dark-color: #343a40;
        }
        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
        .action-buttons .btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        .modal-header {
            background-color: var(--primary-color);
            color: white;
        }
        .form-label {
            font-weight: 500;
        }
        .table-hover tbody tr:hover {
            background-color: rgba(240, 134, 50, 0.1);
        }
        .badge.role-badge {
            font-size: 0.85rem;
            padding: 0.35em 0.65em;
        }
        .search-box {
            border-radius: 20px;
            border: 1px solid #ddd;
            padding: 0.5rem 1rem;
        }
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .customer-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .customer-card:hover {
            transform: translateY(-5px);
        }
        .registration-date {
            font-size: 0.85rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Quản lý Khách hàng</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#customerModal">
                <i class="fas fa-user-plus me-2"></i>Thêm Khách hàng
            </button>
        </div>

        <!-- Filters -->
        <div class="filter-section">
            <form class="row g-3" action="admin-customers" method="get">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control border-start-0 search-box" 
                               name="search" placeholder="Tìm theo tên, email, số điện thoại...">
                    </div>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="role">
                        <option value="">Tất cả vai trò</option>
                        <option value="1">Khách hàng</option>
                        <option value="0">Admin</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="sort">
                        <option value="registration_desc">Mới đăng ký nhất</option>
                        <option value="registration_asc">Cũ nhất</option>
                        <option value="name_asc">Tên A-Z</option>
                        <option value="name_desc">Tên Z-A</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-filter me-2"></i>Lọc
                    </button>
                </div>
            </form>
        </div>

        <!-- Customers Grid -->
        <div class="row g-4">
            <c:forEach items="${customers}" var="customer">
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <div class="card customer-card">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <img src="${empty customer.profilePicture ? 'img/default-avatar.jpg' : customer.profilePicture}" 
                                     alt="${customer.firstName} ${customer.lastName}" 
                                     class="user-avatar me-3">
                                <div>
                                    <h6 class="mb-1">${customer.firstName} ${customer.lastName}</h6>
                                    <span class="badge role-badge ${customer.role == 0 ? 'bg-danger' : 'bg-info'}">
                                        ${customer.role == 0 ? 'Admin' : 'Khách hàng'}
                                    </span>
                                </div>
                            </div>
                            <div class="mb-3">
                                <p class="mb-1"><i class="fas fa-envelope me-2 text-muted"></i>${customer.email}</p>
                                <p class="mb-1"><i class="fas fa-phone me-2 text-muted"></i>${customer.phone}</p>
                                <p class="mb-1"><i class="fas fa-map-marker-alt me-2 text-muted"></i>${customer.address}</p>
                                <p class="registration-date">
                                    <i class="fas fa-calendar me-2"></i>Ngày đăng ký: ${customer.registrationDate}
                                </p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <button class="btn btn-info btn-sm" onclick="viewCustomer(${customer.customerId})">
                                    <i class="fas fa-eye me-1"></i>Chi tiết
                                </button>
                                <button class="btn btn-warning btn-sm" onclick="editCustomer(${customer.customerId})">
                                    <i class="fas fa-edit me-1"></i>Sửa
                                </button>
                                <button class="btn btn-danger btn-sm" onclick="deleteCustomer(${customer.customerId})">
                                    <i class="fas fa-trash me-1"></i>Xóa
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination -->
        <nav class="mt-4">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage - 1}"><i class="fas fa-chevron-left"></i></a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}"><i class="fas fa-chevron-right"></i></a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Add/Edit Customer Modal -->
    <div class="modal fade" id="customerModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thông tin Khách hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="customerForm" action="admin-customers" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="customerId" id="customerId">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Tên đăng nhập</label>
                                <input type="text" class="form-control" name="username" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Họ</label>
                                <input type="text" class="form-control" name="firstName">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Tên</label>
                                <input type="text" class="form-control" name="lastName">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Mật khẩu</label>
                                <input type="password" class="form-control" name="password">
                                <small class="text-muted">Để trống nếu không muốn thay đổi mật khẩu</small>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại</label>
                                <input type="tel" class="form-control" name="phone">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Vai trò</label>
                                <select class="form-select" name="role">
                                    <option value="1">Khách hàng</option>
                                    <option value="0">Admin</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Ảnh đại diện</label>
                                <input type="file" class="form-control" name="profilePicture" accept="image/*">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <textarea class="form-control" name="address" rows="2"></textarea>
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
                fetch(`admin-customers/delete/${id}`, { method: 'POST' })
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
</body>
</html> 