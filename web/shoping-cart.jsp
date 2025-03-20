<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@page
import="java.util.List" %> <%@page import="java.util.ArrayList" %> <%@page
import="model.Product" %> <%@page import="dao.FavoriteProductDAO" %> <%@page
import="model.Customer" %> <%@page import="model.FavoriteProduct" %> <%@page
import="model.CartItem" %> <%@page import="dao.CartDAO" %> <% HttpSession sess =
request.getSession(); Customer customer = (Customer)
sess.getAttribute("customer"); List<CartItem>
  cartItems = new ArrayList<>(); double totalAmount = 0; if (customer != null) {
  CartDAO cartDAO = new CartDAO(); cartItems =
  cartDAO.getCartItems(customer.getCustomerId()); for (CartItem item :
  cartItems) { totalAmount += item.getTotalPrice(); } } %>

  <!DOCTYPE html>
  <html lang="zxx">
    <head>
      <meta charset="UTF-8" />
      <meta name="description" content="Cake Template" />
      <meta name="keywords" content="Cake, unica, creative, html" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta http-equiv="X-UA-Compatible" content="ie=edge" />
      <title>Shopping Cart - Cake Shop</title>

      <!--Google Font-->
      <link
        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap"
        rel="stylesheet"
      />
      <link
        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap"
        rel="stylesheet"
      />

      <!--Css Styles-->
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
      <link rel="stylesheet" href="css/shoping-cart.css" type="text/css" />
    </head>

    <body>
      <!--Page Preloder-->
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
            <% HttpSession sessionObj = request.getSession(false); String
            username = null; String heartLink = "login.jsp"; String cartLink =
            "login.jsp"; String profileLink = "login.jsp"; if (sessionObj !=
            null) { username = (String) sessionObj.getAttribute("username"); if
            (username != null) { heartLink = "wishlist"; cartLink =
            "shopping-cart.jsp"; profileLink = "profile"; } }%> %>
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
                      <a href="./shopping-cart.jsp"
                        ><img src="img/icon/cart.png" alt="" />
                        <span id="cartCount">0</span></a
                      >
                      <div id="cart__price" class="cart__price">
                        Cart: <span>$0.00</span>
                      </div>
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
                      <li><a href="./shopping-cart.jsp">Shopping Cart</a></li>
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

      <!--Breadcrumb Begin-->
      <div class="breadcrumb-option">
        <div class="container">
          <div class="row">
            <div class="col-lg-12">
              <div class="breadcrumb__links">
                <a href="./index.jsp"><i class="fa fa-home"></i> Home</a>
                <span>Shopping Cart</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!--Breadcrumb End-->

      <!-- Shopping Cart Section Begin -->
      <section class="shopping-cart">
        <div class="container">
          <h2 class="cart-title">Your Shopping Cart</h2>
          <div class="row">
            <div class="col-lg-8">
              <div class="cart-table">
                <table>
                  <thead>
                    <tr>
                      <th>Product</th>
                      <th>Quantity</th>
                      <th>Total</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody id="cart-items">
                    <!-- Cart items will be dynamically inserted here -->
                  </tbody>
                </table>
              </div>
              <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                  <div class="continue__btn">
                    <a href="shop.jsp">Continue Shopping</a>
                  </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                  <div class="continue__btn update__btn">
                    <a href="#" onclick="fetchCart(); return false;"
                      >Update Cart</a
                    >
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-4">
              <div class="cart__discount">
                <h6>Discount codes</h6>
                <form action="#">
                  <input type="text" placeholder="Enter your coupon code" />
                  <button type="submit">Apply</button>
                </form>
              </div>
              <div class="cart__total">
                <h6>Cart total</h6>
                <ul>
                  <li>Subtotal <span id="cart-subtotal">$0.00</span></li>
                  <li>Total <span id="cart-total">$0.00</span></li>
                </ul>
                <a href="#" class="primary-btn">Proceed to checkout</a>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- Shopping Cart Section End -->

      <!--Shopping Cart Section End-->

      <!--Footer Section Begin-->
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
                  Link back to Colorlib can't be removed. Template is licensed
                  under CC BY 3.0. Copyright &copy;
                  <script>
                    document.write(new Date().getFullYear());
                  </script>
                  All rights reserved | This template is made with
                  <i class="fa fa-heart" aria-hidden="true"></i> by
                  <a href="https://colorlib.com" target="_blank">Colorlib</a>
                  Link back to Colorlib can't be removed. Template is licensed
                  under CC BY 3.0.
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
      <!--Footer Section End-->

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

      <!--Js Plugins-->
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
      <script src="js/cart.js"></script>
    </body></html
></CartItem>
