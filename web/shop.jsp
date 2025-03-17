<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
    if (request.getAttribute("productList") == null) {
        response.sendRedirect("shop");
        return;
    }
%>

<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Cake Template">
        <meta name="keywords" content="Cake, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Cake | Shop</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/style_search.css" type="text/css" />
    </head>

    <body>

        <div id="preloder">
            <div class="loader"></div>
        </div>

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
                            String heartLink = "login.jsp";
                            String cartLink = "login.jsp";
                            String profileLink = "login.jsp";
                            if (sessionObj != null) {
                                username
                                        = (String) sessionObj.getAttribute("username");
                                if (username != null) {
                                    heartLink = "wishlist";
                                    cartLink = "shoping-cart.html";
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
                <a href="./index.jsp"><img src="img/logo.png" alt="Logo" /></a>
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
                    <li><a href="login.jsp" style="padding: 8px 15px">Sign In</a></li>
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
                                    <a href="./index.jsp">
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
                                        <a href="login.jsp" class="btn btn-outline-primary">
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
                                <li><a href="./index.jsp">Home</a></li>
                                <li><a href="./about.html">About</a></li>
                                <li><a href="./shop.jsp">Shop</a></li>
                                <li>
                                    <a href="#">Pages</a>
                                    <ul class="dropdown">
                                        <li><a href="./shop-details.jsp">Shop Details</a></li>
                                        <li><a href="./shoping-cart.html">Shopping Cart</a></li>
                                        <li><a href="./checkout.html">Check Out</a></li>
                                        <li><a href="./wishlist.html">Wishlist</a></li>
                                        <li><a href="./class.html">Class</a></li>
                                        <li><a href="./blog-details.html">Blog Details</a></li>
                                    </ul>
                                </li>
                                <li><a href="./blog.html">Blog</a></li>
                                <li><a href="./contact.html">Contact</a></li>
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

        <!-- Shop Section -->
        <section class="shop spad">
            <div class="container" >
                <div class="row" id="product-list">
                    <%
                        List<Product> productList = (List<Product>) request.getAttribute("productList");
                        if (productList == null) {
                            out.println("<p style='color:red;'>⚠ ERROR: productList is NULL!</p>");
                        } else if (productList.isEmpty()) {
                            out.println("<p style='color:red;'>⚠ No products available.</p>");
                        } else {
                            for (Product product : productList) {
                    %>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic set-bg" data-setbg="img/shop/product-<%= product.getProductId()%>.jpg">
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <!-- Link sản phẩm đến trang shop-details.jsp -->
                                <h6><a href="shop-details.jsp?product_id=<%= product.getProductId()%>">
                                        <%= product.getName()%>
                                    </a></h6>

                                <div class="product__item__price">$<%= product.getPrice()%></div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                        }
                    %>

                </div>
            </div>
        </section>

        

        <footer class="footer set-bg" data-setbg="img/footer-bg.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="footer__widget">
                            <h6>WORKING HOURS</h6>
                            <ul>
                                <li>Monday - Friday: 08:00 am ? 08:30 pm</li>
                                <li>Saturday: 10:00 am ? 16:30 pm</li>
                                <li>Sunday: 10:00 am ? 16:30 pm</li>
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
                                <a href="https://www.facebook.com/profile.php?id=61572957316241"
                                   ><i class="fa fa-facebook"></i
                                    ></a>
                                <a href="https://x.com/BanhLife78128"
                                   ><i class="fa fa-twitter"></i
                                    ></a>
                                <a href="https://www.instagram.com/quannrau2410/"
                                   ><i class="fa fa-instagram"></i
                                    ></a>
                                <a
                                    href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA"
                                    ><i class="fa fa-youtube-play"></i
                                    ></a>
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
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                Copyright &copy;
                                <script>
                                    document.write(new Date().getFullYear());
                                </script>
                                All rights reserved | This template is made with
                                <i class="fa fa-heart" aria-hidden="true"></i> by
                                <a href="https://colorlib.com" target="_blank">TeamChanDe</a>
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
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
            <script
                src="https://messenger.svc.chative.io/static/v1.0/channels/sd795937d-06e2-47e1-b379-08c94dd93f0c/messenger.js?mode=livechat"
                defer="defer"
            ></script>
        </footer>
        <!-- Footer Section End -->

        <!-- Js Plugins -->
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
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/script_search.js"></script>

    </body>
</html>
