<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Offcanvas Menu Begin -->
        <div class="offcanvas-menu-overlay"></div>
        <div class="offcanvas-menu-wrapper">
            <div class="offcanvas__cart">

                <div class="offcanvas__cart__links">
                    <a href="#" class="search-switch"><img src="img/icon/search.png" alt="Search" /></a>
                        <%
                            HttpSession sessionObj = request.getSession(false);
                            String username = null;
                            String heartLink = "login.jsp";
                            String cartLink = "login.jsp";
                            String profileLink = "login.jsp";
                            
                            if (sessionObj != null) {
                                username = (String) sessionObj.getAttribute("username");
                                if (username != null) {
                                    heartLink = "wishlist";
                                    cartLink = "shoping-cart.html";
                                    profileLink = "profile";
                                }
                            }
                        %>
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
                                        <a href="<%= cartLink%>"><img src="img/icon/cart.png" alt="Cart" /> <span>0</span></a>
                                        <div class="cart__price">Cart: <span>$0.00</span></div>
                                    </div>

                                    <!-- User Menu -->
                                    <div class="header__top__right__links">
                                        <% if (username != null) { %>
                                            <div class="user-menu">
                                                <a href="<%= profileLink%>" class="profile-link">
                                                    <img src="img/icon/person_logo.jpg" alt="Profile" class="profile-img" />
                                                </a>
                                                <form action="LogoutServlet" method="post" class="logout-form">
                                                    <button type="submit" class="btn btn-outline-danger">
                                                        <i class="fa fa-sign-out"></i> Logout
                                                    </button>
                                                </form>
                                            </div>
                                        <% } else { %>
                                            <a href="login.jsp" class="btn btn-outline-primary">
                                                <i class="fa fa-sign-in"></i> Sign In
                                            </a>
                                        <% } %>
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