const input = document.getElementById("pokemonInput");
const button = document.getElementById("searchBtn");
const loading = document.getElementById("loading");
const error = document.getElementById("error");
const result = document.getElementById("result");

button.addEventListener("click", searchPokemon);

input.addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
        searchPokemon();
    }
});

async function searchPokemon() {

    const pokemon = input.value.trim().toLowerCase();

    result.innerHTML = "";
    error.textContent = "";

    if (pokemon === "") {
        error.textContent = "Please enter a Pokemon name or ID";
        return;
    }

    loading.textContent = "Loading...";

    try {

        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokemon}`);

        if (!response.ok) {
            throw new Error("Pokemon not found");
        }

        const data = await response.json();

        loading.textContent = "";

        const abilities = data.abilities
            .map(item => item.ability.name)
            .join(", ");

        const types = data.types
            .map(item => item.type.name)
            .join(", ");

        const stats = data.stats
            .map(item => `<li>${item.stat.name}: ${item.base_stat}</li>`)
            .join("");

        result.innerHTML = `
            <img src="${data.sprites.front_default}" alt="${data.name}">

            <h2>${data.name.toUpperCase()}</h2>

            <p><strong>ID:</strong> ${data.id}</p>

            <p><strong>Height:</strong> ${data.height}</p>

            <p><strong>Weight:</strong> ${data.weight}</p>

            <p><strong>Types:</strong> ${types}</p>

            <p><strong>Abilities:</strong> ${abilities}</p>

            <h3>Stats</h3>

            <ul>${stats}</ul>
        `;

    }
    catch(err){

        loading.textContent = "";
        error.textContent = err.message;

    }

}