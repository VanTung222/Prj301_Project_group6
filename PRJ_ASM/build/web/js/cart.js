function applyDiscount() {
    const discountCode = document.getElementById("discountCode").value;
    if (!discountCode) {
        document.getElementById("discountMessage").innerText = "Please enter a discount code.";
        document.getElementById("discountMessage").style.color = "red";
        return;
    }

    fetch("CartServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
        },
        body: "action=applyDiscount&discountCode=" + encodeURIComponent(discountCode),
    })
    .then(response => response.json())
    .then(data => {
        if (data.error) {
            document.getElementById("discountMessage").innerText = data.error;
            document.getElementById("discountMessage").style.color = "red";
        } else {
            document.getElementById("discountMessage").innerText = `Discount Applied: ${data.discountPercentage}%`;
            document.getElementById("discountMessage").style.color = "green";
            document.getElementById("discountAmount").innerText = `$${data.discountAmount}`;
            document.getElementById("cart-subtotal").innerText = `$${data.subtotal}`;
            document.getElementById("cart-total").innerText = `$${data.finalTotal}`;
        }
    })
    .catch(error => {
        console.error("Error applying discount:", error);
        document.getElementById("discountMessage").innerText = "Error applying discount.";
        document.getElementById("discountMessage").style.color = "red";
    });
}








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
        } else if (data.error.includes("stock")) {
          alert(
            "Sorry, this product is out of stock or not enough stock available."
          );
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
  fetchCart();
});

function fetchCart() {
  fetch("CartServlet")
    .then((response) => response.json())
    .then((data) => {
      if (!data.error) {
        renderCart(data.cart);
        updateCartDisplay(data);
        // Update subtotal and total
        const subtotalElement = document.getElementById("cart-subtotal");
        const totalElement = document.getElementById("cart-total");
        if (subtotalElement) subtotalElement.innerText = `$${data.total}`;
        if (totalElement) totalElement.innerText = `$${data.total}`;
      }
    })
    .catch((error) => console.error("Error fetching cart:", error));
}

function renderCart(cart) {
  let cartItemsContainer = document.getElementById("cart-items");
  if (!cartItemsContainer) return;

  cartItemsContainer.innerHTML = "";

  if (cart.length === 0) {
    cartItemsContainer.innerHTML = `
      <tr>
        <td colspan="4" style="text-align: center; padding: 20px;">
          Your cart is empty. <a href="shop.jsp">Continue shopping</a>
        </td>
      </tr>
    `;
    return;
  }

  cart.forEach((item) => {
    let row = document.createElement("tr");
    row.innerHTML = `
      <td class="product__cart__item">
        <div class="product__cart__item__pic">
          <img src="${item.image}" alt="${item.name}">
        </div>
        <div class="product__cart__item__text">
          <h6>${item.name}</h6>
          <h5>$${item.price.toFixed(2)}</h5>
        </div>
      </td>
      <td class="quantity__item">
        <div class="quantity">
          <button class="quantity-btn decrease" data-id="${item.id}" ${
      item.quantity <= 1 ? "disabled" : ""
    }>-</button>
          <input type="text" value="${item.quantity}" data-id="${
      item.id
    }" readonly>
          <button class="quantity-btn increase" data-id="${item.id}">+</button>
        </div>
      </td>
      <td class="cart__price" data-price="${item.price}">$${(
      item.price * item.quantity
    ).toFixed(2)}</td>
      <td class="cart__close">
        <span class="delete-item" data-id="${
          item.id
        }" style="color:red; cursor:pointer;">X</span>
      </td>
    `;
    cartItemsContainer.appendChild(row);
  });

  // Add event listeners for quantity buttons
  document.querySelectorAll(".increase").forEach((btn) => {
    btn.addEventListener("click", function () {
      const id = this.dataset.id;
      updateQuantity(id, 1);
    });
  });

  document.querySelectorAll(".decrease").forEach((btn) => {
    btn.addEventListener("click", function () {
      if (!this.disabled) {
        const id = this.dataset.id;
        updateQuantity(id, -1);
      }
    });
  });

  document.querySelectorAll(".delete-item").forEach((btn) => {
    btn.addEventListener("click", function () {
      confirmDelete(this.dataset.id);
    });
  });
}

function updateQuantity(id, change) {
  // Get current quantity from the input field
  const input = document.querySelector(`input[data-id="${id}"]`);
  if (!input) return;

  const currentQuantity = parseInt(input.value);
  const newQuantity = currentQuantity + change;

  if (newQuantity < 1) {
    alert("Quantity cannot be less than 1");
    return;
  }

  fetch("CartServlet", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `action=update&id=${id}&quantity=${newQuantity}`,
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.error) {
        if (data.error.includes("stock")) {
          alert("Sorry, not enough stock available.");
        } else if (data.error.includes("not found")) {
          alert("Item not found in cart. Please refresh the page.");
          fetchCart(); // Refresh cart to show current state
        } else {
          alert(data.error);
        }
      } else {
        // Update the input value immediately for better UX
        input.value = newQuantity;
        // Update the total price for this item
        const priceCell = input.closest("tr").querySelector(".cart__price");
        const itemPrice = parseFloat(priceCell.getAttribute("data-price") || 0);
        priceCell.textContent = `$${(itemPrice * newQuantity).toFixed(2)}`;
        // Update cart totals
        updateCartDisplay(data);
      }
    })
    .catch((error) => {
      console.error("Error updating quantity:", error);
      alert("Error updating quantity. Please try again.");
    });
}

function confirmDelete(id) {
  if (confirm("Are you sure you want to remove this item from your cart?")) {
    fetch("CartServlet", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: `action=remove&id=${id}`,
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.error) {
          alert(data.error);
        } else {
          fetchCart();
        }
      })
      .catch((error) => {
        console.error("Error removing item:", error);
        alert("Error removing item from cart");
      });
  }
}




function applyDiscount() {
            const discountCode = document.getElementById("discountCode").value;
            if (!discountCode) {
                document.getElementById("discountMessage").innerText = "Please enter a discount code.";
                document.getElementById("discountMessage").style.color = "red";
                return;
            }

            fetch("CartServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: "action=applyDiscount&discountCode=" + encodeURIComponent(discountCode),
            })
            .then(response => response.json())
            .then(data => {
                if (data.error) {
                    document.getElementById("discountMessage").innerText = data.error;
                    document.getElementById("discountMessage").style.color = "red";
                } else {
                    document.getElementById("discountMessage").innerText = `Discount Applied: ${data.discountPercentage}%`;
                    document.getElementById("discountMessage").style.color = "green";
                    document.getElementById("discountAmount").innerText = `$${data.discountAmount}`;
                    document.getElementById("cart-subtotal").innerText = `$${data.subtotal}`;
                    document.getElementById("cart-total").innerText = `$${data.finalTotal}`;
                }
            })
            .catch(error => {
                console.error("Error applying discount:", error);
                document.getElementById("discountMessage").innerText = "Error applying discount.";
                document.getElementById("discountMessage").style.color = "red";
            });
        }
