# Weather App – API Integration

This project integrates the OpenWeatherMap API to fetch and display weather details for any entered city.

---

## Before City Name Search

![Before Search](<before.png>)

---

## After City Name Search

![After Search](<after.png>)

---

## Features

- Search weather by city name  
- Shows:
  - Temperature  
  - Feels Like  
  - Humidity  
  - Weather Description  
- Handles invalid city errors  
- Clean and simple UI  

---

## API Key Handling

- API key is stored in `config.js`
- `config.js` is added to `.gitignore`
- Key is not pushed to GitHub

---

## Project Files

- `index.html`  
- `style.css`  
- `script.js`  
- *(local only)* `config.js`

---

## How to Run

1. Create `config.js` locally:
   ```js
   const config = {
       OPEN_WEATHER_KEY: "YOUR_API_KEY_HERE"
   };