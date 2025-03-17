
function searchProductsByName(keyword) {
    const resultsDiv = document.getElementById("search-results");

    if (keyword.length < 2) {
        resultsDiv.innerHTML = "";
        return;
    }

    // Hiển thị loading
    resultsDiv.innerHTML = '<div class="search-loading"></div>';

    fetch("search?keyword=" + encodeURIComponent(keyword))
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
