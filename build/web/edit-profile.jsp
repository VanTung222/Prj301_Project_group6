<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    // Kiểm tra session
    if (session.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = Integer.parseInt(session.getAttribute("id").toString());
    String username = "";
    String email = "";
    String fullName = "";

    // Kết nối database
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Sử dụng SQL Server JDBC Driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection("jdbc:sqlserver://LAPTOP-CGID9TIO;databaseName=managementSignUpz", "sa", "123");

        // Truy vấn lấy thông tin user
        String sql = "SELECT username, fullName, email FROM Users WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            username = rs.getString("username");
            fullName = rs.getString("fullName");
            email = rs.getString("email");

            // Cập nhật session để sử dụng ở các trang khác
            session.setAttribute("username", username);
            session.setAttribute("fullName", fullName);
            session.setAttribute("email", email);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
    if (rs != null) rs.close();
} catch (SQLException e) { e.printStackTrace(); }
try {
    if (pstmt != null) pstmt.close();
} catch (SQLException e) { e.printStackTrace(); }
try {
    if (conn != null) conn.close();
} catch (SQLException e) { e.printStackTrace(); }

    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa hồ sơ</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    </head>
    <body>

        <!-- 🔹 Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold text-primary" href="index.jsp">
                    <img src="assets/logo.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top">
                    Xin chào, <span class="text-danger fw-bold"><%= fullName %></span>!
                </a>      
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="profile.jsp"><i class="bi bi-person-circle"></i> Hồ sơ</a></li>
                        <li class="nav-item"><a class="nav-link" href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- 🔹 Nội dung chính -->
        <div class="container mt-4">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h2 class="text-center">Chỉnh sửa hồ sơ</h2>
                    <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">

                        <!-- Avatar -->
                        <div class="text-center mb-3">
                            <img src="assets/avatar.jpg" alt="Avatar" class="rounded-circle" width="100" height="100">
                            <div class="mt-2">
                                <label class="btn btn-outline-secondary btn-sm">
                                    <input type="file" name="avatar" accept="image/*" hidden>
                                    <i class="bi bi-upload"></i> Chọn ảnh mới
                                </label>
                            </div>
                        </div>

                        <!-- Họ tên -->
                        <div class="mb-3">
                            <label class="form-label">Họ và tên:</label>
                            <input type="text" name="fullName" class="form-control" value="<%= fullName %>" required>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Email:</label>
                            <input type="email" name="email" class="form-control" value="<%= email %>" required>
                        </div>

                        <!-- Mật khẩu -->
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu mới:</label>
                            <input type="password" name="password" class="form-control" placeholder="Để trống nếu không thay đổi">
                        </div>

                        <!-- Nút Lưu -->
                        <div class="text-center">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-save"></i> Lưu thay đổi
                            </button>
                            <a href="profile.jsp" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Quay lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
