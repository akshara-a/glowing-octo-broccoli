const input = document.getElementById('pokemonInput');
const searchBtn = document.getElementById('searchBtn');
const loading = document.getElementById('loading');
const error = document.getElementById('error');
const result = document.getElementById('result');
searchBtn.addEventListener('click', fetchPokemon);
input.addEventListener('keypress', (e) => {
  if (e.key === 'Enter') fetchPokemon();
});
async function fetchPokemon() {
  const name = input.value.toLowerCase().trim();
  if (!name) return;
  loading.textContent = ' Loading...';
  error.textContent = '';
  result.innerHTML = '';
  try {
    const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${name}`);
    if (!response.ok) throw new Error('Not found');
    const data = await response.json();
    loading.textContent = '';
    result.innerHTML = `
      <div class="pokemon-card">
        <img src="${data.sprites.other['official-artwork'].front_default}" alt="${data.name}">
        <h2>${data.name.toUpperCase()}</h2>
        <p>#${String(data.id).padStart(3, '0')}</p>
        <div class="types">
          ${data.types.map(t => `<span class="type">${t.type.name}</span>`).join('')}
        </div>
        <div class="info">
          <p>Height: ${data.height / 10} m</p>
          <p>Weight: ${data.weight / 10} kg</p>
          <p>Base XP: ${data.base_experience}</p>
        </div>
        <div class="abilities">
          <h3>Abilities</h3>
          ${data.abilities.map(a => `<span class="ability">${a.ability.name}</span>`).join('')}
        </div>
      </div>
      `;} catch {
    loading.textContent = '';
    error.textContent = ' Pokémon not found! Please try again.';
  }
}
