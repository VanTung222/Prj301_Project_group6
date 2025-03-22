<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        /* Sidebar */
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #343a40;
            color: white;
            position: fixed;
            padding-top: 20px;
            left: 0;
            top: 0;
        }
        .sidebar a {
            color: white;
            display: block;
            padding: 10px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background: #495057;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3 class="text-center"> Cake</h3>
    <a href="dashboard.jsp"> Dashboard</a>
    <a href="quanlybanh.jsp"> Quản lý Bánh</a>
    <a href="quanlydonhang.jsp"> Quản lý Đơn hàng</a>
    <a href="quanlykhachhang.jsp"> Quản lý Khách hàng</a>
    <a href="baocaothongke.jsp"> Báo cáo & Thống kê</a>
</div>

<!-- Nội dung chính -->
<div class="content">
    <div class="container mt-4">
        <h2 class="text-center">Quản lý sản phẩm</h2>

        <!-- Nút Thêm Sản Phẩm -->
        <button class="btn btn-primary my-3" onclick="showAddForm()">Thêm sản phẩm</button>

        <!-- Form Thêm/Sửa Sản Phẩm -->
        <div id="productForm" class="card p-3 mb-4 d-none">
            <h3 id="formTitle">Thêm Sản Phẩm</h3>
            <form action="products" method="post">
                <input type="hidden" id="actionType" name="action" value="add">
                <input type="hidden" id="productId" name="productId">

                <div class="mb-2">
                    <label class="form-label">Tên sản phẩm:</label>
                    <input type="text" class="form-control" name="name" id="name" required>
                </div>

                <div class="mb-2">
                    <label class="form-label">Giá:</label>
                    <input type="number" step="0.01" class="form-control" name="price" id="price" required>
                </div>

                <div class="mb-2">
                    <label class="form-label">Số lượng:</label>
                    <input type="number" class="form-control" name="stock" id="stock" required>
                </div>

                <div class="mb-2">
                    <label class="form-label">Mô tả:</label>
                    <textarea class="form-control" name="description" id="description" required></textarea>
                </div>

                <div class="mb-2">
                    <label class="form-label">Danh mục:</label>
                    <input type="number" class="form-control" name="categoryId" id="categoryId" required>
                </div>

                <div class="mb-2">
                    <label class="form-label">Nhà cung cấp:</label>
                    <input type="number" class="form-control" name="supplierId" id="supplierId" required>
                </div>

                <div class="mb-2">
                    <label class="form-label">Hình ảnh:</label>
                    <input type="text" class="form-control" name="productImg" id="productImg">
                </div>

                <button type="submit" class="btn btn-success">Lưu</button>
                <button type="button" class="btn btn-secondary" onclick="hideForm()">Hủy</button>
            </form>
        </div>

        <!-- Danh Sách Sản Phẩm -->
        <h3>Danh Sách Sản Phẩm</h3>
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
                    <td><img src="<%= p.getProductImg() %>" width="50"></td>
                    <td>
                        <button class="btn btn-warning btn-sm" onclick="editProduct('<%= p.getProductId() %>', '<%= p.getName() %>', '<%= p.getPrice() %>', '<%= p.getStock() %>', '<%= p.getDescription() %>', '<%= p.getProductCategoryId() %>', '<%= p.getSupplierId() %>', '<%= p.getProductImg() %>')">Sửa</button>
                        <a href="products?action=delete&productId=<%= p.getProductId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                    </td>
                </tr>
                <%  } } %>
            </tbody>
        </table>
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
        document.getElementById("productImg").value = "";
    }

    function editProduct(id, name, price, stock, description, categoryId, supplierId, img) {
        document.getElementById("formTitle").innerText = "Sửa Sản Phẩm";
        document.getElementById("actionType").value = "update";
        document.getElementById("productId").value = id;
        document.getElementById("name").value = name;
        document.getElementById("price").value = price;
        document.getElementById("stock").value = stock;
        document.getElementById("description").value = description;
        document.getElementById("categoryId").value = categoryId;
        document.getElementById("supplierId").value = supplierId;
        document.getElementById("productImg").value = img;

        document.getElementById("productForm").classList.remove("d-none");
    }

    function hideForm() {
        document.getElementById("productForm").classList.add("d-none");
    }
</script>

</body>
</html>
