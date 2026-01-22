const box = document.getElementById("box");

box.addEventListener("mouseenter", function () {
  box.style.borderRadius = "50%";
  box.style.backgroundColor = "#FF5722";
  box.style.transform = "scale(1.2) rotate(180deg)";
});

box.addEventListener("mouseleave", function () {
  box.style.borderRadius = "0";
  box.style.backgroundColor = "#4CAF50";
  box.style.transform = "scale(1) rotate(0deg)";
});
