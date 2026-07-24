const input = document.getElementById("pokemonInput");
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
const pokemonTypes = document.getElementById("pokemonTypes");
const pokemonAbilities = document.getElementById("pokemonAbilities");
const pokemonStats = document.getElementById("pokemonStats");

const typeColors = {

    normal: "#A8A77A",
    fire: "#EE8130",
    water: "#6390F0",
    electric: "#F7D02C",
    grass: "#7AC74C",
    ice: "#96D9D6",
    fighting: "#C22E28",
    poison: "#A33EA1",
    ground: "#E2BF65",
    flying: "#A98FF3",
    psychic: "#F95587",
    bug: "#A6B91A",
    rock: "#B6A136",
    ghost: "#735797",
    dragon: "#6F35FC",
    dark: "#705746",
    steel: "#B7B7CE",
    fairy: "#D685AD"

};

searchBtn.addEventListener("click", () => {

    searchPokemon(input.value.trim().toLowerCase());

});

input.addEventListener("keypress", (event) => {

    if (event.key === "Enter") {

        searchPokemon(input.value.trim().toLowerCase());

    }

});

randomBtn.addEventListener("click", () => {

    const randomId = Math.floor(Math.random() * 1025) + 1;

    searchPokemon(randomId);

});

async function searchPokemon(pokemon) {

    pokemonCard.classList.add("hidden");
    error.classList.add("hidden");

    if (pokemon === "") {

        error.classList.remove("hidden");

        error.innerHTML = `
            <h3>⚠ Please Enter Pokémon Name or ID</h3>
        `;

        return;

    }

    loading.classList.remove("hidden");

    try {

        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokemon}`);

        if (!response.ok) {

            throw new Error();

        }

        const data = await response.json();

        displayPokemon(data);

    }

    catch {

        loading.classList.add("hidden");

        pokemonCard.classList.add("hidden");

        error.classList.remove("hidden");

        error.innerHTML = `
            <h3>❌ Pokémon Not Found</h3>
            <p>Try another Pokémon Name or ID.</p>
        `;

    }

}

function displayPokemon(data) {

    loading.classList.add("hidden");

    pokemonCard.classList.remove("hidden");

    pokemonImage.src = data.sprites.other["official-artwork"].front_default;

    pokemonName.textContent = capitalize(data.name);

    pokemonId.textContent = data.id;

    pokemonHeight.textContent = data.height;

    pokemonWeight.textContent = data.weight;

    pokemonTypes.innerHTML = "";

    data.types.forEach(type => {

        const badge = document.createElement("span");

        badge.classList.add("type-badge");

        badge.textContent = capitalize(type.type.name);

        badge.style.backgroundColor = typeColors[type.type.name];

        pokemonTypes.appendChild(badge);

    });

    pokemonAbilities.innerHTML = "";

    data.abilities.forEach(ability => {

        const li = document.createElement("li");

        li.textContent = capitalize(ability.ability.name);

        pokemonAbilities.appendChild(li);

    });

    pokemonStats.innerHTML = "";

    data.stats.forEach(stat => {

        const statDiv = document.createElement("div");

        statDiv.classList.add("stat");

        statDiv.innerHTML = `

            <div class="stat-name">
                ${capitalize(stat.stat.name)} : ${stat.base_stat}
            </div>

            <div class="progress">

                <div class="progress-bar"
                    style="width:${stat.base_stat > 100 ? 100 : stat.base_stat}%;">
                </div>

            </div>

        `;

        pokemonStats.appendChild(statDiv);

    });

}

function capitalize(text) {

    return text.charAt(0).toUpperCase() + text.slice(1);

}