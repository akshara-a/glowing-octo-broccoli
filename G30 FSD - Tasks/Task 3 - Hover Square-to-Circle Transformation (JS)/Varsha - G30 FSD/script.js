const box = document.getElementById("box");
box.style.width = "150px";
box.style.height = "150px";
box.style.backgroundColor = "blue";
box.style.margin = "0 auto";
box.style.transition = "0.3s ease";

box.addEventListener("mouseover", () => {
    box.style.borderRadius = "50%";
    box.style.backgroundColor = "yellow";
});

box.addEventListener("mouseout", () => {
    box.style.borderRadius = "0";
    box.style.backgroundColor = "blue";
});