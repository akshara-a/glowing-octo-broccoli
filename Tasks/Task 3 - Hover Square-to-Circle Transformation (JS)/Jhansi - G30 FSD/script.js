const box = document.getElementById("box");

box.addEventListener("mouseover", () => {
  box.style.borderRadius = "50%";
});

box.addEventListener("mouseout", () => {
  box.style.borderRadius = "0";
});

