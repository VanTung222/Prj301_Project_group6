<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    Customer currentUser = (sessionObj != null) ? (Customer) sessionObj.getAttribute("loggedInUser") : null;

    if (currentUser == null) {
        response.sendRedirect("index.jsp"); // Nếu chưa đăng nhập, quay lại trang chủ
        return;
    }

    String successMessage = (String) sessionObj.getAttribute("successMessage");
    String errorMessage = (String) sessionObj.getAttribute("errorMessage");
    sessionObj.removeAttribute("successMessage");
    sessionObj.removeAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa hồ sơ</title>
</head>
<body>
    <h2>Chỉnh sửa hồ sơ</h2>

    <% if (successMessage != null) { %>
        <p style="color: green;"><%= successMessage %></p>
    <% } %>
    <% if (errorMessage != null) { %>
        <p style="color: red;"><%= errorMessage %></p>
    <% } %>

    <form action="editProfile" method="post">
        <label>Email:</label>
        <input type="email" name="email" value="<%= currentUser.getEmail() %>" required><br>

        <label>Họ:</label>
        <input type="text" name="firstName" value="<%= currentUser.getFirstName() %>"><br>

        <label>Tên:</label>
        <input type="text" name="lastName" value="<%= currentUser.getLastName() %>"><br>

        <label>Địa chỉ:</label>
        <input type="text" name="address" value="<%= currentUser.getAddress() %>"><br>

        <label>Số điện thoại:</label>
        <input type="text" name="phone" value="<%= currentUser.getPhone() %>"><br>

        <input type="submit" value="Cập nhật">
    </form>

    <a href="index.jsp">Quay lại trang chủ</a>
</body>
</html>
