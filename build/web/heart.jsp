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
                    </footer>
                    <!-- Footer Section End -->

                    <!-- Search Begin -->
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
