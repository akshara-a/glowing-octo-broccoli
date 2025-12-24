const shape = document.getElementById('shape');

function toggle() {
  const active = shape.classList.toggle('active');
  shape.setAttribute('aria-pressed', String(active));
}

shape.addEventListener('click', toggle);

shape.addEventListener('keydown', (e) => {
  if (e.key === 'Enter' || e.key === ' ') {
    e.preventDefault();
    toggle();
  }
});

document.addEventListener('click', (e) => {
  if (!shape.contains(e.target) && shape.classList.contains('active')) {
    shape.classList.remove('active');
    shape.setAttribute('aria-pressed', 'false');
  }
});

shape.addEventListener('pointerenter', () => shape.classList.add('hovering'));
shape.addEventListener('pointerleave', () => shape.classList.remove('hovering'));
