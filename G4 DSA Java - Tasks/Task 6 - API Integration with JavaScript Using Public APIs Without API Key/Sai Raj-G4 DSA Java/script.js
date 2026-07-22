const searchBtn = document.getElementById("searchBtn");
const pokemonInput = document.getElementById("pokemonInput");
const pokemonCard = document.getElementById("pokemonCard");
const error = document.getElementById("error");

searchBtn.addEventListener("click", searchPokemon);

pokemonInput.addEventListener("keypress", function (e) {
    if (e.key === "Enter") {
        searchPokemon();
    }
});

async function searchPokemon() {
    const pokemon = pokemonInput.value.trim().toLowerCase();

    pokemonCard.innerHTML = "";
    error.textContent = "";

    if (pokemon === "") {
        error.textContent = "Please enter a Pokémon name or ID.";
        return;
    }

    try {
        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokemon}`);

        if (!response.ok) {
            throw new Error("Pokémon not found");
        }

        const data = await response.json();

        const statNames = {
            hp: "HP",
            attack: "Attack",
            defense: "Defense",
            "special-attack": "Special Attack",
            "special-defense": "Special Defense",
            speed: "Speed"
        };

        let statsHTML = `
            <h3 class="stats-title">Stats</h3>
            <div class="stats">
        `;

        data.stats.forEach(stat => {
            statsHTML += `
                <div class="stat-row">
                    <span>${statNames[stat.stat.name]}</span>
                    <span>${stat.base_stat}</span>
                </div>
            `;
        });

        statsHTML += `</div>`;

        pokemonCard.innerHTML = `
            <img class="pokemon-img"
                 src="${data.sprites.front_default}"
                 alt="${data.name}">

            <div class="pokemon-details">
                <p><strong>Name :</strong> ${data.name.toUpperCase()}</p>
                <p><strong>ID :</strong> ${data.id}</p>
                <p><strong>Height :</strong> ${data.height}</p>
                <p><strong>Weight :</strong> ${data.weight}</p>
                <p><strong>Type :</strong> ${data.types.map(type => type.type.name).join(", ")}</p>
                <p><strong>Abilities :</strong> ${data.abilities.map(ability => ability.ability.name).join(", ")}</p>
            </div>

            ${statsHTML}
        `;

    } catch (err) {
        error.textContent = "Pokémon not found.";
        pokemonCard.innerHTML = "";
    }
}