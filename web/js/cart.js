document.addEventListener("DOMContentLoaded", function () {
    const cartTotalElements = document.querySelectorAll(".cart__price span");
    const cartCountElement = document.getElementById("cartCount");

    function updateCartUI(data) {
        cartTotalElements.forEach(el => {
            el.textContent = `$${data.total}`;
        });
        if (cartCountElement) {
            cartCountElement.textContent = data.count;
        }
    }

    function fetchCartData() {
        fetch("CartServlet")
            .then(response => response.json())
            .then(data => updateCartUI(data))
            .catch(error => console.error("Error fetching cart data:", error));
    }

    document.querySelectorAll(".add-to-cart").forEach((button) => {
        button.addEventListener("click", function (event) {
            event.preventDefault();
            let productElement = this.closest(".product__item");
            let id = productElement.getAttribute("data-id");
            fetch("CartServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `id=${id}`
            })
            .then(response => response.json())
            .then(data => updateCartUI(data))
            .catch(error => console.error("Error adding to cart:", error));
        });
    });

    document.addEventListener("click", function (event) {
        if (event.target.classList.contains("remove-from-cart")) {
            let id = event.target.getAttribute("data-id");
            fetch("RemoveFromCartServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `id=${id}`
            })
            .then(response => response.json())
            .then(() => fetchCartData())
            .catch(error => console.error("Error removing from cart:", error));
        }
    });

    fetchCartData();
});
