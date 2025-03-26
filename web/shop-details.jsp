<%@page import="dao.ReviewDAO"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Review" %>
<%@ page import="controller.ReviewServlet" %>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Cake Template">
        <meta name="keywords" content="Cake, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Cake | Template</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/flaticon.css" type="text/css">
        <link rel="stylesheet" href="css/barfiller.css" type="text/css">
        <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <script>
            function changeImage(imageUrl) {
                document.querySelector(".product__details__big__img img").src = imageUrl;
            }
        </script>
    </head>

    <body>
        <%
            HttpSession sessionObj = request.getSession(false); // Không tạo session mới nếu chưa có
            if (sessionObj != null && sessionObj.getAttribute("username") != null) {
        %>
        <p style="color:green;">Bạn đang đăng nhập với tài khoản: <%= sessionObj.getAttribute("username")%></p>
        <%
        } else {
        %>
        <p style="color:red;">Bạn chưa đăng nhập hoặc phiên làm việc đã hết hạn!</p>
        <%
            }
        %>


        <!-- Hiển thị thông báo nhắc nhở thanh toán (nếu có) -->
    <c:if test="${not empty sessionScope.paymentReminder}">
        <div style="color: red; text-align: center;">
            ${sessionScope.paymentReminder}
        </div>
        <c:remove var="paymentReminder" scope="session"/>
    </c:if>


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
                    <% HttpSession sessionObj1 = request.getSession(false);
                        String username = null;
                        String heartLink = "login";
                        String cartLink
                                = "login";
                        String profileLink = "login";
                        if (sessionObj
                                != null) {
                            username = (String) sessionObj.getAttribute("username");
                            if (username != null) {
                                heartLink = "wishlist";
                                cartLink
                                        = "shopping-cart.jsp";
                                profileLink = "profile";
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
            <a href="home"><img src="img/logo.png" alt="Logo" /></a>
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
                <li><a href="login" style="padding: 8px 15px">Sign In</a></li>
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
                                <a href="home">
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
                                    <a href="login" class="btn btn-outline-primary">
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
                            <li class="active"><a href="home">Home</a></li>
                            <li><a href="./about.jsp">About</a></li>
                            <li><a href="shop">Shop</a></li>
                            <li>
                                <a href="#">Pages</a>
                                <ul class="dropdown">
                                    <li><a href="./shop-details.jsp">Shop Details</a></li>
                                    <li><a href="./shopping-cart.jsp">Shopping Cart</a></li>
                                    <li><a href="./checkout.jsp">Check Out</a></li>
                                    <li><a href="wishlist">Wishlist</a></li>
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
                        <h2>Product detail</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <a href="./index.html">Home</a>
                        <a href="./shop.html">Shop</a>
                        <span>Sweet autumn leaves</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <%
        // Khai báo các biến ở phạm vi toàn cục
        String productIdParam = request.getParameter("product_id");
        int productId = 0;
        ProductDAO productDAO = new ProductDAO();
        Product product = null;

        if (productIdParam != null && !productIdParam.trim().isEmpty()) {
            try {
                productId = Integer.parseInt(productIdParam);
                product = productDAO.getProductById(productId);
            } catch (NumberFormatException e) {
                productId = 0;
            }
        }

        if (productId == 0 || product == null) {
            // Nếu không có product_id hoặc không tìm thấy sản phẩm, hiển thị sản phẩm mặc định
    %>
    <!-- Product Details Section Begin (Default Product) -->
    <section class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="product__details__img">
                        <div class="product__details__big__img">
                            <img
                                class="big_img"
                                src="img/shop/details/product-big-1.jpg"
                                alt="Sweet Autumn Leaves"
                                />
                        </div>
                        <div class="product__details__thumb">
                            <div class="pt__item active">
                                <img
                                    data-imgbigurl="img/shop/details/product-big-2.jpg"
                                    src="img/shop/details/product-big-2.jpg"
                                    alt=""
                                    onclick="changeImage('img/shop/details/product-big-2.jpg')"
                                    />
                            </div>
                            <div class="pt__item">
                                <img
                                    data-imgbigurl="img/shop/details/product-big-1.jpg"
                                    src="img/shop/details/product-big-1.jpg"
                                    alt=""
                                    onclick="changeImage('img/shop/details/product-big-1.jpg')"
                                    />
                            </div>
                            <div class="pt__item">
                                <img
                                    data-imgbigurl="img/shop/details/product-big-4.jpg"
                                    src="img/shop/details/product-big-4.jpg"
                                    alt=""
                                    onclick="changeImage('img/shop/details/product-big-4.jpg')"
                                    />
                            </div>
                            <div class="pt__item">
                                <img
                                    data-imgbigurl="img/shop/details/product-big-3.jpg"
                                    src="img/shop/details/product-big-3.jpg"
                                    alt=""
                                    onclick="changeImage('img/shop/details/product-big-3.jpg')"
                                    />
                            </div>
                            <div class="pt__item">
                                <img
                                    data-imgbigurl="img/shop/details/product-big-5.jpg"
                                    src="img/shop/details/product-big-5.jpg"
                                    alt=""
                                    onclick="changeImage('img/shop/details/product-big-5.jpg')"
                                    />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="product__details__text">
                        <div class="product__label">Cupcake</div>
                        <h4>SWEET AUTUMN LEAVES</h4>
                        <h5>$26.41</h5>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit, eiusmod
                            tempor incididunt ut labore et dolore magna aliqua. Quis ipsum
                            suspendisse ultrices gravida
                        </p>
                        <ul>
                            <li>SKU: <span>17</span></li>
                            <li>Category: <span>Biscuit cake</span></li>
                            <li>Tags: <span>Gadgets, minimalistic</span></li>
                        </ul>
                        <div class="product__details__option">
                            <div class="quantity">
                                <div class="pro-qty">
                                    <input type="text" value="2" />
                                </div>
                            </div>
                            <a href="#" class="primary-btn">Add to cart</a>
                            <a href="#" class="heart__btn"
                               ><span class="icon_heart_alt"></span
                                ></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product__details__tab">
                <div class="col-lg-12">
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a
                                class="nav-link active"
                                data-toggle="tab"
                                href="#tabs-1"
                                role="tab"
                                >Description</a
                            >
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab"
                               >Additional information</a
                            >
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab"
                               >Previews(1)</a
                            >
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tabs-1" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                    <p>
                                        This delectable Strawberry Pie is an extraordinary treat
                                        filled with sweet and tasty chunks of delicious
                                        strawberries. Made with the freshest ingredients, one bite
                                        will send you to summertime. Each gift arrives in an
                                        elegant gift box and arrives with a greeting card of your
                                        choice that you can personalize online!
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tabs-2" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                    <p>
                                        This delectable Strawberry Pie is an extraordinary treat
                                        filled with sweet and tasty chunks of delicious
                                        strawberries. Made with the freshest ingredients, one bite
                                        will send you to summertime. Each gift arrives in an
                                        elegant gift box and arrives with a greeting card of your
                                        choice that you can personalize online!2
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tabs-3" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                    <p>
                                        This delectable Strawberry Pie is an extraordinary treat
                                        filled with sweet and tasty chunks of delicious
                                        strawberries. Made with the freshest ingredients, one bite
                                        will send you to summertime. Each gift arrives in an
                                        elegant gift box and arrives with a greeting card of your
                                        choice that you can personalize online!3
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Details Section End (Default Product) -->
    <%
    } else {
        // Lấy các review từ ReviewDAO
        ReviewDAO reviewDAO = new ReviewDAO();
        List<Review> reviews = reviewDAO.getReviewsByProductId(productId);
    %>
    <!-- Product Details Section Begin -->
    <section class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="product__details__img">
                        <div class="product__details__big__img">
                            <img class="big_img" src="img/shop/product-<%= product.getProductId()%>.jpg" alt="<%= product.getName()%>">
                        </div>
                        <div class="product__details__thumb">
                            <div class="pt__item active">
                                <img onclick="changeImage('img/shop/details/product-<%= product.getProductId()%>-1.jpg')" src="img/shop/details/product-<%= product.getProductId()%>-1.jpg" alt="">
                            </div>
                            <div class="pt__item">
                                <img onclick="changeImage('img/shop/details/product-<%= product.getProductId()%>-2.jpg')" src="img/shop/details/product-<%= product.getProductId()%>-2.jpg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="product__details__text">
                        <div class="product__label">Cupcake</div>
                        <h4>
                            <%= product.getName()%>
                            <button class="btn btn-outline-danger favorite-btn ms-2" 
                                    data-product-id="<%= product.getProductId()%>" 
                                    onclick="toggleFavorite(<%= product.getProductId()%>, this)" 
                                    title="Add to favorites">
                                <i class="far fa-heart"></i>
                            </button>
                        </h4>
                        <h5><%= String.format("%.3f", product.getPrice())%>VND</h5>
                        <p><%= product.getDescription()%></p>
                        <ul>
                            <li>Stock: <span><%= product.getStock()%></span></li>
                            <li>Category: <span><%= product.getProductCategoryId()%></span></li>
                        </ul>
                        <div class="product__details__option">
                            <div class="quantity">
                                <div class="pro-qty">
                                    <input type="number" id="quantity" value="1" min="1" max="<%= product.getStock()%>">
                                </div>
                            </div>
                            <div class="product__details__cart">
                                <% if (sessionObj != null && sessionObj.getAttribute("username") != null) {%>
                                <a href="#" onclick="addToCartWithQuantity(<%= product.getProductId()%>);
                                        return false;" class="primary-btn">Add to cart</a>
                                <% } else { %>
                                <a href="login" class="primary-btn">Add to cart</a>
                                <% }%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Reviews Section -->
            <div class="product__details__tab">
                <div class="col-lg-12">
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">Description</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">Reviews</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tabs-1" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                    <p><%= product.getDescription()%></p>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tabs-3" role="tabpanel">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
                                            <h4>Đánh giá sản phẩm</h4>

                                            <!-- Hiển thị tổng quan đánh giá -->
                                            <div class="rating-overview mb-4">
                                                <div class="rating-summary text-center">
                                                    <h2 class="average-rating">
                                                        <%
                                                            double avgRating = 0;
                                                            int totalRatings = reviews != null ? reviews.size() : 0;
                                                            if (totalRatings > 0) {
                                                                for (Review review : reviews) {
                                                                    avgRating += review.getRating();
                                                                }
                                                                avgRating /= totalRatings;
                                                            }
                                                        %>
                                                        <%= String.format("%.1f", avgRating)%> <i class="fas fa-star text-warning"></i>
                                                    </h2>
                                                    <p class="text-muted">Dựa trên <%= totalRatings%> đánh giá</p>
                                                </div>
                                            </div>

                                            <!-- Form đánh giá -->
                                            <% if (sessionObj != null && sessionObj.getAttribute("username") != null) {
                                                    String username1 = (String) sessionObj.getAttribute("username");
                                            %>
                                            <div class="review-form bg-light p-4 rounded mb-4">
                                                <h5>Viết đánh giá của bạn</h5>
                                                <form action="review" method="post" id="reviewForm">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="product_id" value="<%= product.getProductId()%>">
                                                    <input type="hidden" name="username" value="<%= username%>">

                                                    <div class="form-group mb-3">
                                                        <label>Đánh giá của bạn:</label>
                                                        <div class="star-rating">
                                                            <input type="radio" id="star5" name="rating" value="5" required>
                                                            <label for="star5" title="5 sao">☆</label>
                                                            <input type="radio" id="star4" name="rating" value="4">
                                                            <label for="star4" title="4 sao">☆</label>
                                                            <input type="radio" id="star3" name="rating" value="3">
                                                            <label for="star3" title="3 sao">☆</label>
                                                            <input type="radio" id="star2" name="rating" value="2">
                                                            <label for="star2" title="2 sao">☆</label>
                                                            <input type="radio" id="star1" name="rating" value="1">
                                                            <label for="star1" title="1 sao">☆</label>
                                                        </div>
                                                    </div>

                                                    <div class="form-group mb-3">
                                                        <label for="comment">Nhận xét của bạn:</label>
                                                        <textarea class="form-control" id="comment" name="comment" 
                                                                  rows="4" required minlength="10" maxlength="500"
                                                                  placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm (tối thiểu 10 ký tự)"></textarea>
                                                        <div class="text-muted">
                                                            <small>Còn lại: <span id="charCount">500</span> ký tự</small>
                                                        </div>
                                                    </div>

                                                    <button type="submit" class="site-btn">Gửi đánh giá</button>
                                                </form>
                                            </div>
                                            <% } else { %>
                                            <div class="alert alert-info text-center mb-4">
                                                <i class="fas fa-info-circle"></i> 
                                                Vui lòng <a href="login" class="alert-link">đăng nhập</a> để viết đánh giá
                                            </div>
                                            <% } %>

                                            <!-- Danh sách đánh giá -->
                                            <div class="reviews-container">
                                                <% if (reviews == null || reviews.isEmpty()) { %>
                                                <div class="text-center py-5">
                                                    <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                                                    <p class="lead text-muted">Chưa có đánh giá nào cho sản phẩm này</p>
                                                    <p class="text-muted">Hãy là người đầu tiên chia sẻ trải nghiệm của bạn!</p>
                                                </div>
                                                <% } else { %>
                                                <div class="reviews-list">
                                                    <% for (Review review : reviews) {%>
                                                    <div class="review-item mb-4">
                                                        <div class="review-header d-flex justify-content-between align-items-center">
                                                            <div class="reviewer-info d-flex align-items-center">
                                                                <div class="avatar me-3">
                                                                    <img src="img/user-avatar.png" alt="Avatar" class="rounded-circle" width="50">
                                                                </div>
                                                                <div>
                                                                    <h6 class="mb-1"><%= review.getCustomerName()%></h6>
                                                                    <div class="rating">
                                                                        <% for (int i = 0; i < review.getRating(); i++) { %>
                                                                        <i class="fas fa-star text-warning"></i>
                                                                        <% } %>
                                                                        <% for (int i = review.getRating(); i < 5; i++) { %>
                                                                        <i class="far fa-star text-warning"></i>
                                                                        <% }%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <small class="text-muted">
                                                                <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(review.getReviewDate())%>
                                                            </small>
                                                        </div>
                                                        <div class="review-content mt-3" id="review-content-<%= review.getReviewId()%>">
                                                            <div class="view-mode" id="view-mode-<%= review.getReviewId()%>">
                                                                <p class="mb-0"><%= review.getComment()%></p>
                                                            </div>

                                                            <div class="edit-mode" id="edit-mode-<%= review.getReviewId()%>" style="display: none;">
                                                                <form action="review" method="post">
                                                                    <input type="hidden" name="action" value="edit">
                                                                    <input type="hidden" name="id" value="<%= review.getReviewId()%>">
                                                                    <input type="hidden" name="product_id" value="<%= review.getProductId()%>">
                                                                    <input type="hidden" name="customer_id" value="<%= review.getCustomerId()%>">
                                                                    <input type="hidden" name="username" value="<%= sessionObj.getAttribute("username")%>">

                                                                    <div class="form-group mb-3">
                                                                        <label>Đánh giá:</label>
                                                                        <div class="star-rating">
                                                                            <input type="radio" id="edit-star5-<%= review.getReviewId()%>" name="rating" value="5" <%= review.getRating() == 5 ? "checked" : ""%>>
                                                                            <label for="edit-star5-<%= review.getReviewId()%>" title="5 sao">☆</label>
                                                                            <input type="radio" id="edit-star4-<%= review.getReviewId()%>" name="rating" value="4" <%= review.getRating() == 4 ? "checked" : ""%>>
                                                                            <label for="edit-star4-<%= review.getReviewId()%>" title="4 sao">☆</label>
                                                                            <input type="radio" id="edit-star3-<%= review.getReviewId()%>" name="rating" value="3" <%= review.getRating() == 3 ? "checked" : ""%>>
                                                                            <label for="edit-star3-<%= review.getReviewId()%>" title="3 sao">☆</label>
                                                                            <input type="radio" id="edit-star2-<%= review.getReviewId()%>" name="rating" value="2" <%= review.getRating() == 2 ? "checked" : ""%>>
                                                                            <label for="edit-star2-<%= review.getReviewId()%>" title="2 sao">☆</label>
                                                                            <input type="radio" id="edit-star1-<%= review.getReviewId()%>" name="rating" value="1" <%= review.getRating() == 1 ? "checked" : ""%>>
                                                                            <label for="edit-star1-<%= review.getReviewId()%>" title="1 sao">☆</label>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group mb-3">
                                                                        <label for="edit-comment-<%= review.getReviewId()%>">Nội dung đánh giá:</label>
                                                                        <textarea class="form-control" id="edit-comment-<%= review.getReviewId()%>" 
                                                                                  name="comment" rows="4" required minlength="10" maxlength="500"><%= review.getComment()%></textarea>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <button type="submit" class="btn btn-primary btn-sm">Lưu</button>
                                                                        <button type="button" class="btn btn-secondary btn-sm" onclick="toggleEditForm(<%= review.getReviewId()%>)">Hủy</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                        <script>
                                                            function toggleEditForm(reviewId) {
                                                                const viewMode = document.getElementById('view-mode-' + reviewId);
                                                                const editMode = document.getElementById('edit-mode-' + reviewId);
                                                                const actionButtons = document.getElementById('review-actions-' + reviewId);

                                                                if (editMode.style.display === 'none') {
                                                                    // Chuyển sang chế độ chỉnh sửa
                                                                    viewMode.style.display = 'none';
                                                                    editMode.style.display = 'block';
                                                                    actionButtons.style.display = 'none';
                                                                } else {
                                                                    // Chuyển về chế độ xem
                                                                    viewMode.style.display = 'block';
                                                                    editMode.style.display = 'none';
                                                                    actionButtons.style.display = 'block';
                                                                }
                                                            }
                                                        </script>

                                                        <% if (sessionObj != null && sessionObj.getAttribute("username") != null
                                                                    && sessionObj.getAttribute("username").equals(review.getCustomerName())) {%>
                                                        <div class="review-actions mt-3" id="review-actions-<%= review.getReviewId()%>">
                                                            <button type="button" class="btn btn-sm btn-outline-primary me-2" onclick="toggleEditForm(<%= review.getReviewId()%>)">
                                                                <i class="fas fa-edit"></i> Sửa
                                                            </button>

                                                            <form action="review" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa đánh giá này không?');">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="<%= review.getReviewId()%>">
                                                                <input type="hidden" name="product_id" value="<%= review.getProductId()%>">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                                                    <i class="fas fa-trash"></i> Xóa
                                                                </button>
                                                            </form>
                                                        </div>
                                                        <% } %>
                                                    </div>
                                                    <% } %>
                                                </div>
                                                <% } %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Details Section End -->
    <%
        }
    %>

    <!-- Related Products Section Begin -->
    <section class="related-products spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="section-title">
                        <h2>Related Products</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <%
                        // Lấy danh sách sản phẩm liên quan
                        List<Product> relatedProducts = null;
                        int categoryId = 1; // Mặc định categoryId nếu không có sản phẩm

                        if (productId != 0 && product != null) {
                            categoryId = product.getProductCategoryId();
                        }

                        // Thêm log để kiểm tra
                        out.println("<!-- Debug: productId = " + productId + ", categoryId = " + categoryId + " -->");

                        try {
                            relatedProducts = productDAO.getRelatedProducts(productId, categoryId, 6);
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<!-- Debug: Exception in getRelatedProducts: " + e.getMessage() + " -->");
                        }

                        // Thêm log để kiểm tra kết quả
                        out.println("<!-- Debug: relatedProducts size = " + (relatedProducts != null ? relatedProducts.size() : "null") + " -->");

                        if (relatedProducts == null || relatedProducts.isEmpty()) {
                    %>
                    <div class="col-lg-12 text-center">
                        <p>No related products available.</p>
                    </div>
                    <%
                    } else {
                    %>
                    <div class="related__products__slider owl-carousel">
                        <%
                            for (Product relatedProduct : relatedProducts) {
                        %>
                        <div class="product__item">
                            <div class="product__item__pic set-bg" data-setbg="img/shop/product-<%= relatedProduct.getProductId()%>.jpg">
                                <div class="product__label">
                                    <span>Cupcake</span>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="shop-details.jsp?product_id=<%= relatedProduct.getProductId()%>"><%= relatedProduct.getName()%></a></h6>
                                <div class="product__item__price">$<%= relatedProduct.getPrice()%></div>
                                <div class="cart_add">
                                    <% if (sessionObj != null && sessionObj.getAttribute("username") != null) {%>
                                    <a href="#" onclick="addToCart(<%= relatedProduct.getProductId()%>); return false;">Add to cart</a>
                                    <% } else { %>
                                    <a href="login">Add to cart</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </section>
    <!-- Related Products Section End -->

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
                        <p>Lorem ipsum dolor amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                            labore dolore magna aliqua.</p>
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
                        <p class="copyright__text text-white">
                            Copyright ©
                            <script>document.write(new Date().getFullYear());</script>
                            All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
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
        <script src="https://messenger.svc.chative.io/static/v1.0/channels/sa333af83-d5b0-4954-8318-224f96b5912d/messenger.js?mode=livechat" defer="defer"></script>
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
    <script>
                                const contextPath = '${pageContext.request.contextPath}';
    </script>
    <script src="${pageContext.request.contextPath}/js/favorite.js"></script>
    <script>
                                // Initialize favorite buttons when the page loads
                                document.addEventListener('DOMContentLoaded', function () {
                                    initializeFavoriteButtons();
                                });
    </script>
    <script src="js/cart.js"></script>
    <script>
                                function addToCartWithQuantity(productId) {
                                    const quantity = document.getElementById('quantity').value;
                                    fetch('CartServlet', {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded',
                                        },
                                        body: 'action=add&id=' + productId + '&quantity=' + quantity
                                    })
                                            .then(response => response.json())
                                            .then(data => {
                                                if (data.error) {
                                                    if (data.error.includes("login")) {
                                                        window.location.href = "login";
                                                    } else {
                                                        alert(data.error);
                                                    }
                                                } else {
                                                    alert('Product added to cart successfully!');
                                                    updateCartDisplay(data);
                                                }
                                            })
                                            .catch(error => {
                                                console.error('Error:', error);
                                                alert('Error adding product to cart');
                                            });
                                }

                                function addToCart(productId) {
                                    fetch('CartServlet', {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded',
                                        },
                                        body: 'action=add&id=' + productId + '&quantity=1'
                                    })
                                            .then(response => response.json())
                                            .then(data => {
                                                if (data.error) {
                                                    if (data.error.includes("login")) {
                                                        window.location.href = "login";
                                                    } else {
                                                        alert(data.error);
                                                    }
                                                } else {
                                                    alert('Product added to cart successfully!');
                                                    updateCartDisplay(data);
                                                }
                                            })
                                            .catch(error => {
                                                console.error('Error:', error);
                                                alert('Error adding product to cart');
                                            });
                                }
    </script>
    <script>
        $(document).ready(function () {
            // Khởi tạo Owl Carousel cho Related Products
            $('.related__products__slider').owlCarousel({
                loop: true,
                margin: 30,
                nav: true,
                dots: false,
                responsive: {
                    0: {
                        items: 1
                    },
                    600: {
                        items: 2
                    },
                    1000: {
                        items: 4
                    }
                }
            });
        });
    </script>
</body>

</html>
