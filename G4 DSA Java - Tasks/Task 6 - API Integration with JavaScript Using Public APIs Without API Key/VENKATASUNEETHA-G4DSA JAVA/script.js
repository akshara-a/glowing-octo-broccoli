const input = document.getElementById("pokemonInput");
const button = document.getElementById("searchBtn");

const result = document.getElementById("result");
const loading = document.getElementById("loading");
const error = document.getElementById("error");

button.addEventListener("click", searchPokemon);

input.addEventListener("keypress", function (event) {
    if (event.key === "Enter") {
        searchPokemon();
    }
});

async function searchPokemon() {

    let pokemon = input.value.trim().toLowerCase();

    result.innerHTML = "";
    error.innerHTML = "";

    if (pokemon === "") {
        error.innerHTML = "Please enter a Pokemon name or ID";
        return;
    }

    loading.innerHTML = "Loading...";

    try {

        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokemon}`);

        if (!response.ok) {
            throw new Error("Pokemon not found");
        }

        const data = await response.json();

        loading.innerHTML = "";

        displayPokemon(data);

        // Clear the input after successful search
        input.value = "";

    } catch (err) {

        loading.innerHTML = "";
        error.innerHTML = "Pokemon not found";

        // Clear the input after failed search
        input.value = "";
    }
}

function displayPokemon(data) {

    let abilities = data.abilities
        .map(item => item.ability.name)
        .join(", ");

    let types = data.types
        .map(item => item.type.name)
        .join(", ");

    let stats = "";

    data.stats.forEach(stat => {

        stats += `
            <li><strong>${stat.stat.name}</strong> : ${stat.base_stat}</li>
        `;

    });

    result.innerHTML = `

        <img src="${data.sprites.front_default}" alt="${data.name}">

        <h2>${data.name.toUpperCase()}</h2>

        <p><strong>ID:</strong> ${data.id}</p>

        <p><strong>Height:</strong> ${data.height}</p>

        <p><strong>Weight:</strong> ${data.weight}</p>

        <p><strong>Type:</strong> ${types}</p>

        <p><strong>Abilities:</strong> ${abilities}</p>

        <h3>Stats</h3>

        <ul>${stats}</ul>

    `;
}