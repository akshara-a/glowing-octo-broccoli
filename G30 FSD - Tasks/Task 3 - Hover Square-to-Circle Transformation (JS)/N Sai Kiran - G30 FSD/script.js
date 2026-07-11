 const sq = document.getElementById("square");
    const colors = ["yellow", "green", "blue", "purple", "orange"];
    let index = 0;
    sq.addEventListener("mouseenter", () => {
      sq.style.borderRadius = "50%";             
      sq.style.backgroundColor = colors[index];  
      index = (index + 1) % colors.length;       
    });
    sq.addEventListener("mouseleave", () => {
      sq.style.borderRadius = "0";                
      sq.style.backgroundColor = "red";           
    });