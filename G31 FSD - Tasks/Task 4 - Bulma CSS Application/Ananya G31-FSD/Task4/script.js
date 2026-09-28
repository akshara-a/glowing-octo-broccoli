let cart = 0;

function addToCart(){

    cart++;

    document.getElementById("cartCount").textContent = cart;

    alert("Item added to cart!");
}

function shopNow(){

    document.getElementById("products").scrollIntoView({

        behavior:"smooth"

    });

}

function searchProducts(){

    let input = document
        .getElementById("search")
        .value
        .toLowerCase();

    let products = document.getElementsByClassName("product");

    for(let i=0;i<products.length;i++){

        let name = products[i]
            .querySelector(".title")
            .textContent
            .toLowerCase();

        if(name.includes(input)){

            products[i].style.display="block";

        }

        else{

            products[i].style.display="none";

        }

    }

}