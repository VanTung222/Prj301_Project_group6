<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Product" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #f08632;
            --sidebar-width: 250px;
            --sidebar-bg: #2c3338;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        /* Sidebar */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--sidebar-bg);
            min-height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            padding-top: 20px;
        }

        .brand {
            display: flex;
            align-items: center;
            padding: 0 20px;
            margin-bottom: 30px;
        }

        .brand img {
            width: 40px;
            height: 40px;
        }

        .brand span {
            color: white;
            font-size: 24px;
            margin-left: 10px;
        }

        .nav-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .nav-item {
            margin-bottom: 5px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: all 0.3s;
        }

        .nav-link:hover,
        .nav-link.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border-left: 4px solid var(--primary-color);
        }

        .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
        }

        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .content-title {
            font-size: 24px;
            font-weight: 500;
            color: #333;
            margin: 0;
        }

        /* Table Styles */
        .table-container {
            background: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            background: #f8f9fa;
            color: #333;
            font-weight: 600;
            padding: 12px 16px;
            border-bottom: 1px solid #dee2e6;
            white-space: nowrap;
        }

        .table td {
            padding: 12px 16px;
            vertical-align: middle;
            border-bottom: 1px solid #dee2e6;
        }

        .product-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 500;
        }

        .status-pending {
            background: #fff3e0;
            color: #ef6c00;
        }

        .status-shipped {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-action {
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            transition: all 0.2s;
            text-decoration: none;
        }

        .btn-edit {
            background: #0d6efd;
            color: white;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
        }

        .btn-add-new {
            background: #0d6efd;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }

        .btn-action:hover,
        .btn-add-new:hover {
            opacity: 0.9;
            transform: translateY(-1px);
            color: white;
        }

        /* Form Styles */
        .form-container {
            background: white;
            padding: 24px;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .form-container h3 {
            margin-bottom: 20px;
            color: #333;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(240, 134, 50, 0.25);
        }

        .btn-submit {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-submit:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="brand">
            <img src="img/cupcake-logo.png" alt="Logo">
            <span>Cake</span>
        </div>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="dashboard" class="nav-link">
                    <i class="fas fa-home"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a href="products" class="nav-link active">
                    <i class="fas fa-box"></i>
                    Quản lý sản phẩm
                </a>
            </li>
            <li class="nav-item">
                <a href="orders" class="nav-link">
                    <i class="fas fa-shopping-cart"></i>
                    Quản lý đơn hàng
                </a>
            </li>
            <li class="nav-item">
                <a href="customers" class="nav-link">
                    <i class="fas fa-users"></i>
                    Quản lý khách hàng
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="content-header">
            <h1 class="content-title">Quản lý sản phẩm</h1>
        </div>

        <!-- Form Thêm/Sửa Sản Phẩm -->
        <div class="form-container">
            <h3><% if (request.getAttribute("product") != null) { %>Sửa Sản Phẩm<% } else { %>Thêm Sản Phẩm<% } %></h3>
            <form action="products" method="post">
                <input type="hidden" name="action" value="<%= (request.getAttribute("product") != null) ? "update" : "add" %>">
                <% Product product = (Product) request.getAttribute("product"); %>
                <% if (product != null) { %>
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                <% } %>

                <div class="form-group">
                    <label class="form-label">Tên sản phẩm</label>
                    <input type="text" class="form-control" name="name" value="<%= (product != null) ? product.getName() : "" %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Giá</label>
                    <input type="number" step="0.01" class="form-control" name="price" value="<%= (product != null) ? product.getPrice() : "" %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Số lượng</label>
                    <input type="number" class="form-control" name="stock" value="<%= (product != null) ? product.getStock() : "" %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Mô tả</label>
                    <textarea class="form-control" name="description" rows="3" required><%= (product != null) ? product.getDescription() : "" %></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">Danh mục</label>
                    <input type="number" class="form-control" name="categoryId" value="<%= (product != null) ? product.getProductId() : "" %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Nhà cung cấp</label>
                    <input type="number" class="form-control" name="supplierId" value="<%= (product != null) ? product.getSupplierId() : "" %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Hình ảnh</label>
                    <input type="text" class="form-control" name="productImg" value="<%= (product != null) ? product.getProductImg() : "" %>">
                </div>

                <button type="submit" class="btn-submit">
                    <%= (product != null) ? "Cập Nhật" : "Thêm Mới" %>
                </button>
            </form>
        </div>

        <!-- Danh Sách Sản Phẩm -->
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tên</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Mô tả</th>
                        <th>Danh mục</th>
                        <th>Nhà cung cấp</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Product> productList = (List<Product>) request.getAttribute("productList");
                        if (productList != null) {
                            for (Product p : productList) {
                    %>
                    <tr>
                        <td><%= p.getProductId() %></td>
                        <td><img src="<%= p.getProductImg() %>" class="product-img" alt=""></td>
                        <td><%= p.getName() %></td>
                        <td><%= p.getPrice() %></td>
                        <td>
                            <span class="status-badge <%= p.getStock() > 0 ? "status-shipped" : "status-pending" %>">
                                <%= p.getStock() > 0 ? "Còn hàng (" + p.getStock() + ")" : "Hết hàng" %>
                            </span>
                        </td>
                        <td><%= p.getDescription() %></td>
                        <td><%= p.getProductCategoryId() %></td>
                        <td><%= p.getSupplierId() %></td>
                        <td>
                            <div class="action-buttons">
                                <a href="products?action=edit&productId=<%= p.getProductId() %>" class="btn-action btn-edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="products?action=delete&productId=<%= p.getProductId() %>" 
                                   onclick="return confirm('Bạn có chắc muốn xóa?')" 
                                   class="btn-action btn-delete">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 