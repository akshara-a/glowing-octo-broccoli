const cityInput = document.getElementById("cityInput");
const searchButton = document.getElementById("searchButton");

const loading = document.getElementById("loading");
const errorMessage = document.getElementById("errorMessage");
const weatherContainer = document.getElementById("weatherContainer");


searchButton.addEventListener("click", getWeather);


cityInput.addEventListener("keypress", function(event) {

    if (event.key === "Enter") {
        getWeather();
    }

});


async function getWeather() {

    const city = cityInput.value.trim();

    // Clear previous result
    weatherContainer.innerHTML = "";
    errorMessage.textContent = "";

    // Validate input
    if (city === "") {

        errorMessage.textContent =
            "Please enter a city name";

        return;
    }


    loading.style.display = "block";


    try {

        const url =
            `https://api.openweathermap.org/data/2.5/weather?q=${encodeURIComponent(city)}&appid=${API_KEY}&units=metric`;


        const response = await fetch(url);


        if (response.status === 401) {

            throw new Error("INVALID_API_KEY");

        }


        if (response.status === 404) {

            throw new Error("CITY_NOT_FOUND");

        }


        if (!response.ok) {

            throw new Error("REQUEST_FAILED");

        }


        const data = await response.json();


        displayWeather(data);


    }

    catch (error) {

        if (error.message === "INVALID_API_KEY") {

            errorMessage.textContent =
                "Invalid API key or request failed";

        }

        else if (error.message === "CITY_NOT_FOUND") {

            errorMessage.textContent =
                "City not found";

        }

        else {

            errorMessage.textContent =
                "Unable to fetch weather data";

        }

    }

    finally {

        loading.style.display = "none";

    }

}


function displayWeather(data) {

    const cityName = data.name;

    const country = data.sys.country;

    const temperature =
        Math.round(data.main.temp);

    const humidity =
        data.main.humidity;

    const condition =
        data.weather[0].main;

    const description =
        data.weather[0].description;

    const windSpeed =
        data.wind.speed;


    const icon =
        data.weather[0].icon;


    weatherContainer.innerHTML = `

        <div class="weather-card">

            <h2 class="city-name">
                ${cityName}, ${country}
            </h2>

            <img
                class="weather-icon"
                src="https://openweathermap.org/img/wn/${icon}@2x.png"
                alt="${description}"
            >

            <div class="temperature">
                ${temperature}°C
            </div>

            <div class="condition">
                ${condition}
            </div>

            <div class="description">
                ${description}
            </div>


            <div class="weather-details">

                <div class="detail">

                    <strong>Humidity</strong>

                    <span>
                        ${humidity}%
                    </span>

                </div>


                <div class="detail">

                    <strong>Wind Speed</strong>

                    <span>
                        ${windSpeed} m/s
                    </span>

                </div>

            </div>

        </div>

    `;
}