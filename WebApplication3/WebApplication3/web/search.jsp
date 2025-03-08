<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        .search-container {
            margin: 20px auto;
            width: 50%;
        }
        input[type="text"] {
            width: 70%;
            padding: 10px;
            font-size: 16px;
        }
        button {
            padding: 10px 15px;
            font-size: 16px;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .product-img {
            width: 50px;
            height: 50px;
        }
        .no-result {
            color: red;
            font-weight: bold;
        }
        .details-link {
            text-decoration: none;
            color: blue;
        }
    </style>
</head>
<body>

    <h2>Tìm kiếm sản phẩm</h2>

    <div class="search-container">
        <form action="searchne" method="GET">
            <input type="text" id="search-box" name="keyword" placeholder="Nhập tên sản phẩm..." required oninput="searchProductsByName(this.value)">
            <button type="submit">Tìm kiếm</button>
        </form>
    </div>

    <div id="search-results">
        <% 
            String keyword = (String) request.getAttribute("keyword");
            List<Product> productList = (List<Product>) request.getAttribute("productList");

            if (keyword != null) { 
        %>
            <h3>Kết quả tìm kiếm cho: "<%= keyword %>"</h3>

            <% if (productList == null || productList.isEmpty()) { %>
                <p class="no-result">Không tìm thấy sản phẩm nào.</p>
            <% } else { %>
                <table>
                    <tr>
                        <th>Hình ảnh</th>
                        <th>ID</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Mô tả</th>
                        <th>Chi tiết</th>
                    </tr>
                    <c:forEach var="p" items="${requestScope.productList}">
                        <tr>
                            <td><img src="${p.image}" class="product-img" alt="Hình ảnh sản phẩm"></td>
                            <td>${p.productID}</td>  <%-- Sửa từ ${p.id} thành ${p.productID} --%>
                            <td>${p.name}</td>
                            <td>${p.price}</td>
                            <td>${p.stock}</td>
                            <td>${p.description}</td>
                            <td><a href="shop-details.jsp?id=${p.productID}" class="details-link">Xem chi tiết</a></td> 
                        </tr>
                    </c:forEach>
                </table>
            <% } %>
        <% } %>
    </div>

    <script>
        function searchProductsByName(keyword) {
            if (keyword.length < 2) {
                document.getElementById("search-results").innerHTML = "";
                return;
            }
            
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "searchne?keyword=" + encodeURIComponent(keyword), true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("search-results").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>

</body>
</html>
