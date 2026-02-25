const box = document.getElementById("shapeBox");

    box.addEventListener("mouseover", () => {
        box.style.borderRadius = "50%";
        box.style.backgroundColor = "red";
    });

    box.addEventListener("mouseout", () => {
        box.style.borderRadius = "0";
        box.style.backgroundColor = "blue";
    });