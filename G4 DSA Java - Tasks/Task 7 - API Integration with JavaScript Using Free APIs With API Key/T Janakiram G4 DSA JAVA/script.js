const datePicker = document.getElementById('date-picker');
const fetchBtn = document.getElementById('fetch-btn');
const loadingState = document.getElementById('loading-state');
const errorState = document.getElementById('error-state');
const apodCard = document.getElementById('apod-card');
const mediaViewport = document.getElementById('media-viewport');

fetchBtn.addEventListener('click', handleSearchRequest);

window.addEventListener('DOMContentLoaded', () => {
    const todayStr = new Date().toISOString().split('T')[0];
    datePicker.max = todayStr;
    getNasaApodData(todayStr); 
});

function handleSearchRequest() {
    const selectedDate = datePicker.value;
  
    if (!selectedDate) {
        renderErrorState('Please choose a valid timeline date to search.');
        hideDisplayCard();
        return;
    }

    const selectedTime = new Date(selectedDate).getTime();
    const todayTime = new Date(new Date().toISOString().split('T')[0]).getTime();
    if (selectedTime > todayTime) {
        renderErrorState('Please select today or a past date');
        hideDisplayCard();
        return;
    }

    getNasaApodData(selectedDate);
}

async function getNasaApodData(targetDate) {
    if (typeof API_KEY === 'undefined' || API_KEY === "your_api_key_here" || API_KEY === "PASTE_YOUR_API_KEY_HERE") {
        renderErrorState('Invalid API key or request failed. Please initialize your local config.js profile.');
        hideDisplayCard();
        return;
    }

    clearStatusFrames();
    hideDisplayCard();
    loadingState.classList.remove('hidden');

    try {
        const queryUrl = `https://api.nasa.gov/planetary/apod?api_key=${API_KEY}&date=${targetDate}`;
        const response = await fetch(queryUrl);

        // 4. Response Assessment Block
        if (!response.ok) {
            if (response.status === 403 || response.status === 401) {
                throw new Error('Invalid API key or request failed');
            } else {
                throw new Error('Unable to fetch NASA data');
            }
        }

        const data = await response.json();
        populateApodCard(data);

    } catch (error) {
        renderErrorState(error.message || 'Unable to complete network fetch.');
    } finally {
        loadingState.classList.add('hidden');
    }
}

// 5. DOM Injection and Conditional Element Rendering Engine
function populateApodCard(data) {
    document.getElementById('apod-title').textContent = data.title;
    document.getElementById('apod-date').textContent = data.date;
    document.getElementById('apod-explanation').textContent = data.explanation;

    // Handle copyright values cleanly
    const copyrightElement = document.getElementById('apod-copyright');
    if (data.copyright) {
        copyrightElement.textContent = `© Copyright: ${data.copyright}`;
        copyrightElement.classList.remove('hidden');
    } else {
        copyrightElement.classList.add('hidden');
    }

    // Render media types conditionally (Images vs Video URLs)
    mediaViewport.innerHTML = '';
    if (data.media_type === 'image') {
        mediaViewport.innerHTML = `<img src="${data.url}" alt="${data.title}">`;
    } else if (data.media_type === 'video') {
        mediaViewport.innerHTML = `<iframe src="${data.url}" title="${data.title}" allowfullscreen></iframe>`;
    } else {
        mediaViewport.innerHTML = `<p style="padding: 20px;">Unsupported cosmic media format profile.</p>`;
    }

    apodCard.classList.remove('hidden');
}

function renderErrorState(message) {
    errorState.textContent = message;
    errorState.classList.remove('hidden');
}

function clearStatusFrames() {
    errorState.classList.add('hidden');
    loadingState.classList.add('hidden');
}

function hideDisplayCard() {
    apodCard.classList.add('hidden');
}
