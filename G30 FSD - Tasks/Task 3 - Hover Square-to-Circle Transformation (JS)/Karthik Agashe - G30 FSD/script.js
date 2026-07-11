const shape = document.getElementById("shape");

shape.addEventListener("mouseenter", () => {
  shape.style.borderRadius = "50%";
  shape.style.backgroundColor = "#22c55e";
});

shape.addEventListener("mouseleave", () => {
  shape.style.borderRadius = "0%";
  shape.style.backgroundColor = "#2563eb";
});
