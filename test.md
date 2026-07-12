Here's the same content as plain text, no markdown formatting:

Pokémon Search App
A small web page where you type a Pokémon name or ID and get back its picture, height, weight, type, abilities, and stats.
API Used
PokéAPI — a free, public API for Pokémon data. No API key needed.
Endpoint:
https://pokeapi.co/api/v2/pokemon/{name or id}/
Example:
https://pokeapi.co/api/v2/pokemon/pikachu
https://pokeapi.co/api/v2/pokemon/25
Fields Used From the Response
id — shown next to the name, like #25
name — page heading
height — displayed as-is
weight — displayed as-is
types — list of type(s), like electric
abilities — list of abilities
stats — HP, Attack, Defense, Speed, etc.
sprites.front_default — the Pokémon image
How It Works

User types something in the search box and hits Enter or clicks Search.
The app checks if the box is empty. If so, it shows a message asking for input.
If there's text, it builds the API URL using that text and calls fetch().
While waiting, it shows "Loading data..."
If the name or ID is valid, the response is unpacked and shown on the page.
If the name or ID doesn't exist, or the network fails, an error message is shown instead.

Test Cases

Leave the box empty and click Search — Message: "Please enter a Pokémon name or ID"
Type pikachu — Shows Pikachu's image, stats, type (electric), and abilities
Type 25 — Same result as above, ID and name both work
Type charizard — Shows Charizard's details, two types (fire, flying)
Type xyzabc — Message: "Pokémon not found"
Turn off internet and search — Message: "Something went wrong. Please try again."
Search once, then search again with a different name — Old result disappears, new result takes its place
Type name in capital letters, like PIKACHU — Still works, input is converted to lowercase before the request

Files in This Project
index.html — page layout
style.css — visual styling
script.js — search logic and API calls
Notes
No login or API key is required to use PokéAPI.
Works fully in the browser, no backend server needed.
Best tested using the VS Code Live Server extension so fetch() calls run properly.