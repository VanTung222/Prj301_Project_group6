<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Product" %>
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
        }
        .sidebar {
            min-height: 100vh;
            background-color: var(--dark-color);
            padding-top: 20px;
        }
        .sidebar .nav-link {
            color: #fff;
            padding: 12px 20px;
            margin: 8px 0;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .sidebar .nav-link:hover {
            background-color: var(--primary-color);
            transform: translateX(5px);
        }
        .sidebar .nav-link.active {
            background-color: var(--primary-color);
        }
        .main-content {
            padding: 20px;
            background-color: #f8f9fa;
        }
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .user-info {
            background: white;
            padding: 10px 20px;
            border-radius: 30px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="text-center mb-4">
                    <img src="img/logo.png" alt="Cake Shop Logo" style="max-width: 150px" />
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link " href="dashboard">
                            <i class="fas fa-chart-line me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="products">
                            <i class="fas fa-birthday-cake me-2"></i> Quản lý Bánh
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="adminOrder">
                            <i class="fas fa-shopping-cart me-2"></i> Quản lý Đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="CustomerManagerAd">
                            <i class="fas fa-users me-2"></i> Quản lý Khách hàng
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Dashboard</h2>
                    <div class="user-info">
                        <span class="me-3">Xin chào, ${sessionScope.username}</span>
                        <a href="LogoutServlet" class="btn btn-outline-danger btn-sm">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </div>
                </div>

                <!-- Nội dung chính -->
                <div class="content">
                    <div class="container mt-4">
                        <h2 class="text-center">Quản lý sản phẩm</h2>

                        <!-- Nút Thêm Sản Phẩm -->
                        <button class="btn btn-primary my-3" onclick="showAddForm()">Thêm sản phẩm</button>

                        <!-- Form Thêm/Sửa Sản Phẩm -->
                      <!-- Form Thêm/Sửa Sản Phẩm --><!-- Form Thêm/Sửa Sản Phẩm -->
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
                    <span style="background: #f08632; color: white; padding: 2px 8px; border-radius: 5px;">Tên</span> sản phẩm:
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
                    <span style="background: #f08632; color: white; padding: 2px 8px; border-radius: 5px;">Giá</span>
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
                    <span style="background: #f08632; color: white; padding: 2px 8px; border-radius: 5px;">Số lượng</span>
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
                    <span style="background: #f08632; color: white; padding: 2px 8px; border-radius: 5px;">Danh mục</span>
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
                    <span style="background: #f08632; color: white; padding: 2px 8px; border-radius: 5px;">Nhà cung cấp</span>
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
                    <span style="background: #f08632; color: white; padding: 2px 8px; border-radius: 5px;">Hình ảnh</span>
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
                    <span style="background: #f08632; color: white; padding: 2px 8px; border-radius: 5px;">Mô tả</span>
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
                        <!-- Danh Sách Sản Phẩm -->
                        <h3>Danh Sách Sản Phẩm</h3>
                        <div class="table-container">
                            <table class="table table-bordered">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
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
                                    %>
                                    <tr>
                                        <td><%= p.getProductId() %></td>
                                        <td><%= p.getName() %></td>
                                        <td><%= p.getPrice() %></td>
                                        <td><%= p.getStock() %></td>
                                        <td><%= p.getDescription() %></td>
                                        <td><%= p.getProductCategoryId() %></td>
                                        <td><%= p.getSupplierId() %></td>
                                        <td><img src="<%= p.getProductImg() %>" width="50" alt="Product Image"></td>
                                        <td>
                                            <a href="products?action=edit&productId=<%= p.getProductId() %>" class="btn btn-warning btn-sm">Sửa</a>
                                            <a href="products?action=delete&productId=<%= p.getProductId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                        </td>
                                    </tr>
                                    <%      }
                                        } %>
                                </tbody>
                            </table>
                        </div>
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
    </script>
</body>
</html>