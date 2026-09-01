const searchInput = document.getElementById("searchInput");
const searchButton = document.getElementById("searchButton");
const loadingMessage = document.getElementById("loadingMessage");
const errorMessage = document.getElementById("errorMessage");
const pokemonCard = document.getElementById("pokemonCard");

searchButton.addEventListener("click", getPokemonDetails);

searchInput.addEventListener("keydown", (event) => {
    if (event.key === "Enter") {
        getPokemonDetails();
    }
});

async function getPokemonDetails() {

    const searchValue = searchInput.value.trim().toLowerCase();

    pokemonCard.innerHTML = "";
    errorMessage.textContent = "";
    loadingMessage.textContent = "";

    if (searchValue === "") {
        errorMessage.textContent = "Please enter a Pokémon name or ID.";
        return;
    }

    loadingMessage.textContent = "Fetching Pokémon details...";

    try {

        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${searchValue}`);

        if (!response.ok) {
            throw new Error("Pokémon not found.");
        }

        const pokemon = await response.json();

        loadingMessage.textContent = "";

        const typeList = pokemon.types
            .map(type => type.type.name)
            .join(", ");

        const abilityList = pokemon.abilities
            .map(ability => ability.ability.name)
            .join(", ");

        const statList = pokemon.stats
            .map(stat => `<li><strong>${stat.stat.name}</strong> : ${stat.base_stat}</li>`)
            .join("");

        pokemonCard.innerHTML = `
            <div class="card">
                <img src="${pokemon.sprites.front_default}" alt="${pokemon.name}">
                <h2>${pokemon.name.charAt(0).toUpperCase() + pokemon.name.slice(1)}</h2>

                <p><strong>Pokédex ID:</strong> ${pokemon.id}</p>
                <p><strong>Height:</strong> ${pokemon.height}</p>
                <p><strong>Weight:</strong> ${pokemon.weight}</p>
                <p><strong>Type:</strong> ${typeList}</p>
                <p><strong>Abilities:</strong> ${abilityList}</p>

                <h3>Base Stats</h3>
                <ul>
                    ${statList}
                </ul>
            </div>
        `;

    } catch (error) {

        loadingMessage.textContent = "";
        pokemonCard.innerHTML = "";
        errorMessage.textContent = error.message;

    }

}