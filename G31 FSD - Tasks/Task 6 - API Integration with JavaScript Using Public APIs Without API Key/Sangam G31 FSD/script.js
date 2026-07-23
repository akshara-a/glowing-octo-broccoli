// Step A: DOM elements pakad lo - baar baar getElementById na likhna pade
const searchInput = document.getElementById("search-input");
const searchButton = document.getElementById("search-button");
const loadingDiv = document.getElementById("loading");
const errorDiv = document.getElementById("error");
const resultDiv = document.getElementById("result");

// Step B: teeno states ko chhupane ka helper - baar baar 3 line na likhni pade
function hideAll() {
    loadingDiv.style.display = "none";
    errorDiv.style.display = "none";
    resultDiv.style.display = "none";
}

// Step C: button click pe trigger
searchButton.addEventListener("click", searchPokemon);

// Bonus: Enter key se bhi search ho jaye
searchInput.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
        searchPokemon();
    }
});

async function searchPokemon() {
    // 1. Input value nikalo aur clean karo
    const query = searchInput.value.trim().toLowerCase();

    // 2. Validate - empty check pehle, aage kuch mat karo
    if (query === "") {
        hideAll();
        errorDiv.textContent = "Please enter a Pokémon name or ID";
        errorDiv.style.display = "block";
        return; // yahin ruk jao, fetch tak mat jao
    }

    // 3. Purana state clear karo, loading dikhao
    hideAll();
    loadingDiv.style.display = "block";

    // 4. Ab API call - try/catch ke andar kyunki fail ho sakta hai
    try {
        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${query}/`);

        // fetch khud fail nahi karta 404 pe - isliye manually check karna padta hai
        if (!response.ok) {
            throw new Error("Pokemon not found");
        }

        const data = await response.json();

        // 5. Data mil gaya - ab display karo
        displayPokemon(data);

    } catch (err) {
        hideAll();
        errorDiv.textContent = "Pokémon not found";
        errorDiv.style.display = "block";
    }
}

function displayPokemon(data) {
    // abilities, types arrays hain - map() se list banani padi
    const abilities = data.abilities.map(a => a.ability.name).join(", ");
    const types = data.types.map(t => t.type.name).join(", ");

    // stats ek array of objects hai - map() se li list banayi
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