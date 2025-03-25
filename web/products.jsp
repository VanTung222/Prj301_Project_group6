
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <style>
         :root {
        --primary-color: #f08632;
        --secondary-color: #cf6f29;
        --dark-color: #343a40;
      }
    /* Sidebar */
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
      .stat-card {
        border: none;
        border-radius: 15px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s, box-shadow 0.3s;
        background: white;
      }
      .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
      }
      .stat-card .icon {
        font-size: 2.5rem;
        color: var(--primary-color);
      }
      .chart-container {
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
      .table-container {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
</style>

  <div class="container-fluid">
      <div class="row">
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
                        <a class="nav-link  active" href="${pageContext.request.contextPath}/ProductServlet22">
                            <i class="fas fa-birthday-cake me-2"></i> Quản lý Bánh
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/adminOrder">
                            <i class="fas fa-shopping-cart me-2"></i> Quản lý Đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/CustomerManagerAd">
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
        <div id="productForm" class="card p-3 mb-4 d-none">
            <h3 id="formTitle">Thêm Sản Phẩm</h3>
            <form action="ProductController" method="post">
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
                        <a href="ProductController?action=delete&productId=<%= p.getProductId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
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