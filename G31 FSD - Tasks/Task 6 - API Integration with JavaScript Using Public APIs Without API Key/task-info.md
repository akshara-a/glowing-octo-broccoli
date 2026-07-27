# Task: API Integration with JavaScript Using Public APIs Without API Key

## Task Title

**Building Frontend Web Applications Using Public APIs and JavaScript**

---

## Objective

Students must build a simple web application using **HTML, CSS, and JavaScript** by integrating public APIs that do not require an API key.

The objective of this task is to help students understand:

* How APIs work
* How to use `fetch()` in JavaScript
* How to handle JSON responses
* How to display API data dynamically on a webpage
* How to handle user input
* How to manage loading and error states
* How to build small real-world frontend projects

---

## APIs to Use

Students can choose any one of the following options:

| Option   | Project             | API                    | Main Concept                          |
| -------- | ------------------- | ---------------------- | ------------------------------------- |
| Option 2 | Product Listing App | DummyJSON Products API | E-commerce product display            |
| Option 3 | Pokémon Search App  | PokéAPI Pokémon API    | Search and display Pokémon details    |
| Option 4 | Weather Dashboard   | Open-Meteo Weather API | Fetch and display weather information |

---

# Common Requirements for All Options

## Technologies Required

Students must use:

* HTML
* CSS
* JavaScript
* Public API
* `fetch()`
* DOM manipulation

---

## Common Features

Each project must include:

1. API integration using JavaScript `fetch()`
2. Display of API data on the webpage
3. At least one user interaction
4. Loading message while data is being fetched
5. Error message if the API request fails
6. Clean and readable UI
7. Proper code structure

---

## Suggested Folder Structure

```text
api-integration-project/
│
├── index.html
├── style.css
└── script.js
```

---

# Option 2: Product Listing App

## API Name

**DummyJSON Products API**

---

## API Endpoint

```text
https://dummyjson.com/products
```

---

## Task Description

Create a simple e-commerce product listing webpage using JavaScript.

The application should fetch product data from the API and display products in card format.

---

## Features to Implement

Students must implement the following features:

1. Fetch product data from the API.
2. Display product details in product cards.
3. Show product image, title, price, rating, category, and brand.
4. Add a search box to search products by name.
5. Add sorting by price.
6. Show a loading message while data is loading.
7. Show an error message if the API request fails.

---

## API Response Fields to Use

| Field         | Description         |
| ------------- | ------------------- |
| `title`       | Product name        |
| `description` | Product description |
| `price`       | Product price       |
| `rating`      | Product rating      |
| `brand`       | Product brand       |
| `category`    | Product category    |
| `thumbnail`   | Product image       |

---

## Expected Output

The webpage should display products like an online shopping page.

Each product card should show:

```text
Product Image
Product Title
Category
Brand
Price
Rating
Short Description
```

---

## User Interaction

Students must add at least one of the following:

* Search product by name
* Sort products by low to high price
* Sort products by high to low price
* Filter products by category

---

## Concepts Covered

| Concept          | Purpose                         |
| ---------------- | ------------------------------- |
| `fetch()`        | To call the API                 |
| `async/await`    | To handle asynchronous code     |
| `map()`          | To loop through product data    |
| `filter()`       | To search/filter products       |
| `sort()`         | To sort products by price       |
| DOM manipulation | To display products dynamically |

---

## Business Use Case

This project represents a basic e-commerce product page.

It helps students understand how real shopping websites load and display product data from APIs.

---

# Option 3: Pokémon Search App

## API Name

**PokéAPI Pokémon API**

---

## API Documentation Reference

```text
https://pokeapi.co/docs/v2#pokemon-section
```

---

## API Endpoint

```text
https://pokeapi.co/api/v2/pokemon/{id or name}/
```

---

## Example API URLs

```text
https://pokeapi.co/api/v2/pokemon/pikachu
https://pokeapi.co/api/v2/pokemon/25
https://pokeapi.co/api/v2/pokemon/charizard
```

---

## Task Description

Create a Pokémon search application using JavaScript.

The user should be able to enter a Pokémon name or ID and view details about that Pokémon.

---

## Features to Implement

Students must implement the following features:

1. Create a search input box.
2. Allow the user to search by Pokémon name or ID.
3. Fetch Pokémon data from PokéAPI.
4. Display Pokémon image.
5. Display Pokémon name, ID, height, weight, abilities, types, and stats.
6. Show a loading message while fetching data.
7. Show an error message if the Pokémon is not found.
8. Clear previous result before showing new result.

---

## API Response Fields to Use

| Field                   | Description          |
| ----------------------- | -------------------- |
| `id`                    | Pokémon ID           |
| `name`                  | Pokémon name         |
| `height`                | Pokémon height       |
| `weight`                | Pokémon weight       |
| `abilities`             | List of abilities    |
| `types`                 | Pokémon type details |
| `stats`                 | Base stat values     |
| `sprites.front_default` | Pokémon image        |

---

## Expected Output

The webpage should display Pokémon details like:

```text
Image: Pikachu
Name: Pikachu
ID: 25
Height: 4
Weight: 60
Type: Electric
Abilities: static, lightning-rod
Stats:
- HP
- Attack
- Defense
- Speed
```

---

## User Interaction

Students must include:

* Input box for Pokémon name or ID
* Search button
* Optional Enter key search
* Error message for invalid Pokémon name

---

## Concepts Covered

| Concept                         | Purpose                                |
| ------------------------------- | -------------------------------------- |
| API endpoint with dynamic value | To search by Pokémon name or ID        |
| `fetch()`                       | To get Pokémon data                    |
| `try...catch`                   | To handle API errors                   |
| DOM manipulation                | To display Pokémon details             |
| Array methods                   | To display abilities, types, and stats |
| Conditional rendering           | To show result or error message        |

---

## Validation Requirements

Students should handle these cases:

| Scenario             | Expected Behavior                              |
| -------------------- | ---------------------------------------------- |
| Empty input          | Show “Please enter a Pokémon name or ID”       |
| Valid Pokémon name   | Display Pokémon details                        |
| Valid Pokémon ID     | Display Pokémon details                        |
| Invalid Pokémon name | Show “Pokémon not found”                       |
| API/network error    | Show “Something went wrong. Please try again.” |

---

## Business / Learning Use Case

This project helps students understand search-based API integration.

It is useful for learning:

* Dynamic API URLs
* Search functionality
* JSON data extraction
* Displaying nested API data
* Handling incorrect user input

---

# Option 4: Weather Dashboard

## API Name

**Open-Meteo Weather API**

---

## API Endpoint

```text
https://api.open-meteo.com/v1/forecast?latitude=13.08&longitude=80.27&current=temperature_2m,wind_speed_10m
```

---

## Example API URL

```text
https://api.open-meteo.com/v1/forecast?latitude=13.08&longitude=80.27&current=temperature_2m,wind_speed_10m
```

---

## Task Description

Create a simple weather dashboard using JavaScript.

The application should fetch current weather details for a selected location using latitude and longitude.

---

## Features to Implement

Students must implement the following features:

1. Create input fields for latitude and longitude.
2. Fetch current weather data from Open-Meteo API.
3. Display temperature and wind speed.
4. Show location coordinates.
5. Add a button to fetch weather.
6. Show a loading message while data is loading.
7. Show an error message if API request fails.
8. Validate empty latitude and longitude fields.

---

## API Response Fields to Use

| Field                    | Description                    |
| ------------------------ | ------------------------------ |
| `latitude`               | Latitude of selected location  |
| `longitude`              | Longitude of selected location |
| `current.time`           | Current weather time           |
| `current.temperature_2m` | Current temperature            |
| `current.wind_speed_10m` | Current wind speed             |

---

## Expected Output

The webpage should display weather information like:

```text
Location:
Latitude: 13.08
Longitude: 80.27

Current Weather:
Temperature: 31°C
Wind Speed: 12 km/h
Time: 2026-07-03T10:00
```

---

## User Interaction

Students must include:

* Latitude input
* Longitude input
* Get Weather button
* Optional default city coordinates

---

## Suggested Default Coordinates

| City      | Latitude | Longitude |
| --------- | -------: | --------: |
| Chennai   |    13.08 |     80.27 |
| Bengaluru |    12.97 |     77.59 |
| Hyderabad |    17.38 |     78.48 |
| Mumbai    |    19.07 |     72.87 |
| Delhi     |    28.61 |     77.20 |

---

## Concepts Covered

| Concept             | Purpose                        |
| ------------------- | ------------------------------ |
| Query parameters    | To pass latitude and longitude |
| `fetch()`           | To call the weather API        |
| `async/await`       | To handle API response         |
| Form input handling | To read latitude and longitude |
| DOM manipulation    | To display weather data        |
| Error handling      | To handle failed API calls     |

---

## Validation Requirements

Students should handle these cases:

| Scenario             | Expected Behavior                   |
| -------------------- | ----------------------------------- |
| Empty latitude       | Show validation message             |
| Empty longitude      | Show validation message             |
| Invalid API response | Show error message                  |
| Successful API call  | Display weather details             |
| Network error        | Show “Unable to fetch weather data” |

---

## Business / Learning Use Case

This project helps students understand real-world API usage.

Weather dashboards are common in:

* Travel websites
* Mobile weather apps
* Smart city dashboards
* Agriculture dashboards
* Event planning applications

---

# Common Implementation Steps

## Step 1: Create HTML Structure

Create the basic webpage layout.

The page should include:

* Heading
* Input fields
* Button
* Result container
* Error message area
* Loading message area

---

## Step 2: Add CSS Styling

Style the webpage using CSS.

Students should focus on:

* Simple layout
* Proper spacing
* Card design
* Button styling
* Responsive design
* Clean font and colors

---

## Step 3: Write JavaScript Logic

Create a `script.js` file and write JavaScript code for:

* Selecting HTML elements
* Calling the API using `fetch()`
* Converting response to JSON
* Displaying data
* Handling errors
* Handling user input

---

## Step 4: Add Loading State

Before the API call starts, show:

```text
Loading data...
```

After the API response is received, hide the loading message.

---

## Step 5: Add Error Handling

Use `try...catch` to handle errors.

Example error messages:

```text
Unable to fetch data.
Please check your input.
Something went wrong. Try again.
```

---

## Step 6: Test the Application

Students must test:

* Correct input
* Empty input
* Wrong input
* Slow network
* API error case
* UI display

---

# Evaluation Criteria

| Criteria                        |   Marks |
| ------------------------------- | ------: |
| API integration using `fetch()` |      20 |
| Correct data display in UI      |      20 |
| User interaction                |      15 |
| Error handling                  |      15 |
| Loading state                   |      10 |
| Code readability                |      10 |
| UI design                       |      10 |
| **Total**                       | **100** |

---

# Final Deliverables

Students must submit:

1. `index.html`
2. `style.css`
3. `script.js`
4. Screenshot of final output
5. Short explanation of selected API
6. Explanation of API response fields used
7. Final demo or screen recording

---

# Recommended Project for Beginners

## Best Beginner Option

**Option 3: Pokémon Search App**

## Reason

The Pokémon Search App is beginner-friendly because:

* It uses only one main API endpoint.
* It supports simple search by name or ID.
* The response contains interesting visual data.
* Students can easily display images, names, types, and stats.
* It is fun and easy to test.

---

# Sample Final Task Statement

Build a frontend web application using HTML, CSS, and JavaScript that integrates with a public API without using an API key.

Choose one of the following:

1. Product Listing App using DummyJSON Products API
2. Pokémon Search App using PokéAPI
3. Weather Dashboard using Open-Meteo API

The application must fetch data using JavaScript `fetch()`, display the API response dynamically on the webpage, handle user input, and include loading and error handling.
