const pokemonInput = document.getElementById("pokemonInput");
const searchBtn = document.getElementById("searchBtn");

const randomBtn = document.getElementById("randomBtn");

const loading = document.getElementById("loading");
const error = document.getElementById("error");
const pokemonCard = document.getElementById("pokemonCard");

const pokemonImage = document.getElementById("pokemonImage");
const pokemonName = document.getElementById("pokemonName");
const pokemonId = document.getElementById("pokemonId");
const pokemonHeight = document.getElementById("pokemonHeight");
const pokemonWeight = document.getElementById("pokemonWeight");
const pokemonType = document.getElementById("pokemonType");
const pokemonAbilities = document.getElementById("pokemonAbilities");
const pokemonStats = document.getElementById("pokemonStats");

searchBtn.addEventListener("click", getPokemon);
randomBtn.addEventListener("click", getRandomPokemon);

async function getPokemon() {
    try {
        const pokemon = pokemonInput.value.trim().toLowerCase();

        if (pokemon === "") {
            alert("Please enter a Pokémon name or ID.");
            return;
        }

        loading.style.display = "block";
        error.style.display = "none";
        pokemonCard.style.display = "none";

        const url = `https://pokeapi.co/api/v2/pokemon/${pokemon}`;

        const response = await fetch(url);

        if (!response.ok) {
            throw new Error("Pokemon not found");
        }

        const data = await response.json();

        loading.style.display = "none";
        pokemonCard.style.display = "block";

        pokemonImage.src = data.sprites.front_default;
        pokemonName.textContent = data.name.charAt(0).toUpperCase() + data.name.slice(1);
        pokemonId.textContent = data.id;
        pokemonHeight.textContent = data.height;
        pokemonWeight.textContent = data.weight;

        pokemonType.innerHTML = "";

        data.types.forEach(type => {
        pokemonType.innerHTML += `
        <span class="type-badge ${type.type.name}">
            ${type.type.name}
        </span>
    `;
});

        pokemonAbilities.innerHTML = "";

data.abilities.forEach(ability => {
    pokemonAbilities.innerHTML += `
        <div>⚡ ${
            ability.ability.name.charAt(0).toUpperCase() +
            ability.ability.name.slice(1)
        }</div>
    `;
});

        pokemonStats.innerHTML = "";

        pokemonStats.innerHTML = "";

data.stats.forEach(stat => {
    pokemonStats.innerHTML += `
        <div class="stat">
            <div class="stat-info">
                <span>${stat.stat.name.toUpperCase()}</span>
                <span>${stat.base_stat}</span>
            </div>

            <div class="progress">
                <div class="progress-bar" style="width:${Math.min(stat.base_stat,100)}%;"></div>
            </div>
        </div>
    `;
});

    } catch (err) {
        loading.style.display = "none";
        pokemonCard.style.display = "none";
        error.style.display = "block";
    }
}

async function getRandomPokemon() {
    const randomId = Math.floor(Math.random() * 1025) + 1;
    pokemonInput.value = randomId;
    getPokemon();

}

pokemonInput.addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
        getPokemon();
    }
});