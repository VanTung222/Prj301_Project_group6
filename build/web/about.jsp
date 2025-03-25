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
                            <h2>About</h2>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="breadcrumb__links">
                            <a href="./index.jsp">Home</a>
                            <span>About</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->

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
                            <p>The "Cake Shop" is a Jordanian Brand that started as a small family business. The owners are
                                Dr. Iyad Sultan and Dr. Sereen Sharabati, supported by a staff of 80 employees.</p>
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

        <!-- Testimonial Section Begin -->
        <section class="testimonial spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="section-title">
                            <span>Testimonial</span>
                            <h2>Khách hàng của chúng tôi nói</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="testimonial__slider owl-carousel">
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/linh_kh1 (1).png" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Phan Đặng Quỳnh Linh</h5>
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
                                    "Tôi đã mua bánh này để làm quà sinh nhật cho bạn thân, và nó
                                    thực sự gây ấn tượng mạnh! Hộp bánh được trang trí đẹp mắt,
                                    hương vị thơm ngon, không quá ngọt mà vẫn đậm đà."
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/kh_anh.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Trần Thị Ngọc Ánh</h5>
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
                                    “Chiếc bánh này thực sự khiến tôi bất ngờ! Lớp kem mềm mịn,
                                    ngọt vừa phải kết hợp với cốt bánh bông xốp, tan ngay trong
                                    miệng. Mỗi miếng cắn đều mang lại cảm giác như một bữa tiệc
                                    hương vị!”
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/kh_nhi.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Trần Thị Tuyết Nhi</h5>
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
                                    “Bánh rất thơm và mềm, vị ngọt vừa phải. Tuy nhiên, lớp kem
                                    hơi nhiều so với khẩu vị của mình, nếu giảm một chút thì sẽ
                                    hoàn hảo hơn. Dù vậy, chắc chắn mình vẫn sẽ quay lại mua lần
                                    nữa!"
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/dung.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Trần Thế Lượng</h5>
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
                                    “Mình rất thích vị bánh, đặc biệt là lớp bông lan mềm xốp và
                                    không bị khô. Nhưng lần này giao hàng hơi lâu hơn mong đợi.
                                    Nếu cải thiện tốc độ giao hàng thì chắc chắn 5 sao!”
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/nhism.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Trần Thái Linh</h5>
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
                                    “Bánh ngon, mềm mịn, nhưng không quá khác biệt so với một số
                                    tiệm khác. Mình mong chờ một hương vị độc đáo hơn. Dù vậy,
                                    dịch vụ rất tốt, nhân viên tư vấn nhiệt tình!”
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="testimonial__item">
                                <div class="testimonial__author">
                                    <div class="testimonial__author__pic">
                                        <img src="img/testimonial/uyen_kh2.jpg" alt="" />
                                    </div>
                                    <div class="testimonial__author__text">
                                        <h5>Nguyễn Xuân Tố Uyên</h5>
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
                                    “Chiếc bánh này không chỉ ngon mà còn đẹp đến mức không nỡ ăn!
                                    Mỗi chi tiết trang trí đều tỉ mỉ, tinh tế, hương vị hòa quyện
                                    hoàn hảo giữa các lớp. Một chiếc bánh không chỉ để ăn mà còn
                                    để thưởng thức!”
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Testimonial Section End -->

        <!-- Team Section Begin -->
        <section class="team spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 col-md-7 col-sm-7">
                        <div class="section-title">
                            <span>Our team</span>
                            <h2>Sweet Baker</h2>
                        </div>
                    </div>
                </div>
                <div class="row team-row">
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-1.jpg">
                            <div class="team__item__text">
                                <h6>Trần Văn Tùng</h6>
                                <span>Leader</span>
                                <div class="team__item__social">
                                    <a href="https://www.facebook.com/tran.van.tung.232700" class="social-link">
                                        <i class="fa fa-facebook"></i>
                                    </a>
                                    <a href="https://www.instagram.com/tugg_tvt.22/" class="social-link">
                                        <i class="fa fa-instagram"></i>
                                    </a>
                                    <a href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA" class="social-link">
                                        <i class="fa fa-youtube-play"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-2.jpg">
                            <div class="team__item__text">
                                <h6>Phạm Hồng Quân</h6>
                                <span>Member</span>
                                <div class="team__item__social">
                                    <a href="https://www.facebook.com/quan.edition.9" class="social-link">
                                        <i class="fa fa-facebook"></i>
                                    </a>
                                    <a href="https://www.instagram.com/quannrau2410/" class="social-link">
                                        <i class="fa fa-instagram"></i>
                                    </a>
                                    <a href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA" class="social-link">
                                        <i class="fa fa-youtube-play"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-3.jpg">
                            <div class="team__item__text">
                                <h6>Ngô Sỹ Giá</h6>
                                <span>Member</span>
                                <div class="team__item__social">
                                    <a href="https://www.facebook.com/ngo.sy.gia.2024" class="social-link">
                                        <i class="fa fa-facebook"></i>
                                    </a>
                                    <a href="https://www.instagram.com/nsg0101/" class="social-link">
                                        <i class="fa fa-instagram"></i>
                                    </a>
                                    <a href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA" class="social-link">
                                        <i class="fa fa-youtube-play"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-4.jpg">
                            <div class="team__item__text">
                                <h6>Nguyễn Tiến Đạt</h6>
                                <span>Member</span>
                                <div class="team__item__social">
                                    <a href="https://www.facebook.com/profile.php?id=100051145252263" class="social-link">
                                        <i class="fa fa-facebook"></i>
                                    </a>
                                    <a href="https://www.instagram.com/dat.sieunhan.hihi/" class="social-link">
                                        <i class="fa fa-instagram"></i>
                                    </a>
                                    <a href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA" class="social-link">
                                        <i class="fa fa-youtube-play"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="team__item set-bg" data-setbg="img/team/team-5.jpg">
                            <div class="team__item__text">
                                <h6>Lê Quốc Hùng</h6>
                                <span>Member</span>
                                <div class="team__item__social">
                                    <a href="https://www.facebook.com/LHQ.17G" class="social-link">
                                        <i class="fa fa-facebook"></i>
                                    </a>
                                    <a href="https://www.instagram.com/lqh.17g/" class="social-link">
                                        <i class="fa fa-instagram"></i>
                                    </a>
                                    <a href="https://www.youtube.com/@Ti%E1%BB%87mb%C3%A1nhChan%C4%91%C3%AA" class="social-link">
                                        <i class="fa fa-youtube-play"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <style>
            .team {
                padding: 80px 0;
                background: #f8f9fa;
            }

            .team-row {
                display: flex;
                justify-content: center;
                flex-wrap: nowrap;
                margin: 0 -15px;
            }

            .team-row > div {
                padding: 0 15px;
                flex: 0 0 20%;
                max-width: 20%;
            }

            .team__item {
                position: relative;
                margin-bottom: 30px;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                aspect-ratio: 1;
            }

            .team__item:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            }

            .team__item::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(to bottom, rgba(0,0,0,0) 0%, rgba(0,0,0,0.8) 100%);
                opacity: 0;
                transition: all 0.3s ease;
            }

            .team__item:hover::before {
                opacity: 1;
            }

            .team__item__text {
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                padding: 20px;
                background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
                color: #fff;
                transform: translateY(100%);
                transition: all 0.3s ease;
            }

            .team__item:hover .team__item__text {
                transform: translateY(0);
            }

            .team__item__text h6 {
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 5px;
                color: #fff;
            }

            .team__item__text span {
                font-size: 14px;
                color: #f08632;
                display: block;
                margin-bottom: 15px;
            }

            .team__item__social {
                display: flex;
                gap: 10px;
            }

            .social-link {
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: rgba(255,255,255,0.1);
                border-radius: 50%;
                color: #fff;
                transition: all 0.3s ease;
            }

            .social-link:hover {
                background: #f08632;
                transform: translateY(-3px);
            }

            @media (max-width: 991px) {
                .team-row {
                    flex-wrap: wrap;
                }

                .team-row > div {
                    flex: 0 0 33.333333%;
                    max-width: 33.333333%;
                }
            }

            @media (max-width: 767px) {
                .team-row > div {
                    flex: 0 0 50%;
                    max-width: 50%;
                }
            }

            @media (max-width: 575px) {
                .team-row > div {
                    flex: 0 0 100%;
                    max-width: 100%;
                }
            }
        </style>
        <!-- Team Section End -->

        <!-- Footer Section Begin -->
        <footer class="footer set-bg" data-setbg="img/footer-bg.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="footer__widget">
                            <h6>WORKING HOURS</h6>
                            <ul>
                                <li>Monday - Friday: 08:00 am - 08:30 pm</li>
                                <li>Saturday: 10:00 am - 16:30 pm</li>
                                <li>Sunday: 10:00 am - 16:30 pm</li>
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