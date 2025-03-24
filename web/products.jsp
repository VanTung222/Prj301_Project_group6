<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sản phẩm - Cake Shop</title>
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

        .table .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: var(--border-radius);
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-chart-line me-2"></i> Dashboard</a></li>
            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/ProductServlet22"><i class="fas fa-birthday-cake me-2"></i> Quản lý Bánh</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/adminOrder"><i class="fas fa-shopping-cart me-2"></i> Quản lý Đơn hàng</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/CustomerManagerAd"><i class="fas fa-users me-2"></i> Quản lý Khách hàng</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-${sessionScope.messageType == 'success' ? 'success' : 'danger'} alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="message" scope="session"/>
                <c:remove var="messageType" scope="session"/>
            </c:if>

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">Quản lý Sản phẩm</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#productModal" onclick="resetForm()">
                    <i class="fas fa-plus me-2"></i>Thêm Sản phẩm
                </button>
            </div>

            <div class="search-section">
                <form class="d-flex align-items-center" action="${pageContext.request.contextPath}/ProductServlet22" method="get">
                    <div class="search-box me-2 flex-grow-1">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="fas fa-search"></i></span>
                            <input type="text" class="form-control" name="search" placeholder="Tìm kiếm sản phẩm..." value="${param.search}">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-search me-2"></i>Tìm kiếm</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="table-container">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr><th>ID</th><th>Tên sản phẩm</th><th>Giá</th><th>Số lượng</th><th>Mô tả</th><th>Danh mục</th><th>Nhà cung cấp</th><th>Hình ảnh</th><th>Hành động</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${productList}" var="product">
                                <tr>
                                    <td>${product.productId}</td>
                                    <td>${product.name}</td>
                                    <td>${product.price}</td>
                                    <td>${product.stock}</td>
                                    <td>${product.description}</td>
                                    <td>${product.productCategoryId}</td>
                                    <td>${product.supplierId}</td>
                                    <td>
                                        <c:if test="${not empty product.productImg}"><img src="${pageContext.request.contextPath}/${product.productImg}" alt="Product" class="product-img"></c:if>
                                        <c:if test="${empty product.productImg}"><img src="${pageContext.request.contextPath}/img/default-product.jpg" alt="Default Product" class="product-img"></c:if>
                                    </td>
                                    <td class="action-buttons">
                                        <button class="btn btn-warning btn-sm" onclick="editProduct('${product.productId}')"><i class="fas fa-edit"></i></button>
                                        <a href="${pageContext.request.contextPath}/ProductServlet22/delete/${product.productId}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')"><i class="fas fa-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <nav class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/ProductServlet22?page=${currentPage - 1}"><i class="fas fa-chevron-left"></i></a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/ProductServlet22?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/ProductServlet22?page=${currentPage + 1}"><i class="fas fa-chevron-right"></i></a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="productModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modalTitle">Thông tin Sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" action="${pageContext.request.contextPath}/ProductServlet22/add" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <input type="hidden" name="productId" id="productId">
                        <input type="hidden" name="action" id="actionType" value="add">
                        <div class="text-center mb-4">
                            <div class="position-relative d-inline-block">
                                <img id="productPreview" src="${pageContext.request.contextPath}/img/default-product.jpg" class="rounded mb-3" style="width: 200px; height: 200px; object-fit: cover;">
                                <label for="productImg" class="position-absolute bottom-0 end-0 bg-primary text-white rounded-circle p-2" style="cursor: pointer;">
                                    <i class="fas fa-camera"></i>
                                </label>
                                <input type="file" id="productImg" name="productImg" accept="image/*" style="display: none;" onchange="previewImage(this)">
                            </div>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="name" id="name" required>
                                <div class="invalid-feedback">Vui lòng nhập tên sản phẩm</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Giá <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" class="form-control" name="price" id="price" required>
                                <div class="invalid-feedback">Vui lòng nhập giá sản phẩm</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số lượng <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="stock" id="stock" required>
                                <div class="invalid-feedback">Vui lòng nhập số lượng</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Danh mục <span poet="text-danger">*</span></label>
                                <select class="form-select" name="categoryId" id="categoryId" required>
                                    <option value="">Chọn danh mục</option>
                                    <option value="1">Bánh ngọt</option>
                                    <option value="2">Bánh mặn</option>
                                    <option value="3">Bánh kem</option>
                                    <option value="4">Bánh trung thu</option>
                                </select>
                                <div class="invalid-feedback">Vui lòng chọn danh mục</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Nhà cung cấp <span class="text-danger">*</span></label>
                                <select class="form-select" name="supplierId" id="supplierId" required>
                                    <option value="">Chọn nhà cung cấp</option>
                                    <option value="1">Nhà cung cấp 1</option>
                                    <option value="2">Nhà cung cấp 2</option>
                                    <option value="3">Nhà cung cấp 3</option>
                                </select>
                                <div class="invalid-feedback">Vui lòng chọn nhà cung cấp</div>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Mô tả <span class="text-danger">*</span></label>
                                <textarea class="form-control" name="description" id="description" rows="3" required></textarea>
                                <div class="invalid-feedback">Vui lòng nhập mô tả sản phẩm</div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" form="productForm" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const contextPath = "${pageContext.request.contextPath}";
        
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('productPreview').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function resetForm() {
            document.getElementById('productForm').reset();
            document.getElementById('productId').value = '';
            document.getElementById('actionType').value = 'add';
            document.getElementById('productPreview').src = `${contextPath}/img/default-product.jpg`;
            document.getElementById('modalTitle').textContent = 'Thêm Sản phẩm';
            document.getElementById('productForm').action = `${contextPath}/ProductServlet22/add`;
        }

        function editProduct(productId) {
            console.log('Fetching product with ID:', productId);
            fetch(`${contextPath}/ProductServlet22/get/${productId}`, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            })
                .then(response => {
                    console.log('Response status:', response.status);
                    if (!response.ok) {
                        throw new Error(`HTTP error! Status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(product => {
                    console.log('Product data:', product);
                    document.getElementById('productId').value = product.productId;
                    document.getElementById('name').value = product.name;
                    document.getElementById('price').value = product.price;
                    document.getElementById('stock').value = product.stock;
                    document.getElementById('description').value = product.description;
                    document.getElementById('categoryId').value = product.productCategoryId;
                    document.getElementById('supplierId').value = product.supplierId;
                    document.getElementById('actionType').value = 'update';
                    document.getElementById('productForm').action = `${contextPath}/ProductServlet22/update`;
                    const productPreview = document.getElementById('productPreview');
                    productPreview.src = product.productImg ? `${contextPath}/${product.productImg}` : `${contextPath}/img/default-product.jpg`;
                    document.getElementById('modalTitle').textContent = 'Chỉnh sửa Sản phẩm';
                    const modal = new bootstrap.Modal(document.getElementById('productModal'));
                    modal.show();
                })
                .catch(error => {
                    console.error('Error fetching product:', error);
                    alert('Không thể tải thông tin sản phẩm: ' + error.message);
                });
        }

        (function () {
            "use strict";
            const forms = document.querySelectorAll(".needs-validation");
            Array.from(forms).forEach((form) => {
                form.addEventListener("submit", (event) => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add("was-validated");
                }, false);
            });
        })();
    </script>
</body>
</html>