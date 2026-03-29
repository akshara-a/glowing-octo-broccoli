const box = document.getElementById('box');

box.addEventListener('mouseenter', () => {
    box.classList.add('circle');
});

box.addEventListener('mouseleave', () => {
    box.classList.remove('circle');
});
