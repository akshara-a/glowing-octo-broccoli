const searchInput = document.getElementById("searchInput");
const searchBtn = document.getElementById("searchBtn");
const statusMessage = document.getElementById("statusMessage");
const resultCard = document.getElementById("resultCard");

const pokemonImage = document.getElementById("pokemonImage");
const pokemonName = document.getElementById("pokemonName");
const pokemonIdEl = document.getElementById("pokemonId");
const pokemonHeight = document.getElementById("pokemonHeight");
const pokemonWeight = document.getElementById("pokemonWeight");
const pokemonTypes = document.getElementById("pokemonTypes");
const pokemonAbilities = document.getElementById("pokemonAbilities");
const pokemonStats = document.getElementById("pokemonStats");

searchBtn.addEventListener("click", searchPokemon);
searchInput.addEventListener("keydown", (e) => {
  if (e.key === "Enter") {
    searchPokemon();
  }
});

async function searchPokemon() {
  const query = searchInput.value.trim().toLowerCase();

  if (query === "") {
    showStatus("Please enter a Pokémon name or ID", true);
    resultCard.classList.add("hidden");
    return;
  }

  resultCard.classList.add("hidden");
  showStatus("Loading data...", false);

  try {
    const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${query}/`);

    if (!response.ok) {
      throw new Error("not-found");
    }

    const data = await response.json();
    displayPokemon(data);
    showStatus("", false);

  } catch (error) {
    resultCard.classList.add("hidden");
    if (error.message === "not-found") {
      showStatus("Pokémon not found", true);
    } else {
      showStatus("Something went wrong. Please try again.", true);
    }
  }
}

function displayPokemon(data) {
  pokemonImage.src = data.sprites.front_default;
  pokemonName.textContent = data.name;
  pokemonIdEl.textContent = `#${data.id}`;
  pokemonHeight.textContent = data.height;
  pokemonWeight.textContent = data.weight;

  const types = data.types.map(t => t.type.name).join(", ");
  pokemonTypes.textContent = types;

  const abilities = data.abilities.map(a => a.ability.name).join(", ");
  pokemonAbilities.textContent = abilities;

  pokemonStats.innerHTML = "";
  data.stats.forEach(stat => {
    const li = document.createElement("li");
    li.innerHTML = `<span>${stat.stat.name}</span><span>${stat.base_stat}</span>`;
    pokemonStats.appendChild(li);
  });

  resultCard.classList.remove("hidden");
}

function showStatus(message, isError) {
  statusMessage.textContent = message;
  statusMessage.classList.toggle("error", isError);
}