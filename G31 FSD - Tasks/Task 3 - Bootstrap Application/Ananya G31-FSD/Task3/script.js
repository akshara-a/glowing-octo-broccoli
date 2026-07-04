      const taskInput = document.getElementById("taskInput");
      const taskList = document.getElementById("taskList");
      const taskForm = document.getElementById("taskForm");
      const taskCount = document.getElementById("taskCount");
      const taskTemplate = document.getElementById("taskTemplate");

      const updateCount = () => {
        const total = taskList.querySelectorAll("li").length;
        taskCount.textContent = `${total} task${total === 1 ? "" : "s"}`;
      };

      const addTask = (title) => {
        const item = taskTemplate.content.firstElementChild.cloneNode(true);
        const label = item.querySelector(".task-label");
        const removeButton = item.querySelector(".task-remove");

        label.textContent = title;
        label.addEventListener("click", () => {
          label.classList.toggle("task-done");
        });

        removeButton.addEventListener("click", () => {
          item.remove();
          updateCount();
        });

        taskList.appendChild(item);
        updateCount();
      };

      taskForm.addEventListener("submit", (event) => {
        event.preventDefault();

        const title = taskInput.value.trim();
        if (!title) {
          return;
        }

        addTask(title);
        taskInput.value = "";
        taskInput.focus();
      });

      addTask("Set up Bootstrap app");
      addTask("Build one more task");
      updateCount();