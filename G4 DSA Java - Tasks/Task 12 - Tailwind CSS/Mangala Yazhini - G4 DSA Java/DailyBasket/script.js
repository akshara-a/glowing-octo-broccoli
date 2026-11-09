// Contact Form

let form = document.querySelector("form");

form.addEventListener("submit", function(event) {

    event.preventDefault();

    alert("Thank you! Your message has been submitted.");

    form.reset();

});


// Buy Now Buttons

let buttons = document.querySelectorAll("button");

buttons.forEach(function(button) {

    button.addEventListener("click", function() {

        if (button.innerText === "Buy Now") {
            alert("Thank you for choosing this plan!");
        }

    });

});