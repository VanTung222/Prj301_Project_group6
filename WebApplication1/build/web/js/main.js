/*  ---------------------------------------------------
 Theme Name: Cake
 Description: Cake e-commerce tamplate
 Author: Colorib
 Author URI: https://www.colorib.com/
 Version: 1.0
 Created: Colorib
 ---------------------------------------------------------  */

"use strict";

console.log("JS Loaded");
window.addToCart = function () {
    console.log("Item added to cart");
};


//document.addEventListener("DOMContentLoaded", function () {
//    checkLoginStatus();
//});
//
//// ✅ Kiểm tra trạng thái đăng nhập
//function checkLoginStatus() {
//    fetch("CheckSessionServlet")
//        .then(response => response.json())
//        .then(data => {
//            if (data.loggedIn) {
//                document.getElementById("userAvatar").src = data.avatar || "img/default-user.png";
//                document.getElementById("userAvatar").style.display = "block";
//                document.getElementById("logoutBtn").style.display = "inline-block";
//            }
//        });
//}
//
//// ✅ Đăng xuất
//function logout() {
//    fetch("LogoutServlet", { method: "POST" })
//        .then(() => window.location.reload());
//}
//
//// ✅ Thêm sản phẩm vào giỏ hàng
//function addToCart(productName, price) {
//    fetch("CartServlet", {
//        method: "POST",
//        headers: { "Content-Type": "application/x-www-form-urlencoded" },
//        body: `productName=${productName}&price=${price}`
//    })
//        .then(response => response.json())
//        .then(data => {
//            if (data.status === "success") {
//                updateCartTotal(price);
//            } else {
//                alert("Please login first!");
//            }
//        });
//}
//
//// ✅ Cập nhật tổng tiền trong giỏ hàng
//function updateCartTotal(price) {
//    let cartTotal = parseFloat(document.getElementById("cartTotal").textContent.replace("$", ""));
//    cartTotal += parseFloat(price);
//    document.getElementById("cartTotal").textContent = `$${cartTotal.toFixed(2)}`;
//}



document.addEventListener("DOMContentLoaded", function () {
    const cartTotalElements = document.querySelectorAll(".cart__price span"); // Tổng tiền
    const cartCountElement = document.getElementById("cartCount"); // Số lượng sản phẩm trong giỏ hàng

    // 🛒 Cập nhật giao diện giỏ hàng từ dữ liệu server
    function updateCartUI(data) {
        if (data.total !== undefined && data.count !== undefined) {
            // Cập nhật tổng tiền
            cartTotalElements.forEach(el => {
                el.textContent = `$${data.total}`;
            });

            // Cập nhật số lượng sản phẩm
            if (cartCountElement) {
                cartCountElement.textContent = data.count;
            }

            // Lưu dữ liệu vào localStorage để duy trì trạng thái giỏ hàng
            localStorage.setItem("cart", JSON.stringify(data));
        } else {
            console.error("Lỗi: Response từ server không hợp lệ", data);
        }
    }

    // 🛒 Khi tải trang, lấy dữ liệu giỏ hàng từ server
    function fetchCartData() {
        fetch("CartServlet")
            .then(response => response.json())
            .then(data => {
                console.log("Dữ liệu giỏ hàng từ server:", data);
                updateCartUI(data);
            })
            .catch(error => console.error("Lỗi khi lấy dữ liệu giỏ hàng:", error));
    }

    // 🛒 Xử lý khi click vào nút "Add to Cart"
    const cartButtons = document.querySelectorAll(".add-to-cart");

    cartButtons.forEach((button) => {
        button.addEventListener("click", function (event) {
            event.preventDefault();

            let productElement = this.closest(".product__item");
            let id = productElement.getAttribute("data-id");
            let name = productElement.querySelector(".product__item__text h6 a").innerText;
            let price = parseFloat(productElement.getAttribute("data-price"));
            let description = productElement.querySelector(".product__label span").innerText;

            console.log("Gửi request với:", { id, name, price, description });

            if (!id || isNaN(price)) {
                console.error("Lỗi: ID hoặc Price không hợp lệ");
                return;
            }

            // 🛒 Gửi request đến CartServlet để thêm sản phẩm
            fetch("CartServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `id=${id}&name=${encodeURIComponent(name)}&price=${price}&description=${encodeURIComponent(description)}`
            })
            .then(response => response.json())  // Chuyển đổi response thành JSON
            .then(data => {
                console.log("Dữ liệu nhận từ server:", data);
                updateCartUI(data); // Cập nhật giao diện giỏ hàng
            })
            .catch(error => console.error("Lỗi khi gửi request đến CartServlet:", error));
        });
    });

    // 🛒 Khi tải trang, tự động cập nhật giỏ hàng
    fetchCartData();
});











//document.addEventListener("DOMContentLoaded", function () {
//    let cartTotal = 0;
//    const cartTotalElements = document.querySelectorAll(".cart__price span"); // Lấy tất cả các thẻ tổng tiền
//
//    const cartButtons = document.querySelectorAll(".add-to-cart");
//
//    cartButtons.forEach((button) => {
//        button.addEventListener("click", function (event) {
//            event.preventDefault();
//
//            let productElement = this.closest(".product__item");
//            let id = productElement.getAttribute("data-id");
//            let name = productElement.querySelector(".product__item__text h6 a").innerText;
//            let price = parseFloat(productElement.getAttribute("data-price"));
//            let description = productElement.querySelector(".product__label span").innerText;
//
//            console.log("Gửi request với:", { id, name, price, description });
//
//            if (!id || isNaN(price)) {
//                console.error("Lỗi: ID hoặc Price không hợp lệ");
//                return;
//            }
//
//            fetch("CartServlet", {
//                method: "POST",
//                headers: { "Content-Type": "application/x-www-form-urlencoded" },
//                body: `id=${id}&name=${encodeURIComponent(name)}&price=${price}&description=${encodeURIComponent(description)}`
//            })
//            .then(response => response.text())
//            .then(total => {
//                console.log("Tổng tiền từ server sau khi thêm vào giỏ:", total);
//
//                // Cập nhật tất cả các thẻ tổng tiền trên UI
//                cartTotalElements.forEach(el => {
//                    el.textContent = `$${total}`;
//                });
//            })
//            .catch(error => console.error("Lỗi khi gửi request đến CartServlet:", error));
//        });
//    });
//});


//document.addEventListener("DOMContentLoaded", function () {
//    let cartTotal = 0;
//    const cartTotalElement = document.querySelector(".cart__price span");
//
//    const cartButtons = document.querySelectorAll(".add-to-cart");
//
//    cartButtons.forEach((button) => {
//        button.addEventListener("click", function (event) {
//            event.preventDefault();
//
//            let productElement = this.closest(".product__item");
//            let id = productElement.getAttribute("data-id");
//            let name = productElement.querySelector(".product__item__text h6 a").innerText;
//            let price = parseFloat(productElement.getAttribute("data-price"));
//            let description = productElement.querySelector(".product__label span").innerText;
//
//            console.log("Gửi request với:", { id, name, price, description });
//
//            if (!id || isNaN(price)) {
//                console.error("Lỗi: ID hoặc Price không hợp lệ");
//                return;
//            }
//
//            fetch("CartServlet", {
//                method: "POST",
//                headers: { "Content-Type": "application/x-www-form-urlencoded" },
//                body: `id=${id}&name=${encodeURIComponent(name)}&price=${price}&description=${encodeURIComponent(description)}`
//            })
//            .then(response => response.text())
//            .then(total => {
//                console.log("Tổng tiền từ server sau khi thêm vào giỏ:", total);
//                cartTotalElement.textContent = `$${total}`;
//            })
//            .catch(error => console.error("Lỗi khi gửi request đến CartServlet:", error));
//        });
//    });
//});














//cập nhật thay đổi số lượng hoặc xóa sản phẩm

function updateQuantity(id, change) {
    fetch("CartServlet", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: `update=true&id=${id}&change=${change}`
    })
            .then(response => response.text())
            .then(() => location.reload());
}

function removeItem(id) {
    fetch("CartServlet", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: `remove=true&id=${id}`
    })
            .then(response => response.text())
            .then(() => location.reload());
}


















(function ($) {
    /*------------------
     Preloader
     --------------------*/
    $(window).on("load", function () {
        $(".loader").fadeOut();
        $("#preloder").delay(200).fadeOut("slow");
    });

    /*------------------
     Background Set
     --------------------*/
    $(".set-bg").each(function () {
        var bg = $(this).data("setbg");
        $(this).css("background-image", "url(" + bg + ")");
    });

    //Search Switch
    $(".search-switch").on("click", function () {
        $(".search-model").fadeIn(400);
    });

    $(".search-close-switch").on("click", function () {
        $(".search-model").fadeOut(400, function () {
            $("#search-input").val("");
        });
    });

    //Canvas Menu
    $(".canvas__open").on("click", function () {
        $(".offcanvas-menu-wrapper").addClass("active");
        $(".offcanvas-menu-overlay").addClass("active");
    });

    $(".offcanvas-menu-overlay").on("click", function () {
        $(".offcanvas-menu-wrapper").removeClass("active");
        $(".offcanvas-menu-overlay").removeClass("active");
    });

    /*------------------
     Navigation
     --------------------*/
    $(".mobile-menu").slicknav({
        prependTo: "#mobile-menu-wrap",
        allowParentLinks: true,
    });

    /*-----------------------
     Hero Slider
     ------------------------*/
    $(".hero__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 1,
        dots: false,
        nav: true,
        navText: [
            "<i class='fa fa-angle-left'><i/>",
            "<i class='fa fa-angle-right'><i/>",
        ],
        animateOut: "fadeOut",
        animateIn: "fadeIn",
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: false,
    });

    /*--------------------------
     Categories Slider
     ----------------------------*/
    $(".categories__slider").owlCarousel({
        loop: true,
        margin: 22,
        items: 5,
        dots: false,
        nav: true,
        navText: [
            "<span class='arrow_carrot-left'><span/>",
            "<span class='arrow_carrot-right'><span/>",
        ],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: false,
        responsive: {
            0: {
                items: 1,
                margin: 0,
            },
            480: {
                items: 2,
            },
            768: {
                items: 3,
            },
            992: {
                items: 4,
            },
            1200: {
                items: 5,
            },
        },
    });

    /*-----------------------------
     Testimonial Slider
     -------------------------------*/
    $(".testimonial__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 2,
        dots: true,
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true,
        responsive: {
            0: {
                items: 1,
            },
            768: {
                items: 2,
            },
        },
    });

    /*---------------------------------
     Related Products Slider
     ----------------------------------*/
    $(".related__products__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 4,
        dots: false,
        nav: true,
        navText: [
            "<span class='arrow_carrot-left'><span/>",
            "<span class='arrow_carrot-right'><span/>",
        ],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true,
        responsive: {
            0: {
                items: 1,
            },
            480: {
                items: 2,
            },
            768: {
                items: 3,
            },
            992: {
                items: 4,
            },
        },
    });

    /*--------------------------
     Select
     ----------------------------*/
    $("select").niceSelect();

    /*------------------
     Magnific
     --------------------*/
    $(".video-popup").magnificPopup({
        type: "iframe",
    });

    /*------------------
     Barfiller
     --------------------*/
    $("#bar1").barfiller({
        barColor: "#111111",
        duration: 2000,
    });
    $("#bar2").barfiller({
        barColor: "#111111",
        duration: 2000,
    });
    $("#bar3").barfiller({
        barColor: "#111111",
        duration: 2000,
    });

    /*------------------
     Single Product
     --------------------*/
    $(".product__details__thumb img").on("click", function () {
        $(".product__details__thumb .pt__item").removeClass("active");
        $(this).addClass("active");
        var imgurl = $(this).data("imgbigurl");
        var bigImg = $(".big_img").attr("src");
        if (imgurl != bigImg) {
            $(".big_img").attr({
                src: imgurl,
            });
        }
    });






    /*-------------------
     Quantity change
     --------------------- */
    var proQty = $(".pro-qty");
    proQty.prepend('<span class="dec qtybtn">-</span>');
    proQty.append('<span class="inc qtybtn">+</span>');
    proQty.on("click", ".qtybtn", function () {
        var $button = $(this);
        var oldValue = $button.parent().find("input").val();
        if ($button.hasClass("inc")) {
            var newVal = parseFloat(oldValue) + 1;
        } else {
            // Don't allow decrementing below zero
            if (oldValue > 0) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                newVal = 0;
            }
        }
        $button.parent().find("input").val(newVal);
    });

    $(".product__details__thumb").niceScroll({
        cursorborder: "",
        cursorcolor: "rgba(0, 0, 0, 0.5)",
        boxzoom: false,
    });
})(jQuery);

// login
// Login JavaScript
function openAuthPopup() {
    document.getElementById("authPopup").classList.add("show");
    document.getElementById("popupOverlay").classList.add("show");
}

function closeAuthPopup() {
    document.getElementById("authPopup").classList.remove("show");
    document.getElementById("popupOverlay").classList.remove("show");
}

document.addEventListener("DOMContentLoaded", function () {
    const signInButtons = document.querySelectorAll(".sign-in-btn");
    const container = document.getElementById("container-login");
    const registerBtn = document.getElementById("register");
    const loginBtn = document.getElementById("login");

    signInButtons.forEach(function (button) {
        button.addEventListener("click", function (event) {
            event.preventDefault();
            openAuthPopup();
        });
    });

    document
            .getElementById("popupOverlay")
            .addEventListener("click", closeAuthPopup);

    registerBtn.addEventListener("click", function () {
        container.classList.add("active");
    });

    loginBtn.addEventListener("click", function () {
        container.classList.remove("active");
    });
});
// hết login
