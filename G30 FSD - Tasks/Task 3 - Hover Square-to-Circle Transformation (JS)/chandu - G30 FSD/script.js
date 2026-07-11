
const shape = document.getElementById("shape");


shape.addEventListener("mouseenter", () => {
  shape.style.borderRadius = "50%";
  shape.style.background = "#4ade80"; 
});


shape.addEventListener("mouseleave", () => {
  shape.style.borderRadius = "0%";
  shape.style.background = "#111"; 
});
