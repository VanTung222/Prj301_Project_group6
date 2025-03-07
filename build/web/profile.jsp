<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Cake Template">
        <meta name="keywords" content="Cake, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Cake | Template</title>

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <!-- Custom Styles -->
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>

        <!-- Page Preloader -->
        <div id="preloder">
            <div class="loader"></div>
        </div>

        <!-- Header Section -->
        <header>
            <!-- Offcanvas Menu -->
            <div class="offcanvas-menu-overlay"></div>
            <div class="offcanvas-menu-wrapper">
                <div class="offcanvas__cart">
                    <div class="offcanvas__cart__links">
                        <a href="#" class="search-switch"><img src="img/icon/search.png" alt="Search"></a>
                        <a href="#" class="heart-switch"><img src="img/icon/heart.png" alt="Wishlist"></a>
                    </div>
                    <div class="offcanvas__cart__item">
                        <a href="#"><img src="img/icon/cart.png" alt="Cart"> <span>0</span></a>
                        <div class="cart__price">Cart: <span>$0.00</span></div>
                    </div>
                </div>
                <div class="offcanvas__logo">
                    <a href="./index.jsp"><img src="img/logo.png" alt="Logo"></a>
                </div>
                <div id="mobile-menu-wrap"></div>
                <div class="offcanvas__option">
                    <ul>
                        <li>
                            <span>USD</span> <span class="arrow_carrot-down"></span>
                            <ul>
                                <li><a href="#">EUR</a></li>
                                <li><a href="#">USD</a></li>
                            </ul>
                        </li>
                        <li>
                            <span>ENG</span> <span class="arrow_carrot-down"></span>
                            <ul>
                                <li><a href="#">Spanish</a></li>
                                <li><a href="#">ENG</a></li>
                            </ul>
                        </li>
                        <% String username = (String) session.getAttribute("username"); %>
                        <% if (username != null) { %>
                        <li>
                            <form action="LogoutServlet" method="post">
                                <button type="submit" class="btn btn-link text-white">Logout</button>
                            </form>
                        </li>
                        <% } else { %>
                        <li><a href="login.jsp">Sign In</a></li>
                            <% } %>
                    </ul>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <div class="container mt-4">
            <h2>Ch?nh s?a thông tin cá nhân</h2>
            <form action="ProfileController" method="POST">
                <div class="mb-3">
                    <label>First Name:</label>
                    <input type="text" name="firstName" class="form-control" value="<%= user.getUsername() %>" required>
                </div>
                <div class="mb-3">
                    <label>Last Name:</label>
                    <input type="text" name="lastName" class="form-control" value="<%= user.getLastName() %>" required>
                </div>
                <div class="mb-3">
                    <label>Address:</label>
                    <input type="text" name="address" class="form-control" value="<%= user.getAddress() %>" required>
                </div>
                <div class="mb-3">
                    <label>Phone:</label>
                    <input type="text" name="phone" class="form-control" value="<%= user.getPhone() %>" required>
                </div>
                <button type="submit" name="action" value="updateProfile" class="btn btn-primary">L?u thay ??i</button>
            </form>

            <h2 class="mt-4">??i m?t kh?u</h2>
            <form action="ProfileController" method="POST">
                <div class="mb-3">
                    <label>M?t kh?u c?:</label>
                    <input type="password" name="oldPassword" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>M?t kh?u m?i:</label>
                    <input type="password" name="newPassword" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Nh?p m?t kh?u m?i:</label>
                    <input type="password" name="confirmPassword" class="form-control" required>
                </div>
                <button type="submit" name="action" value="changePassword" class="btn btn-danger">??i m?t kh?u</button>
            </form>
        </div>


        <!-- Footer Section -->
        <footer class="footer set-bg" data-setbg="img/footer-bg.jpg">
            <div class="container">
                <p class="text-center text-white mt-4">
                    Copyright &copy;
                    <script>document.write(new Date().getFullYear());</script>
                    All rights reserved | Made by <a href="#" class="text-white">TeamChanDe</a>
                </p>
            </div>
        </footer>

        <!-- Search Popup -->
        <div class="search-model">
            <div class="h-100 d-flex align-items-center justify-content-center">
                <div class="search-close-switch">+</div>
                <form class="search-model-form">
                    <input type="text" id="search-input" placeholder="Search here.....">
                </form>
            </div>
        </div>


        <!-- JS Scripts -->
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>
