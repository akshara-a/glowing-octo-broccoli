const box = document.getElementById("box");
box.addEventListener("mouseover", () => {
  box.style.borderRadius = "50%";           
  box.style.backgroundColor = "yellow";      
});

box.addEventListener("mouseout", () => {
  box.style.borderRadius = "0";              
  box.style.backgroundColor = "rgb(0, 132, 255)"; 
});
