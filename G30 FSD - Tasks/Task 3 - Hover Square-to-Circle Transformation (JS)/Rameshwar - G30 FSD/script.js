const box = document.getElementById("shapeBox");

// Convert to circle on hover
box.addEventListener("mouseenter", () => {
    box.classList.add("circle");
});

// Convert back to square when mouse leaves
box.addEventListener("mouseleave", () => {
    box.classList.remove("circle");
});
