<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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

        .status-badge.in-stock {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .status-badge.low-stock {
            background-color: #fef9c3;
            color: #ca8a04;
        }

        .status-badge.out-of-stock {
            background-color: #fee2e2;
            color: #dc2626;
        }

        /* Pagination styles (aligned with CustomerManagerAd.jsp) */
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

        /* Form styles (kept as is from product.jsp) */
        .form-label span {
            background: #f08632;
            color: white;
            padding: 2px 8px;
            border-radius: 5px;
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
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="text-center mb-4">
                    <img src="img/logo.png" alt="Cake Shop Logo" style="max-width: 150px" />
                </div>
                <nav class="nav flex-column">
                    <a class="nav-link" href="dashboard">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                    <a class="nav-link active" href="ProductServlet22">
                        <i class="fas fa-birthday-cake"></i>
                        <span>Quản lý Bánh</span>
                    </a>
                    <a class="nav-link" href="adminOrder">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Quản lý Đơn hàng</span>
                    </a>
                    <a class="nav-link" href="CustomerManagerAd">
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
                        <h2 class="header-title">Product</h2>
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
                        <!-- Nút Thêm Sản Phẩm -->
                        <button class="btn btn-primary my-3" onclick="showAddForm()">Thêm sản phẩm</button>

                        <!-- Form Thêm/Sửa Sản Phẩm -->
                        <div id="productForm" class="card p-4 mb-4 <%= request.getAttribute("product") != null ? "" : "d-none" %>" 
                            style="border-radius: 25px; box-shadow: 0 8px 25px rgba(240, 134, 50, 0.4); background: linear-gradient(135deg, #fff7f0 0%, #ffe8d6 50%, #fff 100%); border: 3px solid #f08632; position: relative; overflow: hidden;">
                            <!-- Hiệu ứng nền động -->
                            <div style="position: absolute; top: -50px; left: -50px; width: 150px; height: 150px; background: radial-gradient(circle, rgba(240, 134, 50, 0.2), transparent); border-radius: 50%;"></div>
                            <div style="position: absolute; bottom: -50px; right: -50px; width: 150px; height: 150px; background: radial-gradient(circle, rgba(240, 134, 50, 0.2), transparent); border-radius: 50%;"></div>

                            <h3 id="formTitle" class="mb-4 text-center" 
                                style="color: #f08632; font-weight: 900; font-size: 28px; text-shadow: 2px 2px 4px rgba(240, 134, 50, 0.5); position: relative; z-index: 1;">
                                <%= request.getAttribute("product") != null ? "Sửa Sản Phẩm" : "Thêm Sản Phẩm" %>
                            </h3>
                            <form action="products" method="post" enctype="multipart/form-data">
                                <input type="hidden" id="actionType" name="action" value="<%= request.getAttribute("product") != null ? "update" : "add" %>">
                                <input type="hidden" id="productId" name="productId" value="<%= request.getAttribute("product") != null ? ((Product)request.getAttribute("product")).getProductId() : "" %>">
                                <input type="hidden" id="currentImg" name="currentImg" value="<%= request.getAttribute("product") != null ? ((Product)request.getAttribute("product")).getProductImg() : "" %>">

                                <div class="row g-4" style="position: relative; z-index: 1;">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold d-flex align-items-center gap-2" 
                                            style="color: #cf6f29; text-transform: uppercase; font-size: 15px; letter-spacing: 1px;">
                                            <span>Tên</span> sản phẩm:
                                        </label>
                                        <input type="text" class="form-control" name="name" id="name" 
                                            value="<%= request.getAttribute("product") != null ? ((Product)request.getAttribute("product")).getName() : "" %>" 
                                            required 
                                            style="border-radius: 15px; border: 3px solid #f08632; background: #fff7f0; padding: 12px; font-size: 16px; transition: all 0.3s ease;"
                                            onfocus="this.style.borderColor='#cf6f29'; this.style.boxShadow='0 0 15px rgba(240, 134, 50, 0.6)';"
                                            onblur="this.style.borderColor='#f08632'; this.style.boxShadow='none';">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold d-flex align-items-center gap-2" 
                                            style="color: #cf6f29; text-transform: uppercase; font-size: 15px; letter-spacing: 1px;">
                                            <span>Giá</span>
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text" 
                                                style="background: linear-gradient(45deg, #f08632, #cf6f29); color: white; border-radius: 15px 0 0 15px; border: none; font-weight: bold;">VNĐ</span>
                                            <input type="number" step="0.01" class="form-control" name="price" id="price" 
                                                value="<%= request.getAttribute("product") != null ? ((Product)request.getAttribute("product")).getPrice() : "" %>" 
                                                required 
                                                style="border-radius: 0 15px 15px 0; border: 3px solid #f08632; border-left: none; background: #fff7f0; padding: 12px; font-size: 16px; transition: all 0.3s ease;"
                                                onfocus="this.style.borderColor='#cf6f29'; this.style.boxShadow='0 0 15px rgba(240, 134, 50, 0.6)';"
                                                onblur="this.style.borderColor='#f08632'; this.style.boxShadow='none';">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold d-flex align-items-center gap-2" 
                                            style="color: #cf6f29; text-transform: uppercase; font-size: 15px; letter-spacing: 1px;">
                                            <span>Số lượng</span>
                                        </label>
                                        <input type="number" class="form-control" name="stock" id="stock" 
                                            value="<%= request.getAttribute("product") != null ? ((Product)request.getAttribute("product")).getStock() : "" %>" 
                                            required 
                                            style="border-radius: 15px; border: 3px solid #f08632; background: #fff7f0; padding: 12px; font-size: 16px; transition: all 0.3s ease;"
                                            onfocus="this.style.borderColor='#cf6f29'; this.style.boxShadow='0 0 15px rgba(240, 134, 50, 0.6)';"
                                            onblur="this.style.borderColor='#f08632'; this.style.boxShadow='none';">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold d-flex align-items-center gap-2" 
                                            style="color: #cf6f29; text-transform: uppercase; font-size: 15px; letter-spacing: 1px;">
                                            <span>Danh mục</span>
                                        </label>
                                        <select class="form-control" name="categoryId" id="categoryId" required 
                                            style="border-radius: 15px; border: 3px solid #f08632; background: #fff7f0; color: #cf6f29; padding: 12px; font-size: 16px; transition: all 0.3s ease;"
                                            onfocus="this.style.borderColor='#cf6f29'; this.style.boxShadow='0 0 15px rgba(240, 134, 50, 0.6)';"
                                            onblur="this.style.borderColor='#f08632'; this.style.boxShadow='none';">
                                            <option value="1" <%= request.getAttribute("product") != null && ((Product)request.getAttribute("product")).getProductCategoryId() == 1 ? "selected" : "" %>>Cupcakes</option>
                                            <option value="2" <%= request.getAttribute("product") != null && ((Product)request.getAttribute("product")).getProductCategoryId() == 2 ? "selected" : "" %>>Cookies</option>
                                            <option value="3" <%= request.getAttribute("product") != null && ((Product)request.getAttribute("product")).getProductCategoryId() == 3 ? "selected" : "" %>>Cakes</option>
                                            <option value="4" <%= request.getAttribute("product") != null && ((Product)request.getAttribute("product")).getProductCategoryId() == 4 ? "selected" : "" %>>Pastries</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold d-flex align-items-center gap-2" 
                                            style="color: #cf6f29; text-transform: uppercase; font-size: 15px; letter-spacing: 1px;">
                                            <span>Nhà cung cấp</span>
                                        </label>
                                        <select class="form-control" name="supplierId" id="supplierId" required 
                                            style="border-radius: 15px; border: 3px solid #f08632; background: #fff7f0; color: #cf6f29; padding: 12px; font-size: 16px; transition: all 0.3s ease;"
                                            onfocus="this.style.borderColor='#cf6f29'; this.style.boxShadow='0 0 15px rgba(240, 134, 50, 0.6)';"
                                            onblur="this.style.borderColor='#f08632'; this.style.boxShadow='none';">
                                            <option value="1" <%= request.getAttribute("product") != null && ((Product)request.getAttribute("product")).getSupplierId() == 1 ? "selected" : "" %>>SweetTreats Supplies</option>
                                            <option value="2" <%= request.getAttribute("product") != null && ((Product)request.getAttribute("product")).getSupplierId() == 2 ? "selected" : "" %>>Baking Essentials Co.</option>
                                            <option value="3" <%= request.getAttribute("product") != null && ((Product)request.getAttribute("product")).getSupplierId() == 3 ? "selected" : "" %>>Cake Masters Ltd.</option>
                                            <option value="4" <%= request.getAttribute("product") != null && ((Product)request.getAttribute("product")).getSupplierId() == 4 ? "selected" : "" %>>Premium Ingredients Inc.</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold d-flex align-items-center gap-2" 
                                            style="color: #cf6f29; text-transform: uppercase; font-size: 15px; letter-spacing: 1px;">
                                            <span>Hình ảnh</span>
                                        </label>
                                        <input type="file" class="form-control" name="productImgFile" id="productImgFile" 
                                            accept="image/*" 
                                            style="border-radius: 15px; border: 3px solid #f08632; background: #fff7f0; padding: 12px; font-size: 16px; transition: all 0.3s ease;"
                                            onfocus="this.style.borderColor='#cf6f29'; this.style.boxShadow='0 0 15px rgba(240, 134, 50, 0.6)';"
                                            onblur="this.style.borderColor='#f08632'; this.style.boxShadow='none';">
                                        <% if (request.getAttribute("product") != null && ((Product)request.getAttribute("product")).getProductImg() != null) { %>
                                            <div class="mt-3 text-center">
                                                <img src="<%= ((Product)request.getAttribute("product")).getProductImg() %>" 
                                                    alt="Current Image" 
                                                    class="img-thumbnail" 
                                                    style="max-width: 150px; border-radius: 20px; border: 4px solid #f08632; box-shadow: 0 6px 15px rgba(240, 134, 50, 0.5); transition: transform 0.3s ease;"
                                                    onmouseover="this.style.transform='scale(1.1)';"
                                                    onmouseout="this.style.transform='scale(1)';">
                                            </div>
                                        <% } %>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-bold d-flex align-items-center gap-2" 
                                            style="color: #cf6f29; text-transform: uppercase; font-size: 15px; letter-spacing: 1px;">
                                            <span>Mô tả</span>
                                        </label>
                                        <textarea class="form-control" name="description" id="description" required 
                                            style="border-radius: 15px; border: 3px solid #f08632; background: #fff7f0; min-height: 150px; padding: 12px; font-size: 16px; transition: all 0.3s ease;"
                                            onfocus="this.style.borderColor='#cf6f29'; this.style.boxShadow='0 0 15px rgba(240, 134, 50, 0.6)';"
                                            onblur="this.style.borderColor='#f08632'; this.style.boxShadow='none';"><%= request.getAttribute("product") != null ? ((Product)request.getAttribute("product")).getDescription() : "" %></textarea>
                                    </div>
                                </div>

                                <div class="mt-5 d-flex justify-content-center gap-4" style="position: relative; z-index: 1;">
                                    <button type="submit" class="btn" 
                                        style="background: linear-gradient(45deg, #f08632, #cf6f29); border: none; border-radius: 20px; padding: 14px 40px; color: white; font-weight: bold; font-size: 18px; box-shadow: 0 6px 20px rgba(240, 134, 50, 0.6); transition: all 0.3s ease; position: relative; overflow: hidden;">
                                        <span style="position: relative; z-index: 1;">Lưu</span>
                                        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 0; height: 0; background: rgba(255, 255, 255, 0.3); border-radius: 50%; transition: all 0.5s ease;"></span>
                                        <script>
                                            this.onmouseover = function() { this.querySelector('span:nth-child(2)').style.width = '200px'; this.style.transform = 'scale(1.1)'; };
                                            this.onmouseout = function() { this.querySelector('span:nth-child(2)').style.width = '0'; this.style.transform = 'scale(1)'; };
                                        </script>
                                    </button>
                                    <button type="button" class="btn" onclick="hideForm()" 
                                        style="background: linear-gradient(45deg, #ffaa80, #f08632); border: none; border-radius: 20px; padding: 14px 40px; color: white; font-weight: bold; font-size: 18px; box-shadow: 0 6px 20px rgba(240, 134, 50, 0.6); transition: all 0.3s ease; position: relative; overflow: hidden;">
                                        <span style="position: relative; z-index: 1;">Hủy</span>
                                        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 0; height: 0; background: rgba(255, 255, 255, 0.3); border-radius: 50%; transition: all 0.5s ease;"></span>
                                        <script>
                                            this.onmouseover = function() { this.querySelector('span:nth-child(2)').style.width = '200px'; this.style.transform = 'scale(1.1)'; };
                                            this.onmouseout = function() { this.querySelector('span:nth-child(2)').style.width = '0'; this.style.transform = 'scale(1)'; };
                                        </script>
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Filter Tabs -->
                        <div class="filter-tabs">
                            <button class="tab active" onclick="filterProducts('all')">Tất cả</button>
                            <button class="tab" onclick="filterProducts('1')">Cupcakes</button>
                            <button class="tab" onclick="filterProducts('2')">Cookies</button>
                            <button class="tab" onclick="filterProducts('3')">Cakes</button>
                            <button class="tab" onclick="filterProducts('4')">Pastries</button>
                        </div>

                        <!-- Actions Container -->
                        <div class="actions-container">
                            <input type="text" class="search-bar" placeholder="Tìm kiếm sản phẩm..." onkeyup="searchProducts(this.value)">
                        </div>

                        <!-- Danh Sách Sản Phẩm -->
                        <div class="table-container">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0">Danh sách sản phẩm</h5>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover" id="productTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Trạng thái</th>
                                            <th>Mô tả</th>
                                            <th>Danh mục</th>
                                            <th>Nhà cung cấp</th>
                                            <th>Hình ảnh</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Product> productList = (List<Product>) request.getAttribute("productList");
                                            if (productList != null) {
                                                for (Product p : productList) {
                                                    String stockStatus = p.getStock() > 10 ? "in-stock" : (p.getStock() > 0 ? "low-stock" : "out-of-stock");
                                                    String stockLabel = p.getStock() > 10 ? "Còn hàng" : (p.getStock() > 0 ? "Sắp hết" : "Hết hàng");
                                                    String categoryName = "";
                                                    switch (p.getProductCategoryId()) {
                                                        case 1: categoryName = "Cupcakes"; break;
                                                        case 2: categoryName = "Cookies"; break;
                                                        case 3: categoryName = "Cakes"; break;
                                                        case 4: categoryName = "Pastries"; break;
                                                    }
                                                    String supplierName = "";
                                                    switch (p.getSupplierId()) {
                                                        case 1: supplierName = "SweetTreats Supplies"; break;
                                                        case 2: supplierName = "Baking Essentials Co."; break;
                                                        case 3: supplierName = "Cake Masters Ltd."; break;
                                                        case 4: supplierName = "Premium Ingredients Inc."; break;
                                                    }
                                        %>
                                        <tr data-category="<%= p.getProductCategoryId() %>">
                                            <td>#<%= p.getProductId() %></td>
                                            <td><%= p.getName() %></td>
                                            <td><fmt:formatNumber value="<%= p.getPrice() %>" type="number" pattern="#,##0.00"/>đ</td>
                                            <td><%= p.getStock() %></td>
                                            <td>
                                                <span class="status-badge <%= stockStatus %>">
                                                    <%= stockLabel %>
                                                </span>
                                            </td>
                                            <td><%= p.getDescription() %></td>
                                            <td><%= categoryName %></td>
                                            <td><%= supplierName %></td>
                                            <td><img src="<%= p.getProductImg() %>" width="50" alt="Product Image" style="border-radius: 8px;"></td>
                                            <td>
                                                <a href="products?action=edit&productId=<%= p.getProductId() %>" class="btn btn-warning btn-sm">Sửa</a>
                                                <a href="products?action=delete&productId=<%= p.getProductId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                            </td>
                                        </tr>
                                        <%      }
                                            } else { %>
                                        <tr>
                                            <td colspan="10" class="text-center">Không có sản phẩm nào.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Pagination (aligned with CustomerManagerAd.jsp) -->
                        <nav class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ProductServlet22?page=${currentPage - 1}">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/ProductServlet22?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ProductServlet22?page=${currentPage + 1}">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showAddForm() {
            document.getElementById("formTitle").innerText = "Thêm Sản Phẩm";
            document.getElementById("actionType").value = "add";
            document.getElementById("productForm").classList.remove("d-none");
            document.getElementById("productId").value = "";
            document.getElementById("name").value = "";
            document.getElementById("price").value = "";
            document.getElementById("stock").value = "";
            document.getElementById("description").value = "";
            document.getElementById("categoryId").value = "";
            document.getElementById("supplierId").value = "";
            document.getElementById("productImgFile").value = "";
            document.getElementById("currentImg").value = "";
        }

        function hideForm() {
            document.getElementById("productForm").classList.add("d-none");
        }

        function filterProducts(category) {
            const rows = document.querySelectorAll("#productTable tbody tr");
            const tabs = document.querySelectorAll(".filter-tabs .tab");

            // Update active tab
            tabs.forEach(tab => tab.classList.remove("active"));
            event.target.classList.add("active");

            // Filter rows
            rows.forEach(row => {
                const rowCategory = row.getAttribute("data-category");
                if (category === "all" || rowCategory === category) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

        function searchProducts(query) {
            const rows = document.querySelectorAll("#productTable tbody tr");
            query = query.toLowerCase();

            rows.forEach(row => {
                const name = row.cells[1].textContent.toLowerCase();
                if (name.includes(query)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
</body>
</html>