const hdImage = document.getElementById("hdImage");
const copyright = document.getElementById("copyright");
const dateInput = document.getElementById("dateInput");
const searchBtn = document.getElementById("searchBtn");

const loading = document.getElementById("loading");
const error = document.getElementById("error");

const apodCard = document.getElementById("apodCard");

const title = document.getElementById("title");
const date = document.getElementById("date");
const explanation = document.getElementById("explanation");
const mediaContainer = document.getElementById("mediaContainer");

async function fetchAPOD(selectedDate = "") {

    loading.style.display = "block";
    error.style.display = "none";
    apodCard.style.display = "none";

    let url = `https://api.nasa.gov/planetary/apod?api_key=${API_KEY}`;

    if (selectedDate) {
        url += `&date=${selectedDate}`;
    }

    try {

        const response = await fetch(url);

        if (!response.ok) {
            throw new Error("API request failed");
        }

        const data = await response.json();

        title.textContent = data.title;
        date.textContent = data.date;
        copyright.textContent = data.copyright
    ? `© ${data.copyright}`
    : "© NASA";
        explanation.textContent = data.explanation;

        mediaContainer.innerHTML = "";

        if (data.media_type === "image") {

            mediaContainer.innerHTML = `
                <img src="${data.url}" alt="${data.title}">
            `;

        } else {

            mediaContainer.innerHTML = `
                <iframe
                    src="${data.url}"
                    frameborder="0"
                    allowfullscreen>
                </iframe>
            `;

        }

        loading.style.display = "none";
        apodCard.style.display = "block";

    } catch (err) {

        loading.style.display = "none";
        error.style.display = "block";
        error.textContent = "Unable to fetch NASA data.";

    }
    if(data.hdurl){

    hdImage.href = data.hdurl;
    hdImage.style.display = "block";

}else{

    hdImage.style.display = "none";

}

}

searchBtn.addEventListener("click", () => {

    const selectedDate = dateInput.value;

    if (selectedDate) {

        const today = new Date().toISOString().split("T")[0];

        if (selectedDate > today) {

            error.style.display = "block";
            error.textContent = "Please select today or a past date.";
            apodCard.style.display = "none";

            return;

        }

    }

    fetchAPOD(selectedDate);

});

fetchAPOD();