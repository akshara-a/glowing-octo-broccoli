let loggedIn = false;

function login(){

```
const btn = document.getElementById("loginBtn");

if(!loggedIn){

    btn.innerText = "Logout";

    btn.removeAttribute("data-bs-toggle");
    btn.removeAttribute("data-bs-target");

    loggedIn = true;

}
```

}

document.addEventListener("click", function(){

```
const btn = document.getElementById("loginBtn");

if(btn.innerText === "Logout"){

    btn.onclick = function(){

        btn.innerText = "Login";

        btn.setAttribute("data-bs-toggle","modal");
        btn.setAttribute("data-bs-target","#authModal");

        loggedIn = false;
    };
}
```

});
