const productContainer = document.getElementById("product-container");
const searchInput = document.getElementById("search");
const sortSelect = document.getElementById("sort");
const categorySelect = document.getElementById("category");

const loading = document.getElementById("loading");
const error = document.getElementById("error");

let products = [];
let filteredProducts = [];

// Fetch Products
async function fetchProducts() {

    try {

        loading.style.display = "block";
        error.textContent = "";

        const response = await fetch("https://dummyjson.com/products");

        if (!response.ok) {
            throw new Error("Failed to fetch products");
        }

        const data = await response.json();

        products = data.products;
        filteredProducts = [...products];

        displayProducts(filteredProducts);
        loadCategories();

        loading.style.display = "none";

    } catch (err) {

        loading.style.display = "none";
        error.textContent = "❌ Failed to load products.";

        console.log(err);
    }

}

// Display Products
function displayProducts(productList) {

    productContainer.innerHTML = "";

    if (productList.length === 0) {

        productContainer.innerHTML = "<h2>No Products Found</h2>";
        return;

    }

    productList.map((product) => {

        productContainer.innerHTML += `

        <div class="product-card">

            <img src="${product.thumbnail}" alt="${product.title}">

            <div class="product-details">

                <h2>${product.title}</h2>

                <p><strong>Category:</strong> ${product.category}</p>

                <p><strong>Brand:</strong> ${product.brand}</p>

                <p class="price">$${product.price}</p>

                <p class="rating">⭐ ${product.rating}</p>

                <p>${product.description}</p>

            </div>

        </div>

        `;

    });

}

// Load Categories
function loadCategories() {

    const categories = [...new Set(products.map(product => product.category))];

    categories.forEach(category => {

        categorySelect.innerHTML += `
            <option value="${category}">
                ${category}
            </option>
        `;

    });

}

// Search Products
searchInput.addEventListener("input", () => {

    const searchValue = searchInput.value.toLowerCase();

    filteredProducts = products.filter(product =>
        product.title.toLowerCase().includes(searchValue)
    );

    applyFilters();

});

// Sort Products
sortSelect.addEventListener("change", applyFilters);

// Category Filter
categorySelect.addEventListener("change", applyFilters);

// Apply Search + Sort + Category
function applyFilters() {

    let tempProducts = [...products];

    // Search
    const searchValue = searchInput.value.toLowerCase();

    tempProducts = tempProducts.filter(product =>
        product.title.toLowerCase().includes(searchValue)
    );

    // Category
    const selectedCategory = categorySelect.value;

    if (selectedCategory !== "all") {

        tempProducts = tempProducts.filter(product =>
            product.category === selectedCategory
        );

    }

    // Sort

    if (sortSelect.value === "low-high") {

        tempProducts.sort((a, b) => a.price - b.price);

    }

    else if (sortSelect.value === "high-low") {

        tempProducts.sort((a, b) => b.price - a.price);

    }

    filteredProducts = tempProducts;

    displayProducts(filteredProducts);

}

// Start Application
fetchProducts();