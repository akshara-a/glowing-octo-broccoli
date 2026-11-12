const input = document.getElementById("pokemonInput");
const searchBtn = document.getElementById("searchBtn");

const loading = document.getElementById("loading");
const error = document.getElementById("error");
const pokemonCard = document.getElementById("pokemonCard");

async function searchPokemon() {

    const pokemon = input.value.trim().toLowerCase();

    pokemonCard.innerHTML = "";
    error.textContent = "";

    if (pokemon === "") {
        error.textContent = "Please enter a Pokémon name or ID";
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
            .map(stat => `
                <li>
                    <strong>${stat.stat.name.toUpperCase()}</strong> :
                    ${stat.base_stat}
                </li>
            `)
            .join("");

        pokemonCard.innerHTML = `

        <div class="card">

            <img src="${data.sprites.front_default}" alt="${data.name}">

            <h2>${data.name.toUpperCase()}</h2>

            <div class="info">

                <p><strong>ID:</strong> ${data.id}</p>

                <p><strong>Height:</strong> ${data.height}</p>

                <p><strong>Weight:</strong> ${data.weight}</p>

                <p><strong>Type:</strong> ${types}</p>

                <p><strong>Abilities:</strong> ${abilities}</p>

                <div class="stats">

                    <h3>Stats</h3>

                    <ul>

                        ${stats}

                    </ul>

                </div>

            </div>

        </div>

        `;

    }

    catch(err){

        loading.textContent = "";

        error.textContent = "Pokémon not found.";

    }

}

searchBtn.addEventListener("click", searchPokemon);

input.addEventListener("keypress", function(event){

    if(event.key==="Enter"){

        searchPokemon();

    }

});