// DOM Element Selectors
const searchInput = document.getElementById('search-input');
const searchBtn = document.getElementById('search-btn');
const loadingState = document.getElementById('loading-state');
const errorState = document.getElementById('error-state');
const pokemonCard = document.getElementById('pokemon-card');

// Event Listeners
searchBtn.addEventListener('click', handleSearch);
searchInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') handleSearch();
});

// Main Search Logic
async function handleSearch() {
    const query = searchInput.value.trim().toLowerCase();

    // 1. Validation: Empty Input
    if (!query) {
        showError('Please enter a Pokémon name or ID');
        clearCard();
        return;
    }

    // Prepare UI states
    resetUIStates();
    loadingState.classList.remove('hidden');

    try {
        // 2. Fetch Data from PokéAPI
        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${query}`);
        
        // 3. Validation: Handle 404 / Bad status
        if (!response.ok) {
            if (response.status === 404) {
                throw new Error('Pokémon not found');
            } else {
                throw new Error('Something went wrong. Please try again.');
            }
        }

        const data = await response.json();
        
        // 4. Render Dynamic Content
        renderPokemonCard(data);

    } catch (error) {
        // 5. Error Handling
        showError(error.message || 'Unable to fetch data');
        clearCard();
    } finally {
        // Turn off loading state regardless of success or failure
        loadingState.classList.add('hidden');
    }
}

// Render dynamic HTML content using data mapping
function renderPokemonCard(pokemon) {
    // Process sub-arrays (Types and Stats)
    const typesHTML = pokemon.types
        .map(t => `<span class="badge type-${t.type.name}">${t.type.name}</span>`)
        .join('');

    const statsHTML = pokemon.stats
        .map(s => `<li><strong>${s.stat.name.toUpperCase()}:</strong> <span>${s.base_stat}</span></li>`)
        .join('');

    const abilities = pokemon.abilities.map(a => a.ability.name).join(', ');

    // Inject dynamic HTML layout
    pokemonCard.innerHTML = `
        <img class="pokemon-img" src="${pokemon.sprites.front_default}" alt="${pokemon.name}">
        <h2 class="poke-name">${pokemon.name}</h2>
        <p class="poke-id">National ID: #${pokemon.id}</p>
        
        <div class="badge-container">
            ${typesHTML}
        </div>

        <div class="physics-info">
            <div><strong>Height:</strong> ${pokemon.height}</div>
            <div><strong>Weight:</strong> ${pokemon.weight}</div>
        </div>

        <p style="margin-bottom: 16px; font-size: 0.9rem;">
            <strong>Abilities:</strong> ${abilities}
        </p>

        <div class="stats-section">
            <h3>Base Stats</h3>
            <ul class="stats-list">
                ${statsHTML}
            </ul>
        </div>
    `;

    pokemonCard.classList.remove('hidden');
}

// Helper UI Functions
function showError(msg) {
    errorState.textContent = msg;
    errorState.classList.remove('hidden');
}

function resetUIStates() {
    errorState.classList.add('hidden');
    pokemonCard.classList.add('hidden');
}

function clearCard() {
    pokemonCard.innerHTML = '';
}
