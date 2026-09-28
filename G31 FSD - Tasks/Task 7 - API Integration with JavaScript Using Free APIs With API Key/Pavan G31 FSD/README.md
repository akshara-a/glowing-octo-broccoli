# Weather Dashboard

## Project Overview

The Weather Dashboard is a simple frontend web application built using HTML, CSS, and JavaScript. It allows users to search for any city and view its current weather information by fetching live data from the OpenWeatherMap API.

---

## Features

* Search weather by city name
* Display city and country
* Display temperature
* Display weather condition
* Display weather description
* Display humidity
* Display wind speed
* Input validation
* Loading message while fetching data
* Error handling for invalid city, invalid API key, and network issues
* Search using both the Search button and the Enter key
* Responsive user interface

---

## Technologies Used

* HTML5
* CSS3
* JavaScript (ES6)
* OpenWeatherMap API
* Fetch API

---

## API Used

**API Name:** OpenWeatherMap Current Weather API

**Endpoint:**

https://api.openweathermap.org/data/2.5/weather?q={CITY_NAME}&appid={API_KEY}&units=metric

---

## API Response Fields Used

| API Field              | Description         |
| ---------------------- | ------------------- |
| name                   | City name           |
| sys.country            | Country code        |
| main.temp              | Current temperature |
| weather[0].main        | Weather condition   |
| weather[0].description | Weather description |
| main.humidity          | Humidity percentage |
| wind.speed             | Wind speed          |

---

## Project Structure

Weather-Dashboard/

├── index.html

├── style.css

├── script.js

├── config.example.js

├── .gitignore

└── README.md

Local File (Not Uploaded)

config.js

---

## Setup Instructions

1. Clone the repository.
2. Create a file named `config.js` in the project folder.
3. Add your OpenWeatherMap API key.

```javascript
const API_KEY = "YOUR_API_KEY";
```

4. Save the file.
5. Open `index.html` in your browser.
6. Search for any city.

---

## Validation Implemented

* Empty input validation
* Numbers-only validation
* Minimum character validation
* Special character validation
* Invalid city handling
* Invalid API key handling
* Network error handling

---

## Output

The application displays:

* City Name
* Country
* Temperature
* Weather Condition
* Weather Description
* Humidity
* Wind Speed

---

## Future Improvements

* Weather icons
* Five-day weather forecast
* Geolocation support
* Dark mode
* Dynamic background based on weather

---

Developed as part of the JavaScript API Integration assignment using the OpenWeatherMap API.

## Short Description


### OpenWeatherMap Current Weather API

The Weather Dashboard uses the OpenWeatherMap Current Weather API to fetch real-time weather information for a user-specified city. The API requires an API key for authentication and returns weather data in JSON format. The application uses JavaScript's Fetch API to send requests and dynamically display the weather information on the webpage.


### API Response Fields Used

* **name** – Displays the city name.
* **sys.country** – Displays the country code.
* **main.temp** – Displays the current temperature in Celsius.
* **weather[0].main** – Displays the main weather condition (e.g., Clouds, Rain, Clear).
* **weather[0].description** – Displays a detailed description of the weather.
* **main.humidity** – Displays the humidity percentage.
* **wind.speed** – Displays the current wind speed in meters per second (m/s).
