<%@page import="model.Product"%> <%@ page import="java.util.List" %> <%@ page
import="model.Review" %> <%@ page import="controller.ReviewServlet" %> <%@ page
contentType="text/html" pageEncoding="UTF-8"%>
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
          <a href="#" class="search-switch"
            ><img src="img/icon/search.png" alt="Search"
          /></a>
          <% HttpSession sessionObj = request.getSession(false); String username
          = null; String heartLink = "login.jsp"; String cartLink = "login.jsp";
          String profileLink = "login.jsp"; if (sessionObj != null) { username =
          (String) sessionObj.getAttribute("username"); if (username != null) {
          heartLink = "wishlist"; cartLink = "shoping-cart.html"; profileLink =
          "profile"; } }%> %>
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
                <li class="active"><a href="./index.jsp">Home</a></li>
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
                <h6>Tr?n V?n Tùng</h6>
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
                <h6>Ph?m H?ng Quân</h6>
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
                <h6>Ngô S? Giá</h6>
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
                <h6>Lê Qu?c Hùng</h6>
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
              <h2>Khách hàng c?a chúng tôi nói</h2>
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
                  "Tôi ?ã mua bánh này ?? làm quà sinh nh?t cho b?n thân, và nó
                  th?c s? gây ?n t??ng m?nh! H?p bánh ???c trang trí ??p m?t,
                  h??ng v? th?m ngon, không quá ng?t mà v?n ??m ?à. M?t món quà
                  tuy?t v?i dành cho nh?ng ng??i yêu bánh ng?t."
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
                  ?Chi?c bánh này th?c s? khi?n tôi b?t ng?! L?p kem m?m m?n,
                  ng?t v?a ph?i k?t h?p v?i c?t bánh bông x?p, tan ngay trong
                  mi?ng. M?i mi?ng c?n ??u mang l?i c?m giác nh? m?t b?a ti?c
                  h??ng v?! Ch?c ch?n s? quay l?i mua thêm.?
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
                  ?Bánh r?t th?m và m?m, v? ng?t v?a ph?i. Tuy nhiên, l?p kem
                  h?i nhi?u so v?i kh?u v? c?a mình, n?u gi?m m?t chút thì s?
                  hoàn h?o h?n. Dù v?y, ch?c ch?n mình v?n s? quay l?i mua l?n
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
                  ?Mình r?t thích v? bánh, ??c bi?t là l?p bông lan m?m x?p và
                  không b? khô. Nh?ng l?n này giao hàng h?i lâu h?n mong ??i.
                  N?u c?i thi?n t?c ?? giao hàng thì ch?c ch?n 5 sao!?
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
                    <h5>Tr?n Th? Khánh Linh</h5>
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
                  ?Bánh ngon, m?m m?n, nh?ng không quá khác bi?t so v?i m?t s?
                  ti?m khác. Mình mong ch? m?t h??ng v? ??c ?áo h?n. Dù v?y,
                  d?ch v? r?t t?t, nhân viên t? v?n nhi?t tình!?
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
                    <h5>T? Uyên</h5>
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
                  ?Chi?c bánh này không ch? ngon mà còn ??p ??n m?c không n? ?n!
                  M?i chi ti?t trang trí ??u t? m?, tinh t?, h??ng v? hòa quy?n
                  hoàn h?o gi?a các l?p. M?t chi?c bánh không ch? ?? ?n mà còn
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

    <div class="search-model">
      <div class="search-wrap">
        <div class="search-close-switch">
          <i class="fa fa-times"></i>
        </div>
        <form action="searchne" method="GET" class="search-form">
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

    <style>
      .search-model {
        position: fixed;
        width: 100%;
        height: 80px;
        left: 0;
        top: 0;
        background: rgba(255, 255, 255, 0.98);
        z-index: 99999;
        display: none;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        animation: slideDown 0.3s ease-out;
      }

      @keyframes slideDown {
        from {
          transform: translateY(-100%);
        }
        to {
          transform: translateY(0);
        }
      }

      .search-wrap {
        max-width: 800px;
        width: 100%;
        margin: 0 auto;
        padding: 15px 20px;
        position: relative;
      }

      .search-close-switch {
        position: absolute;
        right: 25px;
        top: 50%;
        transform: translateY(-50%);
        width: 30px;
        height: 30px;
        background: transparent;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        z-index: 1;
      }

      .search-close-switch i {
        color: #333;
        font-size: 20px;
        transition: all 0.3s ease;
      }

      .search-close-switch:hover i {
        color: #f08632;
        transform: rotate(90deg);
      }

      .search-input-wrap {
        position: relative;
      }

      .search-icon {
        position: absolute;
        left: 20px;
        top: 50%;
        transform: translateY(-50%);
        color: #666;
        font-size: 18px;
      }

      .search-form input {
        width: 100%;
        height: 50px;
        background: #f5f5f5;
        border: 2px solid transparent;
        border-radius: 25px;
        padding: 0 50px;
        font-size: 16px;
        color: #333;
        transition: all 0.3s ease;
      }

      .search-form input::placeholder {
        color: #999;
      }

      .search-form input:focus {
        border-color: #f08632;
        background: #fff;
        outline: none;
        box-shadow: 0 0 15px rgba(240, 134, 50, 0.1);
      }

      .search-results {
        position: absolute;
        top: 80px;
        left: 50%;
        transform: translateX(-50%);
        width: 800px;
        max-width: 95vw;
        background: #fff;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        max-height: calc(100vh - 120px);
        overflow-y: auto;
        padding: 20px;
        z-index: 1000;
      }

      .search-result-item {
        background: #fff;
        border-radius: 12px;
        margin-bottom: 20px;
        overflow: hidden;
        transition: all 0.4s ease;
        display: flex;
        border: 1px solid #f0f0f0;
        position: relative;
      }

      .search-result-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(240, 134, 50, 0.15);
        border-color: #f08632;
      }

      .search-result-image {
        width: 180px;
        height: 180px;
        flex-shrink: 0;
        position: relative;
        overflow: hidden;
        background: #f8f8f8;
      }

      .search-result-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: all 0.6s ease;
      }

      .search-result-item:hover .search-result-image img {
        transform: scale(1.12);
      }

      .search-result-info {
        flex: 1;
        padding: 25px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
      }

      .search-result-name {
        margin-bottom: 15px;
      }

      .search-result-name a {
        color: #333;
        font-size: 22px;
        font-weight: 700;
        text-decoration: none;
        transition: all 0.3s ease;
        line-height: 1.3;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
      }

      .search-result-name a:hover {
        color: #f08632;
      }

      .search-result-details {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        gap: 20px;
        flex-wrap: wrap;
      }

      .search-result-price {
        color: #f08632;
        font-size: 24px;
        font-weight: 800;
        display: flex;
        align-items: center;
      }

      .search-result-price::before {
        content: "$";
        font-size: 16px;
        margin-right: 2px;
        font-weight: 600;
      }

      .search-result-stock {
        color: #666;
        font-size: 14px;
        display: flex;
        align-items: center;
        background: #f5f5f5;
        padding: 6px 12px;
        border-radius: 20px;
      }

      .search-result-stock i {
        color: #f08632;
        margin-right: 6px;
      }

      .search-result-description {
        color: #666;
        font-size: 15px;
        line-height: 1.6;
        margin-bottom: 20px;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
      }

      .search-result-actions {
        display: flex;
        gap: 15px;
        margin-top: auto;
      }

      .search-result-btn {
        padding: 10px 22px;
        border-radius: 25px;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
      }

      .btn-view {
        background: #f08632;
        color: #fff;
        flex: 1;
      }

      .btn-view:hover {
        background: #e67422;
        transform: translateX(3px);
      }

      .btn-cart {
        background: #f5f5f5;
        color: #333;
        border: 1px solid #eee;
      }

      .btn-cart:hover {
        background: #f08632;
        color: #fff;
        border-color: #f08632;
      }

      .search-result-empty,
      .search-result-error {
        text-align: center;
        padding: 40px 20px;
        color: #666;
      }

      .search-result-empty i,
      .search-result-error i {
        font-size: 48px;
        color: #f08632;
        margin-bottom: 15px;
        display: block;
      }

      .search-result-empty h3,
      .search-result-error h3 {
        color: #333;
        font-size: 20px;
        margin-bottom: 10px;
        font-weight: 600;
      }

      .search-result-empty p,
      .search-result-error p {
        color: #666;
        font-size: 15px;
      }

      .search-results::-webkit-scrollbar {
        width: 8px;
      }

      .search-results::-webkit-scrollbar-track {
        background: #f5f5f5;
        border-radius: 4px;
      }

      .search-results::-webkit-scrollbar-thumb {
        background: #ddd;
        border-radius: 4px;
        transition: all 0.3s ease;
      }

      .search-results::-webkit-scrollbar-thumb:hover {
        background: #f08632;
      }

      @media (max-width: 768px) {
        .search-results {
          padding: 15px;
        }

        .search-result-item {
          flex-direction: column;
        }

        .search-result-image {
          width: 100%;
          height: 200px;
        }

        .search-result-info {
          padding: 20px;
        }

        .search-result-name a {
          font-size: 18px;
        }

        .search-result-price {
          font-size: 20px;
        }

        .search-result-description {
          font-size: 14px;
          margin-bottom: 15px;
        }

        .search-result-btn {
          padding: 8px 18px;
          font-size: 13px;
        }
      }

      /* Animation cho kết quả tìm kiếm */
      @keyframes fadeInUp {
        from {
          opacity: 0;
          transform: translate(-50%, 20px);
        }
        to {
          opacity: 1;
          transform: translate(-50%, 0);
        }
      }

      .search-results {
        animation: fadeInUp 0.4s ease-out;
      }

      .search-result-item {
        animation: fadeIn 0.5s ease-out forwards;
        opacity: 0;
      }

      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(20px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .search-result-item:nth-child(1) {
        animation-delay: 0.1s;
      }
      .search-result-item:nth-child(2) {
        animation-delay: 0.2s;
      }
      .search-result-item:nth-child(3) {
        animation-delay: 0.3s;
      }
      .search-result-item:nth-child(4) {
        animation-delay: 0.4s;
      }
      .search-result-item:nth-child(5) {
        animation-delay: 0.5s;
      }

      /* Hiệu ứng loading */
      .search-loading {
        text-align: center;
        padding: 40px 20px;
      }

      .search-loading::after {
        content: "";
        display: block;
        width: 40px;
        height: 40px;
        margin: 0 auto;
        border: 3px solid #f5f5f5;
        border-top-color: #f08632;
        border-radius: 50%;
        animation: spin 0.8s linear infinite;
      }

      @keyframes spin {
        to {
          transform: rotate(360deg);
        }
      }
    </style>

    <script>
      function searchProductsByName(keyword) {
        const resultsDiv = document.getElementById("search-results");

        if (keyword.length < 2) {
          resultsDiv.innerHTML = "";
          return;
        }

        // Hiển thị loading
        resultsDiv.innerHTML = '<div class="search-loading"></div>';

        fetch("searchne?keyword=" + encodeURIComponent(keyword))
          .then((response) => response.text())
          .then((html) => {
            if (html.trim() === "") {
              resultsDiv.innerHTML = `
                <div class="search-result-empty">
                  <i class="fa fa-search"></i>
                  <h3>No products found</h3>
                  <p>Try different keywords or check your spelling</p>
                </div>`;
            } else {
              const tempDiv = document.createElement("div");
              tempDiv.innerHTML = html;

              // Transform the results into our new format
              const products = Array.from(
                tempDiv.querySelectorAll(".product-card")
              ).map((card) => {
                const img = card.querySelector("img").src;
                const name = card.querySelector(".product-name a").textContent;
                const price = card.querySelector(".product-price").textContent;
                const description = card.querySelector(
                  ".product-description"
                ).textContent;
                const stock = card.querySelector(".product-stock").textContent;
                const link = card.querySelector(".product-name a").href;

                return `
                  <div class="search-result-item">
                    <div class="search-result-image">
                      <img src="${img}" alt="${name}">
                    </div>
                    <div class="search-result-info">
                      <div>
                        <h3 class="search-result-name">
                          <a href="${link}">${name}</a>
                        </h3>
                        <div class="search-result-details">
                          <div class="search-result-price">${price.replace(
                            "$",
                            ""
                          )}</div>
                          <div class="search-result-stock">
                            <i class="fa fa-cube"></i>${stock}
                          </div>
                        </div>
                        <p class="search-result-description">${description}</p>
                      </div>
                      <div class="search-result-actions">
                        <a href="${link}" class="search-result-btn btn-view">
                          View Details <i class="fa fa-arrow-right"></i>
                        </a>
                        <a href="#" class="search-result-btn btn-cart">
                          <i class="fa fa-shopping-cart"></i> Add to Cart
                        </a>
                      </div>
                    </div>
                  </div>
                `;
              });

              resultsDiv.innerHTML = products.join("");
            }
          })
          .catch((error) => {
            console.error("Search error:", error);
            resultsDiv.innerHTML = `
              <div class="search-result-error">
                <i class="fa fa-exclamation-circle"></i>
                <h3>Oops! Something went wrong</h3>
                <p>Please try again later</p>
              </div>`;
          });
      }
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
  </body>
</html>
