const pokemonInput = document.getElementById("pokemonInput");
const searchBtn = document.getElementById("searchBtn");
const pokemonContainer = document.getElementById("pokemonContainer");
const loading = document.getElementById("loading");
const errorMessage = document.getElementById("errorMessage");

searchBtn.addEventListener("click", searchPokemon);

pokemonInput.addEventListener("keypress", function (event) {
    if (event.key === "Enter") {
        searchPokemon();
    }
});

async function searchPokemon() {

    const input = pokemonInput.value.trim().toLowerCase();

    // Clear previous result
    pokemonContainer.innerHTML = "";
    errorMessage.textContent = "";

    // Validate empty input
    if (input === "") {
        errorMessage.textContent =
            "Please enter a Pokémon name or ID";
        return;
    }

    loading.style.display = "block";

    try {

        const response = await fetch(
            `https://pokeapi.co/api/v2/pokemon/${input}`
        );

        if (!response.ok) {
            throw new Error("Pokemon not found");
        }

        const pokemon = await response.json();

        displayPokemon(pokemon);

    } catch (error) {

        errorMessage.textContent =
            "Pokémon not found";

    } finally {

        loading.style.display = "none";
    }
}

function displayPokemon(pokemon) {

    const name = pokemon.name;
    const id = pokemon.id;

    const height = pokemon.height;
    const weight = pokemon.weight;

    const image = pokemon.sprites.front_default;

    // Get types
    const types = pokemon.types
        .map(type => type.type.name)
        .join(", ");

    // Get abilities
    const abilities = pokemon.abilities
        .map(ability => ability.ability.name)
        .join(", ");

    // Get stats
    const statsHTML = pokemon.stats
        .map(stat => {

            const statName = stat.stat.name;
            const statValue = stat.base_stat;

            return `
                <div class="stat">

                    <span class="stat-name">
                        ${statName}
                    </span>

                    <span class="progress-container">
                        <span
                            class="progress"
                            style="width: ${Math.min(statValue, 100)}%"
                        ></span>
                    </span>

                    <span>${statValue}</span>

                </div>
            `;
        })
        .join("");

    pokemonContainer.innerHTML = `

        <div class="pokemon-card">

            <img
                src="${image}"
                alt="${name}"
                class="pokemon-image"
            >

            <h2 class="pokemon-name">
                ${name}
            </h2>

            <div class="basic-info">

                <div class="info-box">
                    <strong>ID</strong>
                    #${id}
                </div>

                <div class="info-box">
                    <strong>Height</strong>
                    ${height}
                </div>

                <div class="info-box">
                    <strong>Weight</strong>
                    ${weight}
                </div>

            </div>

            <h3 class="section-title">
                Types
            </h3>

            <div class="types">

                ${pokemon.types
                    .map(type => `
                        <span class="badge">
                            ${type.type.name}
                        </span>
                    `)
                    .join("")}

            </div>

            <h3 class="section-title">
                Abilities
            </h3>

            <div class="abilities">

                ${pokemon.abilities
                    .map(ability => `
                        <span class="badge">
                            ${ability.ability.name}
                        </span>
                    `)
                    .join("")}

            </div>

            <h3 class="section-title">
                Stats
            </h3>

            <div class="stats">

                ${statsHTML}

            </div>

        </div>
    `;
}