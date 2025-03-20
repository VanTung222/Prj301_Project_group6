<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #f08632;
            --secondary-color: #cf6f29;
            --dark-color: #343a40;
        }
        .product-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            height: 100%;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .product-image {
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .product-price {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary-color);
        }
        .stock-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .category-badge {
            background-color: #e9ecef;
            color: var(--dark-color);
            padding: 0.4rem 0.8rem;
            border-radius: 15px;
            font-size: 0.875rem;
            font-weight: 500;
        }
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .modal-header {
            background-color: var(--primary-color);
            color: white;
        }
        .preview-container {
            width: 200px;
            height: 200px;
            border-radius: 10px;
            overflow: hidden;
            margin: 1rem auto;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .preview-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .product-description {
            height: 48px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Quản lý Sản phẩm</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#productModal">
                <i class="fas fa-plus me-2"></i>Thêm Sản phẩm
            </button>
        </div>

        <!-- Filters -->
        <div class="filter-section">
            <form class="row g-3" action="admin-products" method="get">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control border-start-0" 
                               name="search" placeholder="Tìm kiếm sản phẩm...">
                    </div>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="category">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.categoryId}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="sort">
                        <option value="name_asc">Tên A-Z</option>
                        <option value="name_desc">Tên Z-A</option>
                        <option value="price_asc">Giá tăng dần</option>
                        <option value="price_desc">Giá giảm dần</option>
                        <option value="stock_asc">Tồn kho thấp nhất</option>
                        <option value="stock_desc">Tồn kho cao nhất</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-filter me-2"></i>Lọc
                    </button>
                </div>
            </form>
        </div>

        <!-- Products Grid -->
        <div class="row g-4">
            <c:forEach items="${products}" var="product">
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <div class="card product-card">
                        <div class="position-relative">
                            <img src="${product.productImg}" class="card-img-top product-image" alt="${product.name}">
                            <span class="stock-badge ${product.stock < 10 ? 'bg-danger' : 'bg-success'} text-white">
                                Còn ${product.stock} sản phẩm
                            </span>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h5 class="card-title mb-0">${product.name}</h5>
                                <span class="product-price">${product.price}đ</span>
                            </div>
                            <p class="card-text text-muted product-description">${product.productDescription}</p>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="category-badge">${product.categoryName}</span>
                                <small class="text-muted">ID: #${product.productId}</small>
                            </div>
                            <div class="d-flex justify-content-between">
                                <button class="btn btn-warning btn-sm" onclick="editProduct(${product.productId})">
                                    <i class="fas fa-edit me-1"></i>Sửa
                                </button>
                                <button class="btn btn-danger btn-sm" onclick="deleteProduct(${product.productId})">
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

    <!-- Add/Edit Product Modal -->
    <div class="modal fade" id="productModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm/Sửa Sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" action="admin-products" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="productId" id="productId">
                        <div class="row mb-3">
                            <div class="col-md-8">
                                <label class="form-label">Tên sản phẩm</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Giá</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" name="price" required>
                                    <span class="input-group-text">đ</span>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Danh mục</label>
                                <select class="form-select" name="categoryId" required>
                                    <option value="">Chọn danh mục</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Nhà cung cấp</label>
                                <select class="form-select" name="supplierId" required>
                                    <option value="">Chọn nhà cung cấp</option>
                                    <c:forEach items="${suppliers}" var="supplier">
                                        <option value="${supplier.id}">${supplier.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Số lượng tồn kho</label>
                                <input type="number" class="form-control" name="stock" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Hình ảnh sản phẩm</label>
                                <input type="file" class="form-control" name="productImg" accept="image/*" onchange="previewImage(this)">
                                <div class="preview-container mt-2 d-none">
                                    <img id="preview" class="preview-image">
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả sản phẩm</label>
                            <textarea class="form-control" name="productDescription" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" form="productForm" class="btn btn-primary">Lưu sản phẩm</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function previewImage(input) {
            const preview = document.getElementById('preview');
            const container = preview.parentElement;
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    container.classList.remove('d-none');
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function editProduct(id) {
            fetch(`admin-products/get/${id}`)
                .then(response => response.json())
                .then(product => {
                    // Populate form with product data
                    document.getElementById('productId').value = product.productId;
                    document.querySelector('[name="name"]').value = product.name;
                    document.querySelector('[name="price"]').value = product.price;
                    document.querySelector('[name="categoryId"]').value = product.categoryId;
                    document.querySelector('[name="supplierId"]').value = product.supplierId;
                    document.querySelector('[name="stock"]').value = product.stock;
                    document.querySelector('[name="productDescription"]').value = product.productDescription;
                    
                    // Show preview if image exists
                    const preview = document.getElementById('preview');
                    const container = preview.parentElement;
                    if (product.productImg) {
                        preview.src = product.productImg;
                        container.classList.remove('d-none');
                    } else {
                        container.classList.add('d-none');
                    }
                    
                    // Show modal
                    const modal = new bootstrap.Modal(document.getElementById('productModal'));
                    modal.show();
                });
        }

        function deleteProduct(id) {
            if (confirm('Bạn có chắc muốn xóa sản phẩm này?')) {
                fetch(`admin-products/delete/${id}`, { method: 'POST' })
                    .then(response => {
                        if (response.ok) {
                            window.location.reload();
                        } else {
                            alert('Có lỗi xảy ra khi xóa sản phẩm');
                        }
                    });
            }
        }
    </script>
</body>
</html> 