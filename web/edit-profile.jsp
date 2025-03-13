<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Customer" %>
<% 
    // Check session
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("customer") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get customer information from request attributes
    Customer customer = (Customer) request.getAttribute("customer");
    if (customer == null) {
        request.setAttribute("error", "Không thể tải thông tin khách hàng để chỉnh sửa");
        request.getRequestDispatcher("profile.jsp").forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Chỉnh sửa thông tin cá nhân</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <style>
        .edit-profile-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 3rem 0;
        }
        .profile-picture-container {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto 2rem;
        }
        .profile-picture {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .edit-picture-overlay {
            position: absolute;
            bottom: 0;
            right: 0;
            background: #fff;
            border-radius: 50%;
            padding: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            cursor: pointer;
        }
        .form-label {
            font-weight: 500;
        }
        .required::after {
            content: "*";
            color: red;
            margin-left: 4px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />

    <div class="edit-profile-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow">
                        <div class="card-body">
                            <h3 class="card-title text-center mb-4">Chỉnh sửa thông tin cá nhân</h3>

                            <% String error = (String) request.getAttribute("error");
                               if (error != null) { %>
                            <div class="alert alert-danger"><%= error %></div>
                            <% } %>

                            <!-- Profile Picture -->
                            <div class="profile-picture-container">
                                <img src="<%= customer.getProfilePicture() != null ? customer.getProfilePicture() : "img/default-avatar.jpg" %>"
                                    alt="Profile Picture" class="profile-picture">
                                <label for="profilePicture" class="edit-picture-overlay">
                                    <i class="bi bi-camera"></i>
                                </label>
                                <input type="file" id="profilePicture" name="profilePicture" accept="image/*" style="display: none" />
                            </div>

                            <!-- Edit Form -->
                            <form action="UpdateProfileServlet" method="post" class="needs-validation" novalidate enctype="multipart/form-data">
                                <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                                <div class="row g-3">
                                    <!-- Username -->
                                    <div class="col-md-6">
                                        <label for="username" class="form-label required">Tên đăng nhập</label>
                                        <input type="text" class="form-control" id="username" name="username"
                                            value="<%= customer.getUsername() %>" required readonly />
                                        <div class="invalid-feedback">Vui lòng nhập tên đăng nhập</div>
                                    </div>

                                    <!-- Email -->
                                    <div class="col-md-6">
                                        <label for="email" class="form-label required">Email</label>
                                        <input type="email" class="form-control" id="email" name="email"
                                            value="<%= customer.getEmail() %>" required />
                                        <div class="invalid-feedback">Vui lòng nhập email hợp lệ</div>
                                    </div>

                                    <!-- First Name -->
                                    <div class="col-md-6">
                                        <label for="firstName" class="form-label required">Họ</label>
                                        <input type="text" class="form-control" id="firstName" name="firstName"
                                            value="<%= customer.getFirstName() != null ? customer.getFirstName() : "" %>" required />
                                        <div class="invalid-feedback">Vui lòng nhập họ</div>
                                    </div>

                                    <!-- Last Name -->
                                    <div class="col-md-6">
                                        <label for="lastName" class="form-label required">Tên</label>
                                        <input type="text" class="form-control" id="lastName" name="lastName"
                                            value="<%= customer.getLastName() != null ? customer.getLastName() : "" %>" required />
                                        <div class="invalid-feedback">Vui lòng nhập tên</div>
                                    </div>

                                    <!-- Phone -->
                                    <div class="col-md-6">
                                        <label for="phone" class="form-label required">Số điện thoại</label>
                                        <input type="tel" class="form-control" id="phone" name="phone"
                                            value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>" pattern="[0-9]{10}" required />
                                        <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ (10 số)</div>
                                    </div>

                                    <!-- Address -->
                                    <div class="col-12">
                                        <label for="address" class="form-label">Địa chỉ</label>
                                        <textarea class="form-control" id="address" name="address" rows="3"><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
                                    </div>

                                    <!-- Password -->
                                    <div class="col-md-6">
                                        <label for="password" class="form-label">Mật khẩu mới</label>
                                        <input type="password" class="form-control" id="password" name="password" minlength="6" />
                                        <div class="form-text">Để trống nếu không muốn thay đổi mật khẩu</div>
                                    </div>

                                    <!-- Confirm Password -->
                                    <div class="col-md-6">
                                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" minlength="6" />
                                        <div class="invalid-feedback">Mật khẩu xác nhận không khớp</div>
                                    </div>

                                    <!-- Submit Buttons -->
                                    <div class="col-12 text-center mt-4">
                                        <button type="submit" class="btn btn-primary me-2">
                                            <i class="bi bi-check-circle me-2"></i>Lưu thay đổi
                                        </button>
                                        <a href="profile" class="btn btn-secondary">
                                            <i class="bi bi-x-circle me-2"></i>Hủy
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script>
        // Form validation
        (function () {
            "use strict";
            const forms = document.querySelectorAll(".needs-validation");
            Array.from(forms).forEach((form) => {
                form.addEventListener("submit", (event) => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }

                    const password = form.querySelector("#password");
                    const confirmPassword = form.querySelector("#confirmPassword");
                    if (password.value && password.value !== confirmPassword.value) {
                        confirmPassword.setCustomValidity("Passwords do not match");
                        event.preventDefault();
                        event.stopPropagation();
                    } else {
                        confirmPassword.setCustomValidity("");
                    }

                    form.classList.add("was-validated");
                }, false);
            });
        })();

        // Profile picture preview
        document.getElementById("profilePicture").addEventListener("change", function (e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    document.querySelector(".profile-picture").src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
</body>
</html>