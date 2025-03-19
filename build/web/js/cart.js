function addToCart(productId) {
  fetch("CartServlet", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: "action=add&id=" + productId,
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.error) {
        if (data.error.includes("login")) {
          window.location.href = "login.jsp";
        } else {
          alert(data.error);
        }
      } else {
        alert("Product added to cart successfully!");
        updateCartDisplay(data);
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("Error adding product to cart");
    });
}

function updateCartDisplay(data) {
  // Update cart count
  const cartCountElements = document.querySelectorAll(
    ".cart-count, .header__top__right__cart span, .offcanvas__cart__item span"
  );
  cartCountElements.forEach((element) => {
    element.textContent = data.count;
  });

  // Update cart total
  const cartTotalElements = document.querySelectorAll(".cart__price span");
  cartTotalElements.forEach((element) => {
    element.textContent = "$" + data.total;
  });
}

// Fetch cart data on page load
document.addEventListener("DOMContentLoaded", function () {
  fetch("CartServlet")
    .then((response) => response.json())
    .then((data) => {
      if (!data.error) {
        updateCartDisplay(data);
      }
    })
    .catch((error) => {
      console.error("Error fetching cart:", error);
    });
});
