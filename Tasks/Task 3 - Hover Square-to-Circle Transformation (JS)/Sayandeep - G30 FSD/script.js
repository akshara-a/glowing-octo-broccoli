document.addEventListener('DOMContentLoaded', () => {
    const shape = document.getElementById('shape');
    
    // 1. Add event listener for when the mouse moves over the shape (hover start)
    shape.addEventListener('mouseover', transformToCircle);

    // 2. Add event listener for when the mouse moves out of the shape (hover end)
    shape.addEventListener('mouseout', transformToSquare);

    // Transforms the shape into a circle and changes color.
    function transformToCircle() {
        // Apply transformation
        shape.style.borderRadius = '50%';
        shape.style.backgroundColor = '#dc3545'; 
        shape.style.cursor = 'pointer';
    }
    
    // Reverts the shape back to a square and the initial color.
    function transformToSquare() {
        // Remove transformation
        shape.style.borderRadius = '0';
        shape.style.backgroundColor = '#007bff'; 
    }
    
    console.log('Hover over the blue square to see the transformation!');
});