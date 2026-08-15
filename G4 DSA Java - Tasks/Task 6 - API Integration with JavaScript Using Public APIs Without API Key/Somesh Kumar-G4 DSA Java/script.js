const pokemonInput = document.getElementById("pokemonInput");
const searchBtn = document.getElementById("searchBtn");
const loading = document.getElementById("loading");
const error = document.getElementById("error");
const pokemonResult = document.getElementById("pokemonResult");

async function searchPokemon() {
    const pokemonName = pokemonInput.value.trim().toLowerCase();

    // Clear previous result and error
    error.textContent = "";
    pokemonResult.innerHTML = "";
    pokemonResult.style.display = "none";

    // Validate empty input
    if (pokemonName === "") {
        error.textContent = "Please enter a Pokémon name or ID";
        return;
    }

    loading.style.display = "block";

    try {
        const response = await fetch(
            `https://pokeapi.co/api/v2/pokemon/${pokemonName}`
        );

        if (!response.ok) {
            throw new Error("Pokémon not found");
        }

        const data = await response.json();

        displayPokemon(data);

    } catch (err) {
        error.textContent = "Pokémon not found";
    } finally {
        loading.style.display = "none";
    }
}

function displayPokemon(pokemon) {
    const types = pokemon.types
        .map(type => `<span class="badge">${type.type.name}</span>`)
        .join("");

    const abilities = pokemon.abilities
        .map(ability => `<span class="badge">${ability.ability.name}</span>`)
        .join("");

    const stats = pokemon.stats
        .map(stat => `
            <div class="stat">
                <span>${stat.stat.name}</span>
                <strong>${stat.base_stat}</strong>
            </div>
        `)
        .join("");

    pokemonResult.innerHTML = `
        <img src="${pokemon.sprites.front_default}" alt="${pokemon.name}">

        <h2>${pokemon.name}</h2>

        <div class="pokemon-info">
            <div class="info-box">
                <strong>ID</strong>
                ${pokemon.id}
            </div>

            <div class="info-box">
                <strong>Height</strong>
                ${pokemon.height / 10} m
            </div>

            <div class="info-box">
                <strong>Weight</strong>
                ${pokemon.weight / 10} kg
            </div>
        </div>

        <div class="section">
            <h3>Types</h3>
            <div class="types">
                ${types}
            </div>
        </div>

        <div class="section">
            <h3>Abilities</h3>
            <div class="abilities">
                ${abilities}
            </div>
        </div>

        <div class="section">
            <h3>Stats</h3>
            <div class="stats">
                ${stats}
            </div>
        </div>
    `;

    pokemonResult.style.display = "block";
}

// Search button click
searchBtn.addEventListener("click", searchPokemon);

// Search using Enter key
pokemonInput.addEventListener("keydown", function (event) {
    if (event.key === "Enter") {
        searchPokemon();
    }
});