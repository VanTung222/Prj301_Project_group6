<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            display: flex;
            background-color: #f8f9fa;
        }
        /* Sidebar */
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #343a40;
            color: white;
            padding-top: 20px;
            position: fixed;
        }
        .sidebar h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
        }
        .sidebar ul li {
            padding: 15px 20px;
            cursor: pointer;
            border-bottom: 1px solid #474f57;
        }
        .sidebar ul li:hover {
            background: #495057;
        }
        .sidebar ul li a {
            color: white;
            text-decoration: none;
            display: block;
        }
        /* Main content */
        .main-content {
            margin-left: 250px;
            width: calc(100% - 250px);
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 15px 20px;
            border-radius: 5px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .add-product-btn {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .add-product-btn:hover {
            background-color: #218838;
        }
        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #343a40;
            color: white;
        }
        .product-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .action-buttons button {
            margin: 5px;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .edit-btn {
            background-color: #007bff;
            color: white;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
        }
        .edit-btn:hover {
            background-color: #0056b3;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Quản lý</h2>
        <ul>
            <li><a href="dashboard.jsp">Dashboard</a></li>
           
            <li><a href="customers.jsp">Customers</a></li>
          
       
        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <div class="header">
            <h1>Quản lý sản phẩm</h1>
            <button class="add-product-btn">Thêm sản phẩm</button>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Hình ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th>Mô tả</th>
                    <th>Giá (VND)</th>
                    <th>Kho hàng</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Product> productList = (List<Product>) request.getAttribute("productList");
                    if (productList != null && !productList.isEmpty()) {
                        for (Product product : productList) {
                %>
                <tr>
                    <td><%= product.getProductId() %></td>
                    <td>
                        <img src="<%= product.getProductImg() != null ? product.getProductImg() : "default.jpg" %>" 
                             alt="<%= product.getName() %>" class="product-img">
                    </td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getDescription() %></td>
                    <td><strong><%= product.getPrice() %></strong></td>
                    <td><%= product.getStock() %></td>
                    <td class="action-buttons">
                        <button class="edit-btn">Sửa</button>
                        <button class="delete-btn">Xoá</button>
                    </td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="7">Không có sản phẩm nào.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>