// ================= DARK MODE =================

const darkBtn = document.getElementById("darkModeBtn");

if(darkBtn){

    darkBtn.addEventListener("click",()=>{

        document.body.classList.toggle("dark-mode");

    });

}



// ================= EMPLOYEE SEARCH =================

const searchInput = document.getElementById("searchInput");

if(searchInput){

    searchInput.addEventListener("keyup",()=>{

        let filter = searchInput.value.toLowerCase();

        let rows = document.querySelectorAll("tbody tr");

        rows.forEach((row)=>{

            let text = row.innerText.toLowerCase();

            row.style.display =
                text.includes(filter)
                ? ""
                : "none";

        });

    });

}



// ================= LOGIN FORM =================

const loginForm = document.getElementById("loginForm");

if(loginForm){

    loginForm.addEventListener("submit",(e)=>{

        e.preventDefault();

        alert("Login Successful!");

    });

}



// ================= REGISTER FORM =================

const registerForm = document.getElementById("registerForm");

if(registerForm){

    registerForm.addEventListener("submit",(e)=>{

        e.preventDefault();

        alert("Registration Successful!");

    });

}



// ================= CONTACT FORM =================

const contactForm = document.getElementById("contactForm");

if(contactForm){

    contactForm.addEventListener("submit",(e)=>{

        e.preventDefault();

        alert("Message Sent Successfully!");

    });

}