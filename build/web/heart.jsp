<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@page
import="java.util.List" %> <%@page import="java.util.ArrayList" %> <%@page
import="model.Product" %> <%@page import="dao.FavoriteProductDAO" %> <%@page
import="model.Customer" %> <%@page import="model.FavoriteProduct" %> <%
HttpSession sess = request.getSession(); Customer customer = (Customer)
sess.getAttribute("customer"); List<FavoriteProduct>
  favorites = new ArrayList<>(); if (customer != null) { FavoriteProductDAO
  favoriteDAO = new FavoriteProductDAO(); favorites =
  favoriteDAO.getFavoritesByCustomerId(customer.getCustomerId()); } if
  (favorites == null) { favorites = new ArrayList<>(); } %>

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
    </head>
    <body>
      <!-- Page Preloder -->
      <div id="preloder">
        <div class="loader"></div>
      </div>

      <!-- Offcanvas Menu Begin -->
      <div class="offcanvas-menu-overlay"></div>
      <div class="offcanvas-menu-wrapper">
        <div class="offcanvas__cart">
          <div class="offcanvas__cart__links">
            <a href="#" class="search-switch"
              ><img src="img/icon/search.png" alt=""
            /></a>
            <a href="wishlist"><img src="img/icon/heart.png" alt="" /></a>
          </div>
          <div class="offcanvas__cart__item">
            <a href="shoping-cart.jsp"
              ><img src="img/icon/cart.png" alt="" /> <span>0</span></a
            >
            <div class="cart__price">Cart: <span>$0.00</span></div>
          </div>
        </div>
        <div class="offcanvas__logo">
          <a href="./index.jsp"><img src="img/logo.png" alt="" /></a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__option">
          <ul>
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
                        <a href="#" class="search-switch"
                          ><img src="img/icon/search.png" alt=""
                        /></a>
                      </li>
                      <li>
                        <a href="wishlist"
                          ><img src="img/icon/heart.png" alt="Wishlist"
                        /></a>
                      </li>
                    </ul>
                  </div>
                  <div class="header__logo">
                    <a href="./index.jsp"><img src="img/logo.png" alt="" /></a>
                  </div>
                  <div class="header__top__right">
                    <div class="header__top__right__cart">
                      <a href="shoping-cart.jsp"
                        ><img src="img/icon/cart.png" alt="" />
                        <span>0</span></a
                      >
                      <div class="cart__price">Cart: <span>$0.00</span></div>
                    </div>
                    <div class="header__top__right__links">
                      <form
                        action="LogoutServlet"
                        method="post"
                        style="margin: 0; display: inline"
                      >
                        <button
                          type="submit"
                          class="btn btn-outline-primary"
                          style="margin-left: 10px"
                        >
                          Logout
                        </button>
                      </form>
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
                  <li><a href="./shop.html">Shop</a></li>
                  <li>
                    <a href="#">Pages</a>
                    <ul class="dropdown">
                      <li><a href="./shop-details.html">Shop Details</a></li>
                      <li><a href="./shoping-cart.html">Shopping Cart</a></li>
                      <li><a href="./checkout.html">Check Out</a></li>
                      <li><a href="./wishlist.html">Wishlist</a></li>
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

      <div class="container my-5">
        <div class="row">
          <div class="col-12">
            <h3 id="tops-section" class="text-center">FAVORITE PRODUCTS</h3>
            <div class="row">
              <% if (customer == null) { %>
              <p class="text-center">Please login to view your wishlist!</p>
              <% } else if (favorites.isEmpty()) { %>
              <p class="text-center">Your wishlist is empty!</p>
              <% } else { for (FavoriteProduct favorite : favorites) { Product p
              = favorite.getProduct(); %>
              <div class="col-md-3">
                <div class="card">
                  <a href="productdetails.jsp?id=<%= p.getProductId() %>">
                    <img
                      src="<%= p.getProductImg() %>"
                      class="card-img-top"
                      alt="<%= p.getName() %>"
                    />
                  </a>
                  <div class="card-body text-center">
                    <h5 class="card-title"><%= p.getName() %></h5>
                    <p class="card-text">
                      Price: <%= String.format("%.2f", p.getPrice()) %> $
                    </p>
                    <p class="card-text"><%= p.getDescription() %></p>
                    <a
                      href="productdetails.jsp?id=<%= p.getProductId() %>"
                      class="btn btn-primary"
                      >Buy Now</a
                    >
                  </div>
                </div>
              </div>
              <% } } %>
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
      </footer>
      <!-- Footer Section End -->

      <!-- Search Begin -->
      <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
          <div class="search-close-switch">+</div>
          <form class="search-model-form">
            <input
              type="text"
              id="search-input"
              placeholder="Search here....."
            />
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
    </body></html
></FavoriteProduct>
