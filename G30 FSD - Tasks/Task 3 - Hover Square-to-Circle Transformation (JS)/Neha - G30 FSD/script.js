const b = document.getElementById("square");
b.style.width = "150px";
b.style.height = "150px";

b.addEventListener("mouseover", () => {
    b.style.borderRadius = "50%";
    b.style.backgroundColor = "black";
});
b.addEventListener("mouseout", () => {
    b.style.borderRadius = "0";
    b.style.backgroundColor = "black";
});
