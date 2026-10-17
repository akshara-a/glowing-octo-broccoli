const result=document.getElementById("result");
const loading=document.getElementById("loading");
const error=document.getElementById("error");
const dateInput=document.getElementById("dateInput");
const button=document.getElementById("viewBtn");

window.onload=()=>{

let today=new Date().toISOString().split("T")[0];

dateInput.value=today;

loadAPOD(today);

};

button.addEventListener("click",()=>{

let selectedDate=dateInput.value;

let today=new Date().toISOString().split("T")[0];

result.innerHTML="";
error.textContent="";

if(selectedDate>today){

error.textContent="Please select today or a past date.";

return;

}

loadAPOD(selectedDate);

});

async function loadAPOD(date){

loading.textContent="Loading...";

result.innerHTML="";
error.textContent="";

try{

const response=await fetch(
`https://api.nasa.gov/planetary/apod?api_key=${API_KEY}&date=${date}`
);

if(!response.ok){

throw new Error();

}

const data=await response.json();

loading.textContent="";

let media="";

if(data.media_type==="image"){

media=`<img src="${data.url}" alt="${data.title}">`;

}
else{

media=`
<iframe
src="${data.url}"
allowfullscreen>
</iframe>
`;

}

result.innerHTML=`

<div class="card">

<h2>${data.title}</h2>

<p><strong>Date:</strong> ${data.date}</p>

<p><strong>Media Type:</strong> ${data.media_type}</p>

${media}

<p>${data.explanation}</p>

<p><strong>Copyright:</strong>
${data.copyright || "NASA"}
</p>

${
data.hdurl
?
`<p>
<a href="${data.hdurl}" target="_blank">
View HD Image
</a>
</p>`
:
""
}

</div>

`;

}

catch{

loading.textContent="";

error.textContent="Invalid API key or request failed.";

}

}