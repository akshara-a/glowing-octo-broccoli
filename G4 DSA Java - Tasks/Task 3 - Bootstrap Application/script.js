let cartCount = 0;
let totalPrice = 0;

function addToCart(price){
    cartCount++;
    totalPrice += price;

    document.getElementById("cartCount").innerText = cartCount;
    document.getElementById("totalPrice").innerText = totalPrice;

    alert("Product Added To Cart Successfully");
}

function toggleDarkMode(){
    document.body.classList.toggle("dark-mode");
}