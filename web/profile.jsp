<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, model.Customer" %>
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
    ResultSet recentOrders = (ResultSet) request.getAttribute("recentOrders");
    ResultSet favoriteProducts = (ResultSet) request.getAttribute("favoriteProducts");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thông tin cá nhân - <%= fullName %></title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <style>
        .profile-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .stat-card, .info-card, .order-card, .favorite-card {
            background: #fff;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s;
        }
        .stat-card:hover, .info-card:hover, .order-card:hover, .favorite-card:hover {
            transform: translateY(-5px);
        }
        .order-status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
        }
        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }
        .status-processing {
            background-color: #fff3cd;
            color: #856404;
        }
        .icon-shape {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .info-label {
            font-weight: 500;
            color: #555;
        }
        .info-value {
            color: #333;
        }
        .favorite-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <%--<jsp:include page="header.jsp" />--%>

    <!-- Profile Header -->
    <div class="profile-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-3 text-center">
                    <img src="<%= profilePicture %>" alt="Profile Picture" class="profile-picture mb-3" />
                </div>
                <div class="col-md-9">
                    <h2 class="mb-1"><%= fullName %></h2>
                    <p class="text-muted mb-2"><i class="bi bi-envelope me-2"></i><%= email %></p>
                    <p class="mb-3"><i class="bi bi-telephone me-2"></i><%= phone %></p>
                    <div class="d-flex gap-2 flex-wrap">
                        <form action="profile" method="post" style="margin: 0;">
                            <input type="hidden" name="action" value="edit-profile" />
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa thông tin
                            </button>
                        </form>
                        <form action="LogoutServlet" method="post" style="margin: 0;">
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn đăng xuất?');">
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
                    <h5 class="card-title mb-4">Thống kê đơn hàng</h5>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="d-flex align-items-center">
                            <div class="icon-shape bg-primary text-white rounded-circle p-3">
                                <i class="bi bi-cart"></i>
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Tổng đơn hàng</h6>
                                <span class="text-muted"><%= totalOrders != null ? totalOrders : 0 %> đơn</span>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="d-flex align-items-center">
                            <div class="icon-shape bg-success text-white rounded-circle p-3">
                                <i class="bi bi-check-circle"></i>
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Đã hoàn thành</h6>
                                <span class="text-muted"><%= completedOrders != null ? completedOrders : 0 %> đơn</span>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center">
                            <div class="icon-shape bg-warning text-white rounded-circle p-3">
                                <i class="bi bi-clock"></i>
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Đang xử lý</h6>
                                <span class="text-muted"><%= processingOrders != null ? processingOrders : 0 %> đơn</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Personal Information and Orders -->
            <div class="col-md-8">
                <div class="info-card mb-4">
                    <h5 class="card-title mb-4">Thông tin cá nhân</h5>
                    <div class="row mb-3">
                        <div class="col-sm-3"><p class="info-label mb-0">Tên đăng nhập</p></div>
                        <div class="col-sm-9"><p class="info-value mb-0"><%= username %></p></div>
                    </div>
                    <hr />
                    <div class="row mb-3">
                        <div class="col-sm-3"><p class="info-label mb-0">Họ và tên</p></div>
                        <div class="col-sm-9"><p class="info-value mb-0"><%= fullName %></p></div>
                    </div>
                    <hr />
                    <div class="row mb-3">
                        <div class="col-sm-3"><p class="info-label mb-0">Email</p></div>
                        <div class="col-sm-9"><p class="info-value mb-0"><%= email %></p></div>
                    </div>
                    <hr />
                    <div class="row mb-3">
                        <div class="col-sm-3"><p class="info-label mb-0">Số điện thoại</p></div>
                        <div class="col-sm-9"><p class="info-value mb-0"><%= phone %></p></div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-3"><p class="info-label mb-0">Địa chỉ</p></div>
                        <div class="col-sm-9"><p class="info-value mb-0"><%= address %></p></div>
                    </div>
                </div>

                <!-- Recent Orders -->
                <div class="order-card mb-4">
                    <h5 class="card-title mb-4">Đơn hàng gần đây</h5>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Sản phẩm</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (recentOrders != null) { 
                                    try {
                                        while (recentOrders.next()) { %>
                                <tr>
                                    <td>#<%= recentOrders.getInt("Order_ID") %></td>
                                    <td><%= recentOrders.getString("ProductName") %> (x<%= recentOrders.getInt("Quantity") %>)</td>
                                    <td><%= dateFormat.format(recentOrders.getDate("Order_Date")) %></td>
                                    <td><%= String.format("%,.0f", recentOrders.getDouble("Subtotal")) %>đ</td>
                                    <td>
                                        <% String status = recentOrders.getString("Status");
                                           String statusClass = "status-processing";
                                           if ("Completed".equalsIgnoreCase(status)) {
                                               statusClass = "status-completed";
                                           } %>
                                        <span class="order-status <%= statusClass %>"><%= status %></span>
                                    </td>
                                    <td>
                                        <a href="order-detail.jsp?orderId=<%= recentOrders.getInt("Order_ID") %>" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-eye"></i> Xem
                                        </a>
                                    </td>
                                </tr>
                                <%  }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        try {
                                            if (recentOrders != null && !recentOrders.isClosed()) {
                                                recentOrders.close();
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                    }
                                } else { %>
                                <tr>
                                    <td colspan="6" class="text-center">Không có đơn hàng nào</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <%--<jsp:include page="footer.jsp" />--%>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="js/main.js"></script>
</body>
</html>