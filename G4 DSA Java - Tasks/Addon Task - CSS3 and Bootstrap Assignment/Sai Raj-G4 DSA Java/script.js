// ==========================================
// SmartBank - Online Banking Dashboard
// script.js
// ==========================================


// ==========================================
// Smooth Counter Animation
// ==========================================

const counters = document.querySelectorAll("h3");

counters.forEach(counter => {

    const text = counter.innerText.replace(/[^0-9]/g, "");

    if (text !== "") {

        let target = parseInt(text);

        let count = 0;

        let increment = Math.ceil(target / 80);

        const updateCounter = () => {

            if (count < target) {

                count += increment;

                if (count > target) {

                    count = target;

                }

                counter.innerText = "₹" + count.toLocaleString();

                requestAnimationFrame(updateCounter);

            }

        };

        updateCounter();

    }

});



// ==========================================
// Transfer Money Button
// ==========================================

const transferButton = document.querySelector(".btn-success");

if (transferButton) {

    transferButton.addEventListener("click", function (event) {

        event.preventDefault();

        alert("Money Transfer Request Submitted Successfully.");

    });

}



// ==========================================
// Contact Form
// ==========================================

const contactForm = document.querySelector("#support form");

if (contactForm) {

    contactForm.addEventListener("submit", function (event) {

        event.preventDefault();

        alert("Thank you for contacting SmartBank.");

        contactForm.reset();

    });

}



// ==========================================
// Highlight Active Navbar Link
// ==========================================

const navLinks = document.querySelectorAll(".nav-link");

navLinks.forEach(link => {

    link.addEventListener("click", function () {

        navLinks.forEach(item => {

            item.classList.remove("active");

        });

        this.classList.add("active");

    });

});



// ==========================================
// Back To Top Button
// ==========================================

const topButton = document.createElement("button");

topButton.innerHTML = "↑";

topButton.id = "topBtn";

document.body.appendChild(topButton);

topButton.style.position = "fixed";
topButton.style.bottom = "20px";
topButton.style.right = "20px";
topButton.style.width = "45px";
topButton.style.height = "45px";
topButton.style.border = "none";
topButton.style.borderRadius = "50%";
topButton.style.background = "#0d6efd";
topButton.style.color = "#fff";
topButton.style.fontSize = "22px";
topButton.style.cursor = "pointer";
topButton.style.display = "none";
topButton.style.zIndex = "999";

window.addEventListener("scroll", function () {

    if (window.scrollY > 300) {

        topButton.style.display = "block";

    } else {

        topButton.style.display = "none";

    }

});

topButton.addEventListener("click", function () {

    window.scrollTo({

        top: 0,

        behavior: "smooth"

    });

});



// ==========================================
// Card Hover Effect
// ==========================================

const cards = document.querySelectorAll(".card");

cards.forEach(card => {

    card.addEventListener("mouseenter", function () {

        this.style.transform = "translateY(-8px)";

    });

    card.addEventListener("mouseleave", function () {

        this.style.transform = "translateY(0px)";

    });

});



// ==========================================
// Progress Bar Animation
// ==========================================

const progressBars = document.querySelectorAll(".progress-bar");

window.addEventListener("load", function () {

    progressBars.forEach(bar => {

        let width = bar.style.width;

        bar.style.width = "0%";

        setTimeout(function () {

            bar.style.width = width;

        }, 500);

    });

});



// ==========================================
// Console Message
// ==========================================

console.log("SmartBank Dashboard Loaded Successfully.");