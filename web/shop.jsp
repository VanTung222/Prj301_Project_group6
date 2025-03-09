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
                        <a href="#" class="search-switch"><img src="img/icon/search.png" alt=""></a>
                        <a href="#"><img src="img/icon/heart.png" alt=""></a>
                    </div>
                    <div class="offcanvas__cart__item">
                        <a href="#"><img src="img/icon/cart.png" alt=""> <span>0</span></a>
                        <div class="cart__price">Cart: <span>$0.00</span></div>
                    </div>
                </div>
                <div class="offcanvas__logo">
                    <a href="./index.html"><img src="img/logo.png" alt=""></a>
                </div>
                <div id="mobile-menu-wrap"></div>
                <div class="offcanvas__option">
                    <ul>
                        <li>USD <span class="arrow_carrot-down"></span>
                            <ul>
                                <li>EUR</li>
                                <li>USD</li>
                            </ul>
                        </li>
                        <li>ENG <span class="arrow_carrot-down"></span>
                            <ul>
                                <li>Spanish</li>
                                <li>ENG</li>
                            </ul>
                        </li>
                        <li><a href="#">Sign in</a> <span class="arrow_carrot-down"></span></li>
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
                                            <li>USD <span class="arrow_carrot-down"></span>
                                                <ul>
                                                    <li>EUR</li>
                                                    <li>USD</li>
                                                </ul>
                                            </li>
                                            <li>ENG <span class="arrow_carrot-down"></span>
                                                <ul>
                                                    <li>Spanish</li>
                                                    <li>ENG</li>
                                                </ul>
                                            </li>
                                            <li><a href="#">Sign in</a> <span class="arrow_carrot-down"></span></li>
                                        </ul>
                                    </div>
                                    <div class="header__logo">
                                        <a href="./index.html"><img src="img/logo.png" alt=""></a>
                                    </div>
                                    <div class="header__top__right">
                                        <div class="header__top__right__links">
                                            <a href="#" class="search-switch"><img src="img/icon/search.png" alt=""></a>
                                            <a href="#"><img src="img/icon/heart.png" alt=""></a>
                                        </div>
                                        <div class="header__top__right__cart">
                                            <a href="#"><img src="img/icon/cart.png" alt=""> <span>0</span></a>
                                            <div class="cart__price">Cart: <span>$0.00</span></div>
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
                                    <li><a href="./index.jsp">Home</a></li>
                                    <li><a href="./about.html">About</a></li>
                                    <li class="active"><a href="./shop.html">Shop</a></li>
                                    <li><a href="#">Pages</a>
                                        <ul class="dropdown">
                                            <li><a href="./shop-details.jsp">Shop Details</a></li>
                                            <li><a href="./shoping-cart.html">Shoping Cart</a></li>
                                            <li><a href="./checkout.html">Check Out</a></li>
                                            <li><a href="./wisslist.html">Wisslist</a></li>
                                            <li><a href="./Class.html">Class</a></li>
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
                            <div class="breadcrumb__text">
                                <h2>Shop</h2>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__links">
                                <a href="./index.html">Home</a>
                                <span>Shop</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb End -->

            <!-- Shop Section -->
            <section class="shop spad">
                <div class="container">
                    <div class="row">
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
                        <div class="product__item__pic set-bg" data-setbg="img/shop/product-<%= product.getProductId() %>.jpg">
                            <div class="product__label">
                                <span>Cupcake</span>
                            </div>
                        </div>
                        <div class="product__item__text">
                            <!-- Link sản phẩm đến trang shop-details.jsp -->
                           <h6><a href="shop-details.jsp?product_id=<%= product.getProductId() %>">
            <%= product.getName() %>
        </a></h6>

                            <div class="product__item__price">$<%= product.getPrice() %></div>
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

            <!-- Footer -->
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
                    </div>
                </div>
            </footer>

            <!-- Js Plugins -->
            <script src="js/jquery-3.3.1.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script src="js/main.js"></script>

        </body>
        </html>
