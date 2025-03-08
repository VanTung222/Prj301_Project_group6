<!DOCTYPE html>
<!--ddd-->
<html lang="zxx">
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
                            String heartLink = (username == null) ? "login.jsp" : "wishlist";
                            String cartLink = (username == null) ? "login.jsp" : "shoping-cart.jsp";
                        %>
                    <a href="<%= heartLink%>"><img src="img/icon/heart.png" alt="Wishlist" /></a>
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
                                <div class="header__top__left">
                                    <ul>
                                        <li>
                                            <a href="#" class="search-switch"><img src="img/icon/search.png" alt=""/></a>
                                        </li>
                                        <li>
                                            <a href="<%= heartLink%>"><img src="img/icon/heart.png" alt="Wishlist" /></a>
                                        </li>
                                    </ul>

                                </div>
                                <div class="header__logo">
                                    <a href="./index.jsp"><img src="img/logo.png" alt="Logo" /></a>
                                </div>
                                <div class="header__top__right">
                                    <div class="header__top__right__cart">
                                        <a href="<%= cartLink%>"><img src="img/icon/cart.png" alt="Cart" /> <span>0</span></a>
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
                                <li><a href="./about.html">About</a></li>
                                <li><a href="./shop.html">Shop</a></li>
                                <li>
                                    <a href="#">Pages</a>
                                    <ul class="dropdown">
                                        <li><a href="./shop-details.html">Shop Details</a></li>
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

        <!-- Hero Section Begin -->
        <section class="hero">
            <div class="hero__slider owl-carousel">
                <div class="hero__item set-bg" data-setbg="img/hero/hero-1.jpg">
                    <div class="container">
                        <div class="row d-flex justify-content-center">
                            <div class="col-lg-8">
                                <div class="hero__text">
                                    <h2>Making your life sweeter one bite at a time!</h2>
                                    <a href="#" class="primary-btn">Our cakes</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="hero__item set-bg" data-setbg="img/hero/hero-2.jpg">
                    <div class="container">
                        <div class="row d-flex justify-content-center">
                            <div class="col-lg-8">
                                <div class="hero__text">
                                    <h2>Sweetness comes after struggles, just like cake!</h2>
                                    <a href="#" class="primary-btn">Our cakes</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->

        <!-- About Section Begin -->
        <section class="about spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="about__text">
                            <div class="section-title">
                                <span>About Cake shop</span>
                                <h2>Cakes and bakes from the house of Queens!</h2>
                            </div>
                            <p>
                                The "Cake Shop" is a Jordanian Brand that started as a small
                                family business. The owners are Dr. Iyad Sultan and Dr. Sereen
                                Sharabati, supported by a staff of 80 employees.
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="about__bar">
                            <div class="about__bar__item">
                                <p>Cake design</p>
                                <div id="bar1" class="barfiller">
                                    <div class="tipWrap"><span class="tip"></span></div>
                                    <span class="fill" data-percentage="95"></span>
                                </div>
                            </div>
                            <div class="about__bar__item">
                                <p>Cake Class</p>
                                <div id="bar2" class="barfiller">
                                    <div class="tipWrap"><span class="tip"></span></div>
                                    <span class="fill" data-percentage="80"></span>
                                </div>
                            </div>
                            <div class="about__bar__item">
                                <p>Cake Recipes</p>
                                <div id="bar3" class="barfiller">
                                    <div class="tipWrap"><span class="tip"></span></div>
                                    <span class="fill" data-percentage="90"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- About Section End -->

        <!-- Categories Section Begin -->
        <div class="categories">
            <div class="container">
                <div class="row">
                    <div class="categories__slider owl-carousel">
                        <div class="categories__item">
                            <div class="categories__item__icon">
                                <span class="flaticon-029-cupcake-3"></span>
                                <h5>Cupcake</h5>
                            </div>
                        </div>
                        <div class="categories__item">
                            <div class="categories__item__icon">
                                <span class="flaticon-034-chocolate-roll"></span>
                                <h5>Butter</h5>
                            </div>
                        </div>
                        <div class="categories__item">
                            <div class="categories__item__icon">
                                <span class="flaticon-005-pancake"></span>
                                <h5>Red Velvet</h5>
                            </div>
                        </div>
                        <div class="categories__item">
                            <div class="categories__item__icon">
                                <span class="flaticon-030-cupcake-2"></span>
                                <h5>Biscuit</h5>
                            </div>
                        </div>
                        <div class="categories__item">
                            <div class="categories__item__icon">
                                <span class="flaticon-006-macarons"></span>
                                <h5>Donut</h5>
                            </div>
                        </div>
                        <div class="categories__item">
                            <div class="categories__item__icon">
                                <span class="flaticon-006-macarons"></span>
                                <h5>Cupcake</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Categories Section End -->

        <!-- Product Section Begin -->
        <section class="product spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div
                                class="product__item__pic set-bg"
                                data-setbg="img/shop/product-1.jpg"
                                >
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#">Dozen Cupcakes</a></h6>
                                <div class="product__item__price">$32.00</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div
                                class="product__item__pic set-bg"
                                data-setbg="img/shop/product-2.jpg"
                                >
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#">Cookies and Cream</a></h6>
                                <div class="product__item__price">$30.00</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div
                                class="product__item__pic set-bg"
                                data-setbg="img/shop/product-3.jpg"
                                >
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#">Gluten Free Mini Dozen</a></h6>
                                <div class="product__item__price">$31.00</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div
                                class="product__item__pic set-bg"
                                data-setbg="img/shop/product-4.jpg"
                                >
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#">Cookie Dough</a></h6>
                                <div class="product__item__price">$25.00</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div
                                class="product__item__pic set-bg"
                                data-setbg="img/shop/product-5.jpg"
                                >
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#">Vanilla Salted Caramel</a></h6>
                                <div class="product__item__price">$05.00</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div
                                class="product__item__pic set-bg"
                                data-setbg="img/shop/product-6.jpg"
                                >
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#">German Chocolate</a></h6>
                                <div class="product__item__price">$14.00</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div
                                class="product__item__pic set-bg"
                                data-setbg="img/shop/product-7.jpg"
                                >
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#">Dulce De Leche</a></h6>
                                <div class="product__item__price">$32.00</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div
                                class="product__item__pic set-bg"
                                data-setbg="img/shop/product-8.jpg"
                                >
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#">Mississippi Mud</a></h6>
                                <div class="product__item__price">$08.00</div>
                                <div class="cart_add">
                                    <a href="#">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Product Section End -->

        <!-- Team Section Begin -->
        <section class="team spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 col-md-7 col-sm-7">
                        <div class="section-title">
                            <span>Our team</span>
                            <h2>Sweet Coder</h2>
                        </div>
                    </div>
                    <div class="col-lg-5 col-md-5 col-sm-5">
                        <div class="team__btn">
                            <a href="#" class="primary-btn">Join Us</a>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-1.jpg">
                            <div class="team__item__text">
                                <h6>Tr?n V?n T�ng</h6>
                                <span>Leader</span>
                                <div class="team__item__social">
                                    <a href="https://www.facebook.com/tran.van.tung.232700"
                                       ><i class="fa fa-facebook"></i
                                        ></a>

                                    <a href="https://www.instagram.com/tugg_tvt.22/"
                                       ><i class="fa fa-instagram"></i
                                        ></a>
                                    <a
                                        href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA"
                                        ><i class="fa fa-youtube-play"></i
                                        ></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-2.jpg">
                            <div class="team__item__text">
                                <h6>Ph?m H?ng Qu�n</h6>
                                <span>Member</span>
                                <div class="team__item__social">
                                    <a href="https://www.facebook.com/quan.edition.9"
                                       ><i class="fa fa-facebook"></i
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
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-3.jpg">
                            <div class="team__item__text">
                                <h6>Ng� S? Gi�</h6>
                                <span>Member</span>
                                <div class="team__item__social">
                                    <a href="https://www.facebook.com/ngo.sy.gia.2024"
                                       ><i class="fa fa-facebook"></i
                                        ></a>

                                    <a href="https://www.instagram.com/nsg0101/"
                                       ><i class="fa fa-instagram"></i
                                        ></a>
                                    <a
                                        href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA"
                                        ><i class="fa fa-youtube-play"></i
                                        ></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-4.jpg">
                            <div class="team__item__text">
                                <h6>Nguy?n Ti?n ??t</h6>
                                <span>Member</span>
                                <div class="team__item__social">
                                    <a
                                        href="https://www.facebook.com/profile.php?id=100051145252263"
                                        ><i class="fa fa-facebook"></i
                                        ></a>

                                    <a href="https://www.instagram.com/dat.sieunhan.hihi/"
                                       ><i class="fa fa-instagram"></i
                                        ></a>
                                    <a
                                        href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA"
                                        ><i class="fa fa-youtube-play"></i
                                        ></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-5.jpg">
                            <div class="team__item__text">
                                <h6>L� Qu?c H�ng</h6>
                                <span>Member</span>
                                <div class="team__item__social">
                                    <a href="https://www.facebook.com/LHQ.17G"
                                       ><i class="fa fa-facebook"></i
                                        ></a>

                                    <a href="https://www.instagram.com/lqh.17g/"
                                       ><i class="fa fa-instagram"></i
                                        ></a>
                                    <a
                                        href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA"
                                        ><i class="fa fa-youtube-play"></i
                                        ></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Team Section End -->

        <!-- Testimonial Section Begin -->

        <!-- Instagram Section Begin --><!-- Testimonial Section Begin -->
        <!-- Testimonial Section Begin -->
        <section class="testimonial spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="section-title">
                            <span>Testimonial</span>
                            <h2>Kh�ch h�ng c?a ch�ng t�i n�i</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="testimonial__slider owl-carousel">
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/ta-1.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Phan ??ng Qu?nh Linh</h5>
                                        <span>Viet Nam</span>
                                    </div>
                                </div>
                                <div class="rating">
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star-half_alt"></span>
                                </div>
                                <p>
                                    "T�i ?� mua b�nh n�y ?? l�m qu� sinh nh?t cho b?n th�n, v� n�
                                    th?c s? g�y ?n t??ng m?nh! H?p b�nh ???c trang tr� ??p m?t,
                                    h??ng v? th?m ngon, kh�ng qu� ng?t m� v?n ??m ?�. M?t m�n qu�
                                    tuy?t v?i d�nh cho nh?ng ng??i y�u b�nh ng?t."
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/ta-2.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Tr?n Ph??ng Th?o</h5>
                                        <span>Viet Nam</span>
                                    </div>
                                </div>
                                <div class="rating">
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star-half_alt"></span>
                                </div>
                                <p>
                                    ?Chi?c b�nh n�y th?c s? khi?n t�i b?t ng?! L?p kem m?m m?n,
                                    ng?t v?a ph?i k?t h?p v?i c?t b�nh b�ng x?p, tan ngay trong
                                    mi?ng. M?i mi?ng c?n ??u mang l?i c?m gi�c nh? m?t b?a ti?c
                                    h??ng v?! Ch?c ch?n s? quay l?i mua th�m.?
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/ta-1.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Nguy?n Minh H?ng</h5>
                                        <span>Viet Nam</span>
                                    </div>
                                </div>
                                <div class="rating">
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star-half_alt"></span>
                                </div>
                                <p>
                                    ?B�nh r?t th?m v� m?m, v? ng?t v?a ph?i. Tuy nhi�n, l?p kem
                                    h?i nhi?u so v?i kh?u v? c?a m�nh, n?u gi?m m?t ch�t th� s?
                                    ho�n h?o h?n. D� v?y, ch?c ch?n m�nh v?n s? quay l?i mua l?n
                                    n?a!"
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/ta-2.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Ti?n D?ng</h5>
                                        <span>Viet Nam</span>
                                    </div>
                                </div>
                                <div class="rating">
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star-half_alt"></span>
                                </div>
                                <p>
                                    ?M�nh r?t th�ch v? b�nh, ??c bi?t l� l?p b�ng lan m?m x?p v�
                                    kh�ng b? kh�. Nh?ng l?n n�y giao h�ng h?i l�u h?n mong ??i.
                                    N?u c?i thi?n t?c ?? giao h�ng th� ch?c ch?n 5 sao!?
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/ta-1.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Tr?n Th? Kh�nh Linh</h5>
                                        <span>Viet Nam </span>
                                    </div>
                                </div>
                                <div class="rating">
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star-half_alt"></span>
                                </div>
                                <p>
                                    ?B�nh ngon, m?m m?n, nh?ng kh�ng qu� kh�c bi?t so v?i m?t s?
                                    ti?m kh�c. M�nh mong ch? m?t h??ng v? ??c ?�o h?n. D� v?y,
                                    d?ch v? r?t t?t, nh�n vi�n t? v?n nhi?t t�nh!?
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/ta-2.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>T? Uy�n</h5>
                                        <span>Viet Nam </span>
                                    </div>
                                </div>
                                <div class="rating">
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star"></span>
                                    <span class="icon_star-half_alt"></span>
                                </div>
                                <p>
                                    ?Chi?c b�nh n�y kh�ng ch? ngon m� c�n ??p ??n m?c kh�ng n? ?n!
                                    M?i chi ti?t trang tr� ??u t? m?, tinh t?, h??ng v? h�a quy?n
                                    ho�n h?o gi?a c�c l?p. M?t chi?c b�nh kh�ng ch? ?? ?n m� c�n
                                    ?? th??ng th?c!?
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Testimonial Section End -->

        <!-- Testimonial Section End -->
        <section class="instagram spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 p-0">
                        <div class="instagram__text">
                            <div class="section-title">
                                <span>Follow us on instagram</span>
                                <h2>Sweet moments are saved as memories.</h2>
                            </div>
                            <h5><i class="fa fa-instagram"></i> @sweetcake</h5>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic">
                                    <img src="img/instagram/instagram-1.jpg" alt="" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic middle__pic">
                                    <img src="img/instagram/instagram-2.jpg" alt="" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic">
                                    <img src="img/instagram/instagram-3.jpg" alt="" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic">
                                    <img src="img/instagram/instagram-4.jpg" alt="" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic middle__pic">
                                    <img src="img/instagram/instagram-5.jpg" alt="" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic">
                                    <img src="img/instagram/instagram-3.jpg" alt="" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Instagram Section End -->

        <!-- Map Begin -->
        <div class="map">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-7">
                        <div class="map__inner">
                            <h6>Danang</h6>
                            <ul>
                                <li>FPT, Hoa Hai, Ngu Hanh Son, Da Nang, Viet Nam</li>
                                <li>chandecake@gmail.com</li>
                                <li>01234567780</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="map__iframe">
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834.3270146336316!2d108.25121437604646!3d16.048313084636836!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31421948299babb5%3A0x35692bc43e0ac4e8!2zRmFwdCBVbml2ZXJzaXR5IMSQw6AgTuG6tW5n!5e0!3m2!1svi!2s!4v1708268901234!5m2!1svi!2s"
                    height="300"
                    style="border: 0"
                    allowfullscreen=""
                    aria-hidden="false"
                    tabindex="0"
                    ></iframe>
            </div>
        </div>
        <!-- Map End -->

        <!-- Footer Section Begin -->
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
        </footer>
        <!-- Footer Section End -->

        <!-- Search Begin -->
        <div class="search-model">
            <div class="h-100 d-flex align-items-center justify-content-center">
                <div class="search-close-switch">+</div>
                <form class="search-model-form">
                    <input type="text" id="search-input" placeholder="Search here....." />
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
