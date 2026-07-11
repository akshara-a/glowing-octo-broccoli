
document.body.style.margin = "0";
document.body.style.height = "100vh";
document.body.style.display = "flex";
document.body.style.justifyContent = "center";
document.body.style.alignItems = "center";
document.body.style.background = "#0f172a";


const box = document.createElement("div");


box.style.width = "150px";
box.style.height = "150px";
box.style.background = "linear-gradient(135deg, #38bdf8, #6366f1)";
box.style.borderRadius = "0px";
box.style.transition = "all 0.5s ease";
box.style.cursor = "pointer";
box.style.boxShadow = "0 10px 30px rgba(0,0,0,0.3)";

document.body.appendChild(box);


box.addEventListener("mouseenter", () => {
  box.style.borderRadius = "50%";
  box.style.transform = "scale(1.1)";
  box.style.boxShadow = "0 20px 40px rgba(0,0,0,0.5)";
});

// Leave → Square
box.addEventListener("mouseleave", () => {
  box.style.borderRadius = "0px";
  box.style.transform = "scale(1)";
  box.style.boxShadow = "0 10px 30px rgba(0,0,0,0.3)";
});
