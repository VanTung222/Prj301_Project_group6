<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, model.Customer, java.util.*" %>
<%@page import="model.Product"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Review" %>
<%@ page import="controller.ReviewServlet" %>




<%
    // Check session
    HttpSession sessionObj = request.getSession(false);

    if (sessionObj == null || sessionObj.getAttribute("customer") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get customer from session
    Customer customer = (Customer) sessionObj.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("login.jsp");
        return;
    }
        Customer currentUser = (sessionObj != null) ? (Customer) sessionObj.getAttribute("loggedInUser") : null;
    // Get customer info
    String username = customer.getUsername();
    String email = customer.getEmail();
    String firstName = customer.getFirstName() != null ? customer.getFirstName() : "";
    String lastName = customer.getLastName() != null ? customer.getLastName() : "";
    String fullName = customer.getFullName();
    String address = customer.getAddress() != null ? customer.getAddress() : "Chưa cập nhật";
    String phone = customer.getPhone() != null ? customer.getPhone() : "Chưa cập nhật";
    String profilePicture = customer.getProfilePicture() != null ? customer.getProfilePicture() : "img/default-avatar.jpg";

    // Get order statistics and recent orders
    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Integer completedOrders = (Integer) request.getAttribute("completedOrders");
    Integer processingOrders = (Integer) request.getAttribute("processingOrders");
    List<Map<String, Object>> recentOrders = (List<Map<String, Object>>) request.getAttribute("recentOrders");
    ResultSet favoriteProducts = (ResultSet) request.getAttribute("favoriteProducts");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

    // Get error or success message
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Thông tin cá nhân - <%= fullName%></title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f8f9fa;
            }

            .profile-header {
                background: linear-gradient(135deg, #F08632 0%, #969696 100%);
                padding: 3rem 0;
                margin-bottom: 2rem;
                color: white;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .profile-picture {
                width: 180px;
                height: 180px;
                border-radius: 50%;
                object-fit: cover;
                border: 5px solid rgba(255, 255, 255, 0.3);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease;
            }

            .profile-picture:hover {
                transform: scale(1.05);
            }

            .stat-card, .info-card, .order-card {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
                border: none;
            }

            .stat-card:hover, .info-card:hover, .order-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            }

            .card-title {
                color: #2c3e50;
                font-weight: 600;
                margin-bottom: 1.5rem;
                border-bottom: 2px solid #e9ecef;
                padding-bottom: 0.75rem;
            }

            .info-label {
                font-weight: 500;
                color: #6c757d;
            }

            .info-value {
                color: #2c3e50;
                font-weight: 400;
            }

            .icon-shape {
                width: 50px;
                height: 50px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 12px;
            }

            .bg-gradient-primary {
                background: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%);
            }

            .bg-gradient-success {
                background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            }

            .bg-gradient-warning {
                background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
            }

            .order-status {
                padding: 0.4rem 1rem;
                border-radius: 20px;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .status-completed {
                background-color: #d4f8e5;
                color: #0d6832;
            }

            .status-processing {
                background-color: #fff3cd;
                color: #856404;
            }

            .btn {
                padding: 0.6rem 1.2rem;
                border-radius: 10px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-primary {
                background: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%);
                border: none;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0, 13, 255, 0.3);
            }

            .btn-danger {
                background: linear-gradient(135deg, #FF6B6B 0%, #FF0000 100%);
                border: none;
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(255, 0, 0, 0.3);
            }

            .table {
                border-radius: 10px;
                overflow: hidden;
            }

            .table thead th {
                background-color: #f8f9fa;
                border-bottom: 2px solid #e9ecef;
                color: #6c757d;
                font-weight: 500;
            }

            .table tbody td {
                vertical-align: middle;
                color: #2c3e50;
            }

            .edit-form-container {
                display: none;
                animation: fadeIn 0.3s ease;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(-10px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .form-control {
                border-radius: 10px;
                border: 1px solid #e9ecef;
                padding: 0.75rem 1rem;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #6B73FF;
                box-shadow: 0 0 0 0.2rem rgba(107, 115, 255, 0.25);
            }

            .invalid-feedback {
                color: #dc3545;
                font-size: 0.875rem;
                margin-top: 0.25rem;
            }
        </style>
    </head>
    <body>
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-3 text-center">
                        <div class="position-relative d-inline-block">
                            <img src="<%= profilePicture%>" alt="Profile Picture" class="profile-picture mb-3" />
                            <div class="profile-picture-overlay">
                                <i class="bi bi-camera-fill"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <h2 class="display-4 fw-bold mb-2"><%= fullName%></h2>
                        <p class="text-white-50 fs-5 mb-3">
                            <i class="bi bi-envelope-fill me-2"></i><%= email%>
                        </p>
                        <p class="text-white-50 fs-5 mb-4">
                            <i class="bi bi-telephone-fill me-2"></i><%= phone%>
                        </p>
                        <div class="d-flex gap-3 flex-wrap" id="profile-actions">
                            <a href="index.jsp" class="btn btn-light btn-lg">
                                <i class="bi bi-house-door-fill me-2"></i>Trở về trang chủ
                            </a>
                            <button type="button" class="btn btn-light btn-lg" onclick="toggleEditForm()">
                                <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa thông tin
                            </button>
                            <form action="LogoutServlet" method="post" style="margin: 0;">
                                <button type="submit" class="btn btn-danger btn-lg" onclick="return confirm('Bạn có chắc muốn đăng xuất?');">
                                    <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container mb-5">
            <div class="row">
                <!-- Statistics Cards -->
                <div class="col-md-4">
                    <div class="stat-card">
                        <h5 class="card-title">
                            <i class="bi bi-graph-up me-2"></i>Thống kê đơn hàng
                        </h5>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="d-flex align-items-center">
                                <div class="icon-shape bg-gradient-primary text-white">
                                    <i class="bi bi-cart-fill"></i>
                                </div>
                                <div class="ms-3">
                                    <h6 class="mb-0 text-uppercase fw-bold">Tổng đơn hàng</h6>
                                    <span class="text-primary fs-4 fw-bold"><%= totalOrders != null ? totalOrders : 0%></span>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="d-flex align-items-center">
                                <div class="icon-shape bg-gradient-success text-white">
                                    <i class="bi bi-check-circle-fill"></i>
                                </div>
                                <div class="ms-3">
                                    <h6 class="mb-0 text-uppercase fw-bold">Đã hoàn thành</h6>
                                    <span class="text-success fs-4 fw-bold"><%= completedOrders != null ? completedOrders : 0%></span>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <div class="icon-shape bg-gradient-warning text-white">
                                    <i class="bi bi-clock-fill"></i>
                                </div>
                                <div class="ms-3">
                                    <h6 class="mb-0 text-uppercase fw-bold">Đang xử lý</h6>
                                    <span class="text-warning fs-4 fw-bold"><%= processingOrders != null ? processingOrders : 0%></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Personal Information and Orders -->
                <div class="col-md-8">
                    <!-- View Mode -->
                    <div class="info-card mb-4" id="view-mode">
                        <h5 class="card-title">
                            <i class="bi bi-person-circle me-2"></i>Thông tin cá nhân
                        </h5>
                        <% if (success != null) {%>
                        <div class="alert alert-success">
                            <i class="bi bi-check-circle-fill me-2"></i><%= success%>
                        </div>
                        <% } %>
                        <% if (error != null) {%>
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-circle-fill me-2"></i><%= error%>
                        </div>
                        <% }%>

                        <div class="info-grid">
                            <div class="info-item">
                                <p class="info-label">
                                    <i class="bi bi-person-badge me-2"></i>Tên đăng nhập
                                </p>
                                <p class="info-value"><%= username%></p>
                            </div>
                            <div class="info-item">
                                <p class="info-label">
                                    <i class="bi bi-person me-2"></i>Họ và tên
                                </p>
                                <p class="info-value"><%= fullName%></p>
                            </div>
                            <div class="info-item">
                                <p class="info-label">
                                    <i class="bi bi-envelope me-2"></i>Email
                                </p>
                                <p class="info-value"><%= email%></p>
                            </div>
                            <div class="info-item">
                                <p class="info-label">
                                    <i class="bi bi-telephone me-2"></i>Số điện thoại
                                </p>
                                <p class="info-value"><%= phone%></p>
                            </div>
                            <div class="info-item">
                                <p class="info-label">
                                    <i class="bi bi-geo-alt me-2"></i>Địa chỉ
                                </p>
                                <p class="info-value"><%= address%></p>
                            </div>
                        </div>
                    </div>

                    <!-- Edit Mode -->
                    <div class="info-card mb-4 edit-form-container" id="edit-mode">
                        <h5 class="card-title mb-4">Chỉnh sửa thông tin cá nhân</h5>
                        <form action="editProfile" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="action" value="update-profile" />
                            <input type="hidden" name="customerId" value="<%= customer.getCustomerId()%>" />

                            <div class="row mb-3">
                                <div class="col-sm-3"><label class="info-label mb-0">Tên đăng nhập</label></div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" value="<%= username%>" readonly disabled />
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-3"><label class="info-label mb-0">Email <span class="text-danger">*</span></label></div>
                                <div class="col-sm-9">
                                  <input type="email" name="email" value="<%= currentUser.getEmail() %>" required><br>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-3"><label class="info-label mb-0">Họ <span class="text-danger">*</span></label></div>
                                <div class="col-sm-9">
                                <input type="text" name="firstName" value="<%= currentUser.getFirstName() %>"><br>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-3"><label class="info-label mb-0">Tên <span class="text-danger">*</span></label></div>
                                <div class="col-sm-9">
                                             <input type="text" name="lastName" value="<%= currentUser.getLastName() %>"><br>

                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-3"><label class="info-label mb-0">Số điện thoại <span class="text-danger">*</span></label></div>
                                <div class="col-sm-9">
                                   <input type="text" name="phone" value="<%= currentUser.getPhone() %>"><br>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-3"><label class="info-label mb-0">Địa chỉ <span class="text-danger">*</span></label></div>
                                <div class="col-sm-9">
                                         <input type="text" name="address" value="<%= currentUser.getAddress() %>"><br>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                               <input type="submit" value="Cập nhật">
                                <button type="button" class="btn btn-secondary" onclick="toggleEditForm()">
                                    <i class="bi bi-x-circle me-2"></i>Hủy
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Recent Orders -->
                    <div class="order-card">
                        <h5 class="card-title">
                            <i class="bi bi-clock-history me-2"></i>Đơn hàng gần đây
                        </h5>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th><i class="bi bi-hash me-2"></i>Mã đơn</th>
                                        <th><i class="bi bi-box me-2"></i>Sản phẩm</th>
                                        <th><i class="bi bi-calendar me-2"></i>Ngày đặt</th>
                                        <th><i class="bi bi-currency-dollar me-2"></i>Tổng tiền</th>
                                        <th><i class="bi bi-info-circle me-2"></i>Trạng thái</th>
                                        <th><i class="bi bi-gear me-2"></i>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (recentOrders != null && !recentOrders.isEmpty()) {
                                            for (Map<String, Object> order : recentOrders) {%>
                                    <tr>
                                        <td class="fw-bold">#<%= order.get("Order_ID")%></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-box me-2 text-primary"></i>
                                                <%= order.get("ProductName")%> 
                                                <span class="badge bg-primary ms-2">x<%= order.get("Quantity")%></span>
                                            </div>
                                        </td>
                                        <td><%= dateFormat.format(order.get("Order_Date"))%></td>
                                        <td class="fw-bold"><%= String.format("%,.0f", (Double) order.get("Subtotal"))%>đ</td>
                                        <td>
                                            <% String status = (String) order.get("Status");
                                                String statusClass = "status-processing";
                                                String statusIcon = "bi-clock-fill";
                                                if ("Completed".equalsIgnoreCase(status)) {
                                                    statusClass = "status-completed";
                                                    statusIcon = "bi-check-circle-fill";
                                                }%>
                                            <span class="order-status <%= statusClass%>">
                                                <i class="bi <%= statusIcon%> me-1"></i>
                                                <%= status%>
                                            </span>
                                        </td>
                                        <td>
                                            <a href="order-detail.jsp?orderId=<%= order.get("Order_ID")%>" 
                                               class="btn btn-sm btn-primary">
                                                <i class="bi bi-eye-fill"></i> Chi tiết
                                            </a>
                                        </td>
                                    </tr>
                                    <% }
                                    } else { %>
                                    <tr>
                                        <td colspan="6" class="text-center py-5">
                                            <i class="bi bi-inbox display-4 d-block mb-3 text-muted"></i>
                                            <p class="text-muted mb-0">Không có đơn hàng nào</p>
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

                          
            <script
                src="https://messenger.svc.chative.io/static/v1.0/channels/sd795937d-06e2-47e1-b379-08c94dd93f0c/messenger.js?mode=livechat"
                defer="defer"
            ></script>


        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Custom JS -->
 
        <script>
                                    function toggleEditForm() {
                                        const viewMode = document.getElementById('view-mode');
                                        const editMode = document.getElementById('edit-mode');
                                        const actionButtons = document.getElementById('profile-actions');

                                        if (editMode.style.display === 'none' || editMode.style.display === '') {
                                            viewMode.style.display = 'none';
                                            editMode.style.display = 'block';
                                            actionButtons.style.display = 'none';
                                        } else {
                                            viewMode.style.display = 'block';
                                            editMode.style.display = 'none';
                                            actionButtons.style.display = 'flex';
                                        }
                                    }

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
                                                form.classList.add("was-validated");
                                            }, false);
                                        });
                                    })();
        </script>
    </body>
</html>