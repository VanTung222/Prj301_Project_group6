<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@page
    import="java.util.List" %> <%@page import="java.util.ArrayList" %> <%@page
        import="model.Product" %> <%@page import="dao.FavoriteProductDAO" %> <%@page
        import="model.Customer" %> <%@page import="model.FavoriteProduct" %> <%
            HttpSession sess = request.getSession();
            Customer customer = (Customer) sess.getAttribute("customer");
            List<FavoriteProduct> favorites = new ArrayList<>();
            if (customer != null) {
                FavoriteProductDAO favoriteDAO = new FavoriteProductDAO();
                favorites
                        = favoriteDAO.getFavoritesByCustomerId(customer.getCustomerId());
            }
            if (favorites == null) {
                favorites = new ArrayList<>();
            } %>

            <html lang="en">
                <head>
                    <meta charset="UTF-8" />
                    <meta name="description" content="Cake Template" />
                    <meta name="keywords" content="Cake, unica, creative, html" />
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
                    <title>Cake | Favorite Products</title>

                    <!-- Google Font -->
                    <link
                        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap"
                        rel="stylesheet"
                        />
                    <link
                        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap"
                        rel="stylesheet"
                        />
                    <link
                        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet"
                        />

                    <!-- Css Styles -->
                    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
                    <link rel="stylesheet" href="css/flaticon.css" type="text/css" />
                    <link rel="stylesheet" href="css/barfiller.css" type="text/css" />
                    <link rel="stylesheet" href="css/magnific-popup.css" type="text/css" />
                    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
                    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css" />
                    <link rel="stylesheet" href="css/nice-select.css" type="text/css" />
                    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css" />
                    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css" />
                    <link rel="stylesheet" href="css/style.css" type="text/css" />
                    <link rel="stylesheet" href="css/style_search.css" type="text/css" />
                </head>

                <body>

                    <!-- Offcanvas Menu Begin -->
                    <div class="offcanvas-menu-overlay"></div>
                    <div class="offcanvas-menu-wrapper">
                        <div class="offcanvas__cart">
                            <div class="offcanvas__cart__links">
                                <a href="#" class="search-switch"
                                   ><img src="img/icon/search.png" alt="Search"
                                      /></a>
                                    <% HttpSession sessionObj = request.getSession(false);
                                        String username
                                                = null;
                                        String heartLink = "login";
                                        String cartLink = "login";
                                        String profileLink = "login";
                                        if (sessionObj != null) {
                                            username
                                                    = (String) sessionObj.getAttribute("username");
                                            if (username != null) {
                                                heartLink = "wishlist";
                                                cartLink = "shoping-cart.jsp";
                                                profileLink
                                                        = "profile";
                                            }
                                        }%> %>
                                <a href="<%= heartLink%>"
                                   ><img src="img/icon/heart.png" alt="Wishlist"
                                      /></a>
                            </div>
                            <div class="offcanvas__cart__item">
                                <a href="<%= cartLink%>"
                                   ><img src="img/icon/cart.png" alt="Cart" /> <span>0</span></a
                                >
                                <div class="cart__price">Cart: <span>$0.00</span></div>
                            </div>
                        </div>
                        <div class="offcanvas__logo">
                            <a href="home"><img src="img/logo.png" alt="Logo" /></a>
                        </div>
                        <div id="mobile-menu-wrap"></div>
                        <div class="offcanvas__option">
                            <ul>
                                <li>
                                    <span>USD</span> <span class="arrow_carrot-down"></span>
                                    <ul>
                                        <li>EUR</li>
                                        <li>USD</li>
                                    </ul>
                                </li>
                                <li>
                                    <span>ENG</span> <span class="arrow_carrot-down"></span>
                                    <ul>
                                        <li>Spanish</li>
                                        <li>ENG</li>
                                    </ul>
                                </li>
                                <% if (username != null) { %>
                                <li>
                                    <form
                                        action="LogoutServlet"
                                        method="post"
                                        style="margin: 0; padding: 0"
                                        >
                                        <button
                                            type="submit"
                                            style="
                                            background: none;
                                            border: none;
                                            color: #fff;
                                            cursor: pointer;
                                            padding: 8px 15px;
                                            "
                                            >
                                            Logout
                                        </button>
                                    </form>
                                </li>
                                <% } else { %>
                                <li><a href="login" style="padding: 8px 15px">Sign In</a></li>
                                    <% }%>
                            </ul>
                        </div>
                    </div>
                    <!-- Offcanvas Menu End -->

                    <!-- Header Section Begin -->
                    <header class="header">
                        <div class="header__top">
                            <div class="container">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="header__top__inner">
                                            <!-- Left side - Search and Wishlist -->
                                            <div class="header__top__left">
                                                <ul>
                                                    <li>
                                                        <a href="#" class="search-switch">
                                                            <i class="fa fa-search"></i>
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="<%= heartLink%>" class="wishlist-link">
                                                            <i class="fa fa-heart"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>

                                            <!-- Center - Logo -->
                                            <div class="header__logo">
                                                <a href="home">
                                                    <img src="img/logo.png" alt="Cake Shop Logo" />
                                                </a>
                                            </div>

                                            <!-- Right side - Cart and User -->
                                            <div class="header__top__right">
                                                <!-- Cart -->
                                                <div class="header__top__right__cart">
                                                    <a href="<%= cartLink%>"
                                                       ><img src="img/icon/cart.png" alt="Cart" />
                                                        <span>0</span></a
                                                    >
                                                    <div class="cart__price">Cart: <span>$0.00</span></div>
                                                </div>

                                                <!-- User Menu -->
                                                <div class="header__top__right__links">
                                                    <% if (username != null) {%>
                                                    <div class="user-menu">
                                                        <a href="<%= profileLink%>" class="profile-link">
                                                            <img
                                                                src="img/icon/person_logo.jpg"
                                                                alt="Profile"
                                                                class="profile-img"
                                                                />
                                                        </a>
                                                        <form
                                                            action="LogoutServlet"
                                                            method="post"
                                                            class="logout-form"
                                                            >
                                                            <button type="submit" class="btn btn-outline-danger">
                                                                <i class="fa fa-sign-out"></i> Logout
                                                            </button>
                                                        </form>
                                                    </div>
                                                    <% } else { %>
                                                    <a href="login" class="btn btn-outline-primary">
                                                        <i class="fa fa-sign-in"></i> Sign In
                                                    </a>
                                                    <% }%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="canvas__open">
                                    <i class="fa fa-bars"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Main Navigation -->
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12">
                                    <nav class="header__menu mobile-menu">
                                        <ul>
                                            <li><a href="home">Home</a></li>
                                            <li><a href="./about.jsp">About</a></li>
                                            <li><a href="./shop.jsp">Shop</a></li>
                                            <li>
                                                <a href="#">Pages</a>
                                                <ul class="dropdown">
                                                    <li><a href="./shop-details.jsp">Shop Details</a></li>
                                                    <li><a href="./shoping-cart.jsp">Shopping Cart</a></li>
                                                    <li><a href="./checkout.jsp">Check Out</a></li>
                                                    <li><a href="wishlist">Wishlist</a></li></a></li>
                                                </ul>
                                            </li>
                                            <li><a href="./contact.jsp">Contact</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </header>
                    <!-- Header Section End -->

                    <!-- Breadcrumb Begin -->
                    <div class="breadcrumb-option">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <h2>Shop</h2>
                                    <div class="search-model">
                                        <div class="search-wrap">
                                            <div class="search-close-switch">
                                                <i class="fa fa-times"></i>
                                            </div>
                                            <form action="search" method="GET" class="search-form">
                                                <div class="search-input-wrap">
                                                    <i class="fa fa-search search-icon"></i>
                                                    <input
                                                        type="text"
                                                        id="search-box"
                                                        name="keyword"
                                                        placeholder="Search for products..."
                                                        required
                                                        autocomplete="off"
                                                        oninput="searchProductsByName(this.value)"
                                                        />
                                                </div>
                                            </form>
                                            <div id="search-results" class="search-results"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Breadcrumb End -->

                    <div class="container my-5">
                        <div class="row">
                            <div class="col-12">
                                <h3 id="tops-section" class="text-center">FAVORITE PRODUCTS</h3>
                                <div class="row">
                                    <% if (customer == null) { %>
                                    <p class="text-center">Please login to view your wishlist!</p>
                                    <% } else if (favorites.isEmpty()) { %>
                                    <p class="text-center">Your wishlist is empty!</p>
                                    <% } else {
                                        for (FavoriteProduct favorite : favorites) {
                                            Product p
                                                    = favorite.getProduct();%>
                                    <div class="col-md-3">
                                        <div class="card">
                                            <a href="productdetails.jsp?id=<%= p.getProductId()%>">
                                                <img
                                                    src="<%= p.getProductImg()%>"
                                                    class="card-img-top"
                                                    alt="<%= p.getName()%>"
                                                    />
                                            </a>
                                            <div class="card-body text-center">
                                                <h5 class="card-title"><%= p.getName()%></h5>
                                                <p class="card-text">
                                                    Price: <%= String.format("%.2f", p.getPrice())%> $
                                                </p>
                                                <p class="card-text"><%= p.getDescription()%></p>
                                                <a
                                                    href="productdetails.jsp?id=<%= p.getProductId()%>"
                                                    class="btn btn-primary"
                                                    >Buy Now</a
                                                >
                                            </div>
                                        </div>
                                    </div>
                                    <% }
                                        }%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <style>
                        .col-md-3 {
                            padding: 15px;
                        }
                        .text-center {
                            margin: 40px 0px;
                        }
                    </style>

                    <!-- Footer Section Begin -->
                    <footer class="footer set-bg" data-setbg="img/footer-bg.jpg">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-4 col-md-6 col-sm-6">
                                    <div class="footer__widget">
                                        <h6>WORKING HOURS</h6>
                                        <ul>
                                            <li>Monday - Friday: 08:00 am – 08:30 pm</li>
                                            <li>Saturday: 10:00 am – 16:30 pm</li>
                                            <li>Sunday: 10:00 am – 16:30 pm</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 col-sm-6">
                                    <div class="footer__about">
                                        <div class="footer__logo">
                                            <a href="#"><img src="img/footer-logo.png" alt="" /></a>
                                        </div>
                                        <p>
                                            Lorem ipsum dolor amet, consectetur adipiscing elit, sed do
                                            eiusmod tempor incididunt ut labore dolore magna aliqua.
                                        </p>
                                        <div class="footer__social">
                                            <a href="#"><i class="fa fa-facebook"></i></a>
                                            <a href="#"><i class="fa fa-twitter"></i></a>
                                            <a href="#"><i class="fa fa-instagram"></i></a>
                                            <a href="#"><i class="fa fa-youtube-play"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 col-sm-6">
                                    <div class="footer__newslatter">
                                        <h6>Subscribe</h6>
                                        <p>Get latest updates and offers.</p>
                                        <form action="#">
                                            <input type="text" placeholder="Email" />
                                            <button type="submit"><i class="fa fa-send-o"></i></button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="copyright">
                            <div class="container">
                                <div class="row">
                                    <div class="col-lg-7">
                                        <p class="copyright__text text-white">
                                            Copyright ©
                                            <script>
                                                document.write(new Date().getFullYear());
                                            </script>
                                            All rights reserved | This template is made with
                                            <i class="fa fa-heart" aria-hidden="true"></i> by
                                            <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                        </p>
                                    </div>
                                    <div class="col-lg-5">
                                        <div class="copyright__widget">
                                            <ul>
                                                <li><a href="#">Privacy Policy</a></li>
                                                <li><a href="#">Terms & Conditions</a></li>
                                                <li><a href="#">Site Map</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script src="https://messenger.svc.chative.io/static/v1.0/channels/sa333af83-d5b0-4954-8318-224f96b5912d/messenger.js?mode=livechat" defer="defer"></script>
                    </footer>
                    <!-- Footer Section End -->

                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script>
                                                            $(document).ready(function () {
                                                                $("#search").on("input", function () {
                                                                    var searchQuery = $(this).val().trim();

                                                                    if (searchQuery === "") {
                                                                        $("#search-results").html("");
                                                                        return;
                                                                    }

                                                                    $.ajax({
                                                                        url: "search",
                                                                        method: "GET",
                                                                        data: {search: searchQuery},
                                                                        success: function (response) {
                                                                            $("#search-results").html(response).show();
                                                                        },
                                                                        error: function () {
                                                                            console.error("Lỗi khi tải dữ liệu, vui lòng thử lại.");
                                                                        }
                                                                    });
                                                                });

                                                                $(document).on("click", ".search-item", function () {
                                                                    var productName = $(this).text();
                                                                    $("#search").val(productName);
                                                                    $("#search-results").html("").hide();
                                                                });
                                                            });
                    </script>
                    <!-- Js Plugins -->
                    <script src="js/jquery-3.3.1.min.js"></script>
                    <script src="js/bootstrap.min.js"></script>
                    <script src="js/jquery.nice-select.min.js"></script>
                    <script src="js/jquery.barfiller.js"></script>
                    <script src="js/jquery.magnific-popup.min.js"></script>
                    <script src="js/jquery.slicknav.js"></script>
                    <script src="js/owl.carousel.min.js"></script>
                    <script src="js/jquery.nicescroll.min.js"></script>
                    <script src="js/main.js"></script>
                    <script src="js/script_search.js"></script>
                </body>
            </html

