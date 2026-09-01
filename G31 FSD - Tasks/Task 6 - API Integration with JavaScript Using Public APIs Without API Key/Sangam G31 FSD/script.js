// Step 1: Grab the DOM elements – so you don't have to keep writing `getElementById` repeatedly.
const searchInput = document.getElementById("search-input");
const searchButton = document.getElementById("search-button");
const loadingDiv = document.getElementById("loading");
const errorDiv = document.getElementById("error");
const resultDiv = document.getElementById("result");

// Step B: Helper to hide all three states – so you don't have to write three lines repeatedly.
function hideAll() {
    loadingDiv.style.display = "none";
    errorDiv.style.display = "none";
    resultDiv.style.display = "none";
}

// Step C:trigger on button click
searchButton.addEventListener("click", searchPokemon);

// Bonus: Search can also be triggered using the Enter key.
searchInput.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
        searchPokemon();
    }
});

async function searchPokemon() {
  // 1. Get and clean the input value
    const query = searchInput.value.trim().toLowerCase();

    // 2. Validation - Check for empty first; do nothing further.
    if (query === "") {
        hideAll();
        errorDiv.textContent = "Please enter a Pokémon name or ID";
        errorDiv.style.display = "block";
        return; // yahin ruk jao, fetch tak mat jao
    }

    // 3. Clear the previous state, show the loading screen.
    hideAll();
    loadingDiv.style.display = "block";

    // 4. Now, place the API call inside a try-catch block, as it might fail.
    try {
        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${query}/`);

        // Fetch doesn't automatically log a 404 error, so you have to check manually.
        if (!response.ok) {
            throw new Error("Pokemon not found");
        }

        const data = await response.json();

        // 5. Data received – now display it.
        displayPokemon(data);

    } catch (err) {
        hideAll();
        errorDiv.textContent = "Pokémon not found";
        errorDiv.style.display = "block";
    }
}

function displayPokemon(data) {
    //abilities, types are arrays - created list from map()
    const abilities = data.abilities.map(a => a.ability.name).join(", ");
    const types = data.types.map(t => t.type.name).join(", ");

    // 'stats' is an array of objects – a list was created using map().
    const statsList = data.stats
        .map(s => `<li>${s.stat.name}: ${s.base_stat}</li>`)
        .join("");

    resultDiv.innerHTML = `
        <img src="${data.sprites.front_default}" alt="${data.name}">
        <h2>${data.name} (#${data.id})</h2>
        <p><strong>Height:</strong> ${data.height}</p>
        <p><strong>Weight:</strong> ${data.weight}</p>
        <p><strong>Types:</strong> ${types}</p>
        <p><strong>Abilities:</strong> ${abilities}</p>
        <p><strong>Stats:</strong></p>
        <ul>${statsList}</ul>
    `;

    hideAll();
    resultDiv.style.display = "block";
}