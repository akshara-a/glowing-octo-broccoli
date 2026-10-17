const productContainer = document.getElementById("productContainer");
const loading = document.getElementById("loading");
const error = document.getElementById("error");

const searchInput = document.getElementById("searchInput");
const sortSelect = document.getElementById("sortSelect");
const categorySelect = document.getElementById("categorySelect");
const productCount = document.getElementById("productCount");

let products = [];
let filteredProducts = [];

async function getProducts(){

    try{

        loading.style.display="block";
        error.textContent="";

        const response=await fetch("https://dummyjson.com/products");

        if(!response.ok){
            throw new Error("Unable to Fetch Products");
        }

        const data=await response.json();

        products=data.products;
        filteredProducts=[...products];

        populateCategories();

        displayProducts(filteredProducts);

    }

    catch(err){

        error.textContent =
"❌ Unable to fetch products. Please check your internet connection and try again.";

    }

    finally{

        loading.style.display="none";

    }

}

function displayProducts(productList){

    productContainer.innerHTML="";

    
    productCount.textContent =
    `Showing ${productList.length} Products`;

    if(productList.length===0){

       productContainer.innerHTML = `
<div class="no-products">
    <h2>😔 No Products Found</h2>
    <p>Try searching with another product name.</p>
</div>
`;
        return;

    }

    productList.forEach(product=>{

        const card=document.createElement("div");

        card.className="card";
card.innerHTML = `
    <img src="${product.thumbnail}" alt="${product.title}">

    <div class="card-content">

        <h2>${product.title}</h2>

        <p><strong>Brand:</strong> ${product.brand}</p>

        <p><strong>Category:</strong> ${product.category}</p>

        <p><strong>Stock:</strong> ${product.stock}</p>

        <p><strong>Discount:</strong> ${product.discountPercentage.toFixed(1)}%</p>

        <p class="price">₹ ${product.price}</p>

        <p class="rating">⭐ ${product.rating}</p>

        <p>${product.description}</p>

    </div>
`;

        productContainer.appendChild(card);

    });

}

searchInput.addEventListener("input",()=>{

    const value=searchInput.value.toLowerCase();

    filteredProducts=products.filter(product=>

        product.title.toLowerCase().includes(value)

    );

    applySort();

});

sortSelect.addEventListener("change",applySort);

function applySort(){

    let temp=[...filteredProducts];

    if(sortSelect.value==="low"){

        temp.sort((a,b)=>a.price-b.price);

    }

    else if(sortSelect.value==="high"){

        temp.sort((a,b)=>b.price-a.price);

    }

    displayProducts(temp);

}

function populateCategories(){

    categorySelect.innerHTML =
    '<option value="all">All Categories</option>';

    const categories = [...new Set(products.map(product => product.category))];

    categories.forEach(category => {

        const option = document.createElement("option");

        option.value = category;

        option.textContent = category;

        categorySelect.appendChild(option);

    });

}

categorySelect.addEventListener("change",()=>{

    const category=categorySelect.value;

    if(category==="all"){

        filteredProducts=[...products];

    }

    else{

        filteredProducts=products.filter(product=>product.category===category);

    }

    applySort();

});

getProducts();