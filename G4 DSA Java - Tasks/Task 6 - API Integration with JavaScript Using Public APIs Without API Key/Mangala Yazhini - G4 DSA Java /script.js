async function gatherDetails(name){


  const resultElement = document.getElementById("result"); 

  if(name === ""){
    resultElement.innerText = "Please enter a pokenam name";
    return; 
  }


  const pokemanImageTag = document.createElement("img"); 
  const pokemanDetailsTag = document.createElement("div"); 

  
  let apiEndPoint = "https://pokeapi.co/api/v2/pokemon/"; 
  apiEndPoint += name; 

  try{
    const responseObj = await fetch(apiEndPoint);
    
    if(!responseObj.ok){
      // resultElement.innerText = "Pokemon not found";
      throw new Error("Pokemon not found");
    }
    const data = await responseObj.json(); 
    console.log(data.sprites.front_default);
    pokemanImageTag.src = data.sprites.front_default; 

    // Pokeman Abilities
    let pokemanAbilities = []; 
    for(let i=0 ; i < data.abilities.length ; i++){
      console.log(data.abilities[i].ability.name); 
      pokemanAbilities.push(data.abilities[i].ability.name); 
    }

      
    // Pokeman Stats
    let pokemanStatsList = []; 

    for(let i=0 ; i < data.stats.length ; i++){
      console.log(data.stats[i].stat.name); 
      pokemanStatsList.push({
        name : data.stats[i].stat.name, 
        value :  data.stats[i].base_stat
      }); 
    }


    // Pokeman Types 
    let pokemanTypes = [];
    for(let i=0 ; i < data.types.length ; i++){
      console.log(data.types[i].type.name); 
      pokemanTypes.push(data.types[i].type.name); 
    }


    let stats =``; 
    for(let i=0 ; i < pokemanStatsList.length ; i++){
      console.log(pokemanStatsList[i]);
      stats += `${pokemanStatsList[i].name} : ${pokemanStatsList[i].value} <br>`;  
    }

    // resultElement = ""; 

    pokemanDetailsTag.innerHTML = `
    
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Name                             : ${data.name}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">ID                               : ${data.id}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Height                           : ${data.height}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Weight                           : ${data.weight}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Type                             : ${pokemanTypes}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Abilities                        : ${pokemanAbilities}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4">Stats of the pokeman ${data.name} : <br> ${stats}</p> 
     `;
    resultElement.innerHTML = ""; 
    resultElement.appendChild(pokemanImageTag); 
    resultElement.appendChild(pokemanDetailsTag);

    

  }

  catch(error) {
    console.log(error)
    if(error.message === "Pokemon not found"){
      resultElement.innerText = "Pokemon not found"; 
    }
    else{
      resultElement.innerText = "Something went wrong. Please try again."; 
    }
  }

}
function fetchPokeman(){
  const name = document.getElementById("pokemon-name").value.toLowerCase(); 
  const resultElement = document.getElementById("result"); 
  resultElement.innerHTML= "Loading ... "; 

  setTimeout(function(){
    gatherDetails(name)
  },3000); 


}



