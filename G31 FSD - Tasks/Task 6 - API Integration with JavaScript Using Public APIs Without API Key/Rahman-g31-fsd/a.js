

async function fetchData() {

    try {

        const pokemonName = document
            .getElementById("pokemonName")
            .value
            .toLowerCase()
            .trim();

        const loading =
            document.getElementById("loading");

        const pokemonInfo =
            document.getElementById("pokemonInfo");

        const evolutionDiv =
            document.getElementById("evolution");

        if (pokemonName === "") {

            pokemonInfo.innerHTML =
                `<p class="error">
                Please enter a Pokémon name
                </p>`;

            return;
        }

        loading.textContent =
            "Loading Pokémon...";

        pokemonInfo.innerHTML = "";
        evolutionDiv.innerHTML = "";

        const response = await fetch(
            `https://pokeapi.co/api/v2/pokemon/${pokemonName}`
        );

        if (!response.ok) {
            throw new Error("Pokemon not found");
        }

        const data = await response.json();

        loading.textContent = "";

        const img =
            document.getElementById("pokemonSprite");

        const shiny =
document.getElementById("shinyToggle").checked;

img.src = shiny
? data.sprites.front_shiny
: data.sprites.other["official-artwork"].front_default

        img.style.display = "block";

        const types = data.types
            .map(type =>
                `<span class="type-badge">
                ${type.type.name}
                </span>`
            )
            .join("");

        const abilities = data.abilities
            .map(ability =>
                ability.ability.name
            )
            .join(", ");

        let statsHTML = "";

        data.stats.forEach(stat => {

            statsHTML += `

            <div class="stat">

                <p>
                ${stat.stat.name}
                : ${stat.base_stat}
                </p>

                <div class="progress">

                    <div
                    class="progress-bar"
                    style="
                    width:${stat.base_stat}%;
                    ">
                    </div>

                </div>

            </div>

            `;
        });

        pokemonInfo.innerHTML = `

        <h2>
        ${data.name.toUpperCase()}
        </h2>

        <p>
        <strong>ID:</strong>
        ${data.id}
        </p>

        <p>
        <strong>Height:</strong>
        ${data.height}
        </p>

        <p>
        <strong>Weight:</strong>
        ${data.weight}
        </p>

        <h3>Types</h3>

        ${types}

        <h3>Abilities</h3>

        <p>${abilities}</p>

        <h3>Stats</h3>

        ${statsHTML}

        `;

        const evolutions =
            await getEvolutionChain(
                data.species.url
            );

        let evolutionHTML =
            "<h3>Evolution Chain</h3>";

        evolutions.forEach(pokemon => {

            evolutionHTML += `

            <div class="evolution-card">

                <p>${pokemon}</p>

            </div>

            `;
        });

        evolutionDiv.innerHTML =
            evolutionHTML;

    }

    catch (error) {

        document.getElementById("loading")
            .textContent = "";

        document.getElementById("pokemonInfo")
            .innerHTML =

            `<p class="error">
            Pokémon Not Found
            </p>`;

        console.error(error);
    }
}
async function getEvolutionChain(speciesUrl) {

    const speciesResponse =
        await fetch(speciesUrl);

    const speciesData =
        await speciesResponse.json();

    const evolutionResponse =
        await fetch(
            speciesData.evolution_chain.url
        );

    const evolutionData =
        await evolutionResponse.json();

    let chain =
        evolutionData.chain;

    let evolutions = [];

    while (chain) {

        evolutions.push(
            chain.species.name
        );

        chain =
            chain.evolves_to[0];
    }

    return evolutions;
}

document
    .getElementById("pokemonName")
    .addEventListener(
        "keypress",
        function (event) {

            if (event.key === "Enter") {

                fetchData();

            }

        }
    );