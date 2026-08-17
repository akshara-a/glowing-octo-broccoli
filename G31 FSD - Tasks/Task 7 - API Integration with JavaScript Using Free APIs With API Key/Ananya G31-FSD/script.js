import {API_KEY} from "./config.js";


const image = document.getElementById("apodImage");
const video = document.getElementById("apodVideo");

const title = document.getElementById("title");
const date = document.getElementById("date");

const displayDate = document.getElementById("displayDate");
const explanation = document.getElementById("explanation");

const copyright = document.getElementById("copyright");

const loading = document.getElementById("loading");
const error = document.getElementById("error");

const dateInput = document.getElementById("dateInput");
const searchBtn = document.getElementById("searchBtn");

const hdImageBtn = document.getElementById("hdImageBtn");


// Today's Date


const today = new Date().toISOString().split("T")[0];
dateInput.max = today;


// Show Loading


function showLoading() {

    loading.style.display = "block";

}


// Hide Loading


function hideLoading() {

    loading.style.display = "none";

}


// Show Error

function showError(message) {

    error.style.display = "block";
    error.textContent = message;

}


// Hide Error


function hideError() {

    error.style.display = "none";
    error.textContent = "";

}


// Fetch APOD

async function fetchAPOD(selectedDate = "") {

    showLoading();
    hideError();

    image.style.display = "none";
    video.style.display = "none";

    let url = `https://api.nasa.gov/planetary/apod?api_key=${API_KEY}`;

    if (selectedDate) {

        url += `&date=${selectedDate}`;

    }

    try {

        const response = await fetch(url);

        if (!response.ok) {

            throw new Error();

        }

        const data = await response.json();

        displayData(data);

    }

    catch {

        showError("Unable to fetch NASA data.");

    }

    finally {

        hideLoading();

    }

}


// Display Data


function displayData(data) {

    title.textContent = data.title;

    date.textContent = data.date;

    /*displayDate.textContent = data.date;*/

    explanation.textContent = data.explanation;

    copyright.textContent =
        data.copyright || "NASA";



    if (data.media_type === "image") {

        image.src = data.url;

        image.style.display = "block";

        video.style.display = "none";

    }

    else {

        video.src = data.url;

        video.style.display = "block";

        image.style.display = "none";

    }



    if (data.hdurl) {

        hdImageBtn.href = data.hdurl;

        hdImageBtn.style.display = "inline-block";

    }

    else {

        hdImageBtn.style.display = "none";

    }

}


// Search Button


searchBtn.addEventListener("click", () => {

    const selectedDate = dateInput.value;

    if (!selectedDate) {

        showError("Please select a date.");

        return;

    }

    if (selectedDate > today) {

        showError("Please select today or a past date.");

        return;

    }

    fetchAPOD(selectedDate);

});

// Load Today's APOD


fetchAPOD();