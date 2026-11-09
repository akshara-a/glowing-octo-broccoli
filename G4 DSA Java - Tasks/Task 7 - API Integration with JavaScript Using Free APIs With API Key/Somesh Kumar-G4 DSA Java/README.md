# Weather Dashboard

A simple weather dashboard built using HTML, CSS, and JavaScript.

## API Used

OpenWeatherMap Current Weather API.

## Features

- Search weather by city name
- Display city and country
- Display temperature
- Display weather condition
- Display weather description
- Display humidity
- Display wind speed
- Loading message
- Error handling
- Enter key search
- API key authentication

## Technologies Used

- HTML
- CSS
- JavaScript
- OpenWeatherMap API
- Fetch API

## API Response Fields Used

- `name` - City name
- `sys.country` - Country code
- `main.temp` - Current temperature
- `main.humidity` - Humidity
- `weather[0].main` - Weather condition
- `weather[0].description` - Weather description
- `wind.speed` - Wind speed

## Setup Instructions

1. Clone the repository.
2. Create a `config.js` file in the project root.
3. Add your OpenWeatherMap API key inside `config.js`.

```js
const API_KEY = "your_api_key_here";