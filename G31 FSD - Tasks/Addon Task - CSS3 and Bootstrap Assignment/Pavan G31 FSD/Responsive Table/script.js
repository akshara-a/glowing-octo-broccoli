const viewButtons = document.querySelectorAll(".btn-view");

viewButtons.forEach(button => {

    button.addEventListener("click", () => {

        alert("Viewing employee details");

    });

});

const editButtons = document.querySelectorAll(".btn-edit");

editButtons.forEach(button => {

    button.addEventListener("click", () => {

        alert("Editing employee details");

    });

});