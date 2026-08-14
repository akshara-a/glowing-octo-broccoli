
async function fetchData(){
  const city = document.getElementById("city").value; 
  const resultTag = document.getElementById("result"); 

  if(city === ""){
    resultTag.innerText = "Please enter a city name !";
    return; 
  }

  // console.log(`City : ${city}`); 

  try{
    const responseObj = await fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`); 

    if(!responseObj.ok){
      throw new Error("Weather Details Not found");
    }

    const data = await responseObj.json(); 
  


    let weatherListDetails = ``; 
    for(let i=0 ; i<data.weather.length ; i++){
    
       weatherListDetails += `${data.weather[i].main} - ${data.weather[i].description} <br>`;

    }

    const resultDetails = `
    <p class="border border-secondary-subtle border-2 shadow p-4 ">City             : ${data.name}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Country          : ${data.sys.country}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Temperature      : ${data.main.temp}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Humidity         : ${data.main.humidity}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Wind Speed       : ${data.wind.speed}</p>
    <p class="border border-secondary-subtle border-2 shadow p-4 ">Weather Details  : ${weatherListDetails}</p>
    `;


    console.log(data); 
    console.log(`City : ${data.name}`);
    console.log(`Country : ${data.sys.country}`);
    console.log(`Temperature : ${data.main.temp} °C`);
    console.log(`Humidity : ${data.main.humidity} %`);
    console.log(`Wind Speed : ${data.wind.speed} m/s`);
    console.log(`Weather Details : ${weatherListDetails}`); 

    resultTag.innerHTML = resultDetails; 
    
  }

  catch(error){

    resultTag.innerText = `${error.message}`;
  }
  


  


}