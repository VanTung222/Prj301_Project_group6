<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Tiệm Bánh</title>
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #f08632;
        }
        
        .top-header {
            background: white;
            padding: 1rem 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }
        
        .header-left {
            display: flex;
            gap: 1.5rem;
        }
        
        .header-left a {
            color: #333;
            text-decoration: none;
            font-size: 1.2rem;
        }
        
        .logo {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
            color: #333;
        }
        
        .logo img {
            height: 40px;
            margin-right: 0.5rem;
        }
        
        .header-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        
        .cart-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #333;
            text-decoration: none;
        }
        
        .cart-info i {
            font-size: 1.2rem;
        }
        
        .profile-section {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .logout-btn {
            padding: 0.5rem 1rem;
            border: 1px solid #dc3545;
            color: #dc3545;
            background: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            background: #dc3545;
            color: white;
        }
        
        .nav-menu {
            background: var(--primary-color);
            padding: 1rem 0;
        }
        
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }
        
        .nav-menu ul {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin: 0;
            padding: 0;
            list-style: none;
        }
        
        .nav-menu a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: opacity 0.3s ease;
        }
        
        .nav-menu a:hover {
            opacity: 0.8;
        }

        .dashboard-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 15px;
            background: #f08632;
            color: white;
        }
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .table thead th {
            background: #f08632;
            color: white;
            border: none;
        }
        .table tbody tr:hover {
            background-color: rgba(240, 134, 50, 0.1);
        }
    </style>
</head>
<body>
    <!-- Top Header -->
    <header class="top-header">
        <div class="header-container">
            <div class="header-left">
                <a href="#" class="search-link">
                    <i class="fas fa-search"></i>
                </a>
                <a href="#" class="wishlist-link">
                    <i class="fas fa-heart"></i>
                </a>
            </div>
            
            <a href="index.jsp" class="logo">
                <img src="img/logo.png" alt="Cake">
                
            </a>
            
            <div class="header-right">
                <a href="#" class="cart-info">
                    <i class="fas fa-shopping-bag"></i>
                    Cart: $0.00
                </a>
                <div class="profile-section">
                    <a href="#" class="profile-link">
                        <i class="fas fa-user-circle"></i>
                    </a>
                    <form action="LogoutServlet" method="post" style="margin: 0">
                        <button type="submit" class="logout-btn">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </header>

    <!-- Navigation Menu -->
    <nav class="nav-menu">
        <div class="nav-container">
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="about.html">About</a></li>
                <li><a href="shop.jsp">Shop</a></li>
                <li><a href="#">Pages</a></li>
                <li><a href="blog.html">Blog</a></li>
                <li><a href="contact.html">Contact</a></li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="bi bi-currency-dollar"></i>
                    </div>
                    <h3 class="mb-2">10,000,000 VND</h3>
                    <p class="text-muted mb-0">Doanh thu hôm nay</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="bi bi-cart"></i>
                    </div>
                    <h3 class="mb-2">120</h3>
                    <p class="text-muted mb-0">Số đơn hàng</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="bi bi-star"></i>
                    </div>
                    <h3 class="mb-2">Bánh Mousse</h3>
                    <p class="text-muted mb-0">Sản phẩm bán chạy</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="bi bi-exclamation-triangle"></i>
                    </div>
                    <h3 class="mb-2">Bột mì</h3>
                    <p class="text-muted mb-0">Nguyên liệu sắp hết</p>
                </div>
            </div>
        </div>
        
        <div class="table-container mt-4">
            <h3 class="mb-4">Danh sách sản phẩm</h3>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Đã bán</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Bánh Mousse</td>
                            <td>50,000 VND</td>
                            <td>30</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Bánh Su Kem</td>
                            <td>25,000 VND</td>
                            <td>50</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Js Plugins -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery.barfiller.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>