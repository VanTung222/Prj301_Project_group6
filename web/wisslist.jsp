<!DOCTYPE html>
<!--ddd-->
<html lang="vi">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <head>
        <meta charset="UTF-8" />
        <meta name="description" content="Cake Template" />
        <meta name="keywords" content="Cake, unica, creative, html" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Cake | Template</title>

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
            rel="stylesheet"
            href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css"
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
                    <a href="#" class="search-switch"><img src="img/icon/search.png" alt="Search" /></a>
                        <%
                            String username = (String) session.getAttribute("username");
                            String heartLink = (username == null) ? "login.jsp" : "heart.jsp";
                            String cartLink = (username == null) ? "login.jsp" : "shoping-cart.html";
                        %>
                    <a href="<%= heartLink %>" class="heart-switch"><img src="img/icon/heart.png" alt="Wishlist" /></a>
                    <a href="<%= (username == null) ? "login.jsp" : "profile.jsp" %>">
                        <img src="img/icon/icon_us_1.png" alt="User Profile" style="width:30px; height:30px;">
                        <% if (session.getAttribute("username") != null) { %>
                        <a href="profile.jsp">
                            <img src="img/icon/user-icon.png" alt="User Profile" style="width:30px; height:30px;">
                        </a>
                        <% } else { %>
                        <a href="login.jsp">Login</a>
                        <% } %>

                    </a>
                </div>

                <div class="offcanvas__cart__item">
                    <a href="<%= cartLink%>"><img src="img/icon/cart.png" alt="Cart" /> <span>0</span></a>
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
                        <form action="LogoutServlet" method="post" style="margin: 0; padding: 0;">
                            <button type="submit" style="background: none; border: none; color: #fff; cursor: pointer; padding: 8px 15px;">Logout</button>
                        </form>
                    </li>
                    <% } else { %>
                    <li><a href="login.jsp" style="padding: 8px 15px;">Sign In</a></li>
                        <% } %>
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
                                <div class="header__top__left">
                                    <ul>
                                        <li>
                                            <a href="#" class="search-switch"><img src="img/icon/search.png" alt=""/></a>
                                        </li>
                                        <li>
                                            <a href="<%= heartLink %>"><img src="img/icon/heart.png" alt="Wishlist" /></a>
                                        </li>
                                    </ul>

                                </div>
                                <div class="header__logo">
                                    <a href="./index.jsp"><img src="img/logo.png" alt="Logo" /></a>
                                </div>
                                <div class="header__top__right">
                                    <div class="header__top__right__cart">
                                        <a href="<%= cartLink %>"><img src="img/icon/cart.png" alt="Cart" /> <span>0</span></a>
                                        <div class="cart__price">Cart: <span>$0.00</span></div>
                                    </div>

                                    <div class="header__top__right__links">
                                        <% if (username != null) { %>

                                        <form action="LogoutServlet" method="post" style="margin: 0; display: inline;">
                                            <button type="submit" class="btn btn-outline-primary" style="margin-left: 10px;">Logout</button>
                                        </form>
                                        <% } else { %>
                                        <li><a href="login.jsp" class="btn btn-outline-primary" style="margin-left: 10px;">Sign In</a></li>
                                            <% }%>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="canvas__open"><i class="fa fa-bars"></i></div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <nav class="header__menu mobile-menu">
                            <ul>
                                <li class="active"><a href="./index.jsp">Home</a></li>
                                <li><a href="./about.jsp">About</a></li>
                                <li><a href="./shop.jsp">Shop</a></li>
                                <li>
                                    <a href="#">Pages</a>
                                    <ul class="dropdown">
                                        <li><a href="./shop-details.jsp">Shop Details</a></li>
                                        <li><a href="./shoping-cart.jsp">Shoping Cart</a></li>
                                        <li><a href="./checkout.jsp">Check Out</a></li>
                                        <li><a href="./wisslist.jsp">Wisslist</a></li>
                                        <li><a href="./class.jsp">Class</a></li>
                                        
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
                    <div class="breadcrumb__text">
                        <h2>Wishlist</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <a href="./index.html">Home</a>
                        <span>Wishlist</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Wishlist Section Begin -->
    <section class="wishlist spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="wishlist__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Unit Price</th>
                                    <th>Stock</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="product__cart__item">
                                        <div class="product__cart__item__pic">
                                            <img src="img/shop/cart/cart-1.jpg" alt="">
                                        </div>
                                        <div class="product__cart__item__text">
                                            <h6>Vanilla Salted Caramel</h6>
                                        </div>
                                    </td>
                                    <td class="cart__price">$ 15.00</td>
                                    <td class="cart__stock">In stock</td>
                                    <td class="cart__btn"><a href="#" class="primary-btn">Add to cart</a></td>
                                    <td class="cart__close"><span class="icon_close"></span></td>
                                </tr>
                                <tr>
                                    <td class="product__cart__item">
                                        <div class="product__cart__item__pic">
                                            <img src="img/shop/cart/cart-2.jpg" alt="">
                                        </div>
                                        <div class="product__cart__item__text">
                                            <h6>German Chocolate</h6>
                                        </div>
                                    </td>
                                    <td class="cart__price">$ 32.50</td>
                                    <td class="cart__stock">In stock</td>
                                    <td class="cart__btn"><a href="#" class="primary-btn">Add to cart</a></td>
                                    <td class="cart__close"><span class="icon_close"></span></td>
                                </tr>
                                <tr>
                                    <td class="product__cart__item">
                                        <div class="product__cart__item__pic">
                                            <img src="img/shop/cart/cart-3.jpg" alt="">
                                        </div>
                                        <div class="product__cart__item__text">
                                            <h6>SWEET AUTUMN LEAVES</h6>
                                        </div>
                                    </td>
                                    <td class="cart__price">$ 23.50</td>
                                    <td class="cart__stock">In stock</td>
                                    <td class="cart__btn"><a href="#" class="primary-btn">Add to cart</a></td>
                                    <td class="cart__close"><span class="icon_close"></span></td>
                                </tr>
                                <tr>
                                    <td class="product__cart__item">
                                        <div class="product__cart__item__pic">
                                            <img src="img/shop/cart/cart-4.jpg" alt="">
                                        </div>
                                        <div class="product__cart__item__text">
                                            <h6>Gluten Free Mini Dozen</h6>
                                        </div>
                                    </td>
                                    <td class="cart__price">$ 32.50</td>
                                    <td class="cart__stock">In stock</td>
                                    <td class="cart__btn"><a href="#" class="primary-btn">Add to cart</a></td>
                                    <td class="cart__close"><span class="icon_close"></span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Wishlist Section End -->

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
                            <a href="#"><img src="img/footer-logo.png" alt=""></a>
                        </div>
                        <p>Freshly baked treats made with love and quality ingredients. Visit us and indulge in sweetness!</p>
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
                            <input type="text" placeholder="Email">
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
                        <p class="copyright__text text-white"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                          Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">TeamChanDe</a>
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
</footer>
<!-- Footer Section End -->

<!-- Search Begin -->
<div class="search-model">
    <div class="h-100 d-flex align-items-center justify-content-center">
        <div class="search-close-switch">+</div>
        <form class="search-model-form">
            <input type="text" id="search-input" placeholder="Search here.....">
        </form>
    </div>
</div>
<!-- Search End -->

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
</body>

</html>