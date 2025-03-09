<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
</head>

<body><header class="header">
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
                            <li><a href="./index.html">Home</a></li>
                            <li><a href="./about.html">About</a></li>
                            <li class="active"><a href="./shop.html">Shop</a></li>
                            <li><a href="#">Pages</a>
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
   
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <h2>Shop</h2>
                    <section class="search-section">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-6">
                                    <form id="search-form" class="search-form">
                                        <div class="input-group">
                                            <input oninput="searchProductsByName(this)"type="text" id="search" name="search" placeholder="Tìm sản phẩm..." class="form-control">
                                            <div class="input-group-append">
                                                <button class="btn btn-primary" type="submit"><i class="fa fa-search"></i> Search</button>
                                            </div>
                                        </div>
                                    </form>
                                    <div id="search-results"></div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <section class="shop spad">
        <div class="container">
            <div class="row" id="product-list">
                <% List<Product> productList = (List<Product>) request.getAttribute("productList");
                   if (productList != null && !productList.isEmpty()) {
                       for (Product product : productList) { %>
                           <div class="col-lg-3 col-md-6 col-sm-6">
                               <div class="product__item">
                                   <div class="product__item__pic set-bg" style="background-image: url('img/shop/product-<%= product.getProductId() %>.jpg');">
                                       <div class="product__label">
                                           <span>Cupcake</span>
                                       </div>
                                   </div>
                                   <div class="product__item__text">
                                       <h6><a href="shop-details.jsp?product_id=<%= product.getProductId() %>"><%= product.getName() %></a></h6>
                                       <div class="product__item__price">$<%= product.getPrice() %></div>
                                       <div class="cart_add">
                                           <a href="#">Add to cart</a>
                                       </div>
                                   </div>
                               </div>
                           </div>
                <%    } 
                   } else { %>
                       <p style='color:red;'>⚠ No products available.</p>
                <% } %>
            </div>
        </div>
    </section>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
    $("#search").on("input", function () {
        var searchQuery = $(this).val().trim();
        
        if (searchQuery === "") {
            $("#search-results").html("");
            return;
        }

        $.ajax({
            url: "SearchServlet",
            method: "GET",
            data: { search: searchQuery },
            success: function (response) {
                $("#search-results").html(response).show();
            },
            error: function () {
                console.error("Lỗi khi tải dữ liệu, vui lòng thử lại.");
            }
        });
    });

    $(document).on("click", ".search-item", function () {
        var productName = $(this).text();
        $("#search").val(productName);
        $("#search-results").html("").hide();
    });
});
</script>


</body>
</html>
