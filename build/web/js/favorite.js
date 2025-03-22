function toggleFavorite(productId, favoriteBtn) {
  // Check if the product is already in favorites
  fetch(`${contextPath}/favorite/check?productId=${productId}`)
    .then((response) => response.json())
    .then((data) => {
      if (data.error) {
        window.location.href = `${contextPath}/login`;
        return;
      }

      const isFavorite = data.isFavorite;
      const action = isFavorite ? "remove" : "add";

      // Add or remove from favorites
      fetch(`${contextPath}/favorite/${action}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: `productId=${productId}`,
      })
        .then((response) => response.json())
        .then((result) => {
          if (result.success) {
            // Toggle the button appearance
            const icon = favoriteBtn.querySelector("i");
            if (action === "add") {
              icon.classList.remove("far");
              icon.classList.add("fas");
              favoriteBtn.title = "Remove from favorites";
            } else {
              icon.classList.remove("fas");
              icon.classList.add("far");
              favoriteBtn.title = "Add to favorites";
            }
          } else {
            alert("Failed to update favorites");
          }
        })
        .catch((error) => {
          console.error("Error:", error);
          alert("An error occurred while updating favorites");
        });
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("An error occurred while checking favorite status");
    });
}

// Function to initialize favorite buttons
function initializeFavoriteButtons() {
  const favoriteButtons = document.querySelectorAll(".favorite-btn");
  favoriteButtons.forEach((btn) => {
    const productId = btn.dataset.productId;

    // Check initial favorite status
    fetch(`${contextPath}/favorite/check?productId=${productId}`)
      .then((response) => response.json())
      .then((data) => {
        if (!data.error) {
          const icon = btn.querySelector("i");
          if (data.isFavorite) {
            icon.classList.remove("far");
            icon.classList.add("fas");
            btn.title = "Remove from favorites";
          } else {
            icon.classList.remove("fas");
            icon.classList.add("far");
            btn.title = "Add to favorites";
          }
        }
      })
      .catch((error) => console.error("Error:", error));
  });
}
