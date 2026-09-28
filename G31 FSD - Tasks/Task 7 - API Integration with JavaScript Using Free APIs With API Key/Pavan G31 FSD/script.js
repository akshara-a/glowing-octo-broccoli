// ============================
// Select HTML Elements
// ============================

const cityInput = document.getElementById("cityInput");
const searchBtn = document.getElementById("searchBtn");

const loading = document.getElementById("loading");
const errorMessage = document.getElementById("errorMessage");

const weatherCard = document.getElementById("weatherCard");

const cityName = document.getElementById("cityName");
const country = document.getElementById("country");
const temperature = document.getElementById("temperature");
const condition = document.getElementById("condition");
const description = document.getElementById("description");
const humidity = document.getElementById("humidity");
const windSpeed = document.getElementById("windSpeed");

// ============================
// Search Button
// ============================

searchBtn.addEventListener("click", searchWeather);

// ============================
// Enter Key
// ============================

cityInput.addEventListener("keypress", function(event){

    if(event.key === "Enter"){

        searchWeather();

    }

});

// ============================
// Search Weather
// ============================

async function searchWeather(){

    const city = cityInput.value.trim();

    // Empty Validation
    if(city === ""){

        showError("Please enter a city name.");
        weatherCard.classList.add("hidden");
        return;

    }

    // Numbers Only Validation
    if(!isNaN(city)){

        showError("Please enter a valid city name.");
        weatherCard.classList.add("hidden");
        return;

    }

    // Minimum Length Validation
    if(city.length < 3){

        showError("City name should contain at least 3 characters.");
        weatherCard.classList.add("hidden");
        return;

    }

    // Letters and Spaces Only
    const cityPattern = /^[A-Za-z\s]+$/;

    if(!cityPattern.test(city)){

        showError("City name should contain only letters.");
        weatherCard.classList.add("hidden");
        return;

    }

    hideError();

    showLoading();

    weatherCard.classList.add("hidden");

    try{

        const response = await fetch(
            `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`
        );

        const data = await response.json();

        // ============================
        // Error Handling
        // ============================

        if(!response.ok){

            if(response.status === 404){

                showError("City not found.");

            }

            else if(response.status === 401){

                showError("Invalid API Key.");

            }

            else{

                showError(data.message || "Something went wrong.");

            }

            hideLoading();

            return;

        }

        // ============================
        // Display Weather
        // ============================

        displayWeather(data);

    }

    catch(error){

        showError("Unable to fetch weather data.");

    }

    finally{

        hideLoading();

    }

}

// ============================
// Display Weather
// ============================

function displayWeather(data){

    cityName.textContent = data.name;
    country.textContent = data.sys.country;

    temperature.textContent = data.main.temp + " °C";

    condition.textContent = data.weather[0].main;

    description.textContent = data.weather[0].description;

    humidity.textContent = data.main.humidity + " %";

    windSpeed.textContent = data.wind.speed + " m/s";

    weatherCard.classList.remove("hidden");

}

// ============================
// Loading
// ============================

function showLoading(){

    loading.textContent = "Loading weather data...";
    loading.classList.remove("hidden");

}

function hideLoading(){

    loading.classList.add("hidden");

}

// ============================
// Error
// ============================

function showError(message){

    errorMessage.textContent = message;

    errorMessage.classList.remove("hidden");

    weatherCard.classList.add("hidden");

}

function hideError(){

    errorMessage.textContent = "";

    errorMessage.classList.add("hidden");

}