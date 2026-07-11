const sq = document.getElementById("square");

        sq.addEventListener("mouseenter", () => {
            sq.style.borderRadius = "50%";    
            sq.style.backgroundColor = "red"; 
        });

        sq.addEventListener("mouseleave", () => {
            sq.style.borderRadius = "0";     
            sq.style.backgroundColor = "yellow";
        });