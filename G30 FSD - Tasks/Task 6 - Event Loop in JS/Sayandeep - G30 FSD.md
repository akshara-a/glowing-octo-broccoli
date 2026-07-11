# JavaScript Runtime, Event Loop, and Asynchronicity

## 1. JavaScript Runtime Environment

The **JavaScript runtime** is the environment where JavaScript code is executed. While JavaScript itself is **single-threaded** (meaning it can only execute one task at a time), the runtime provides external mechanisms to handle long-running operations in a **non-blocking way**.

The core components of the runtime are:

* **Call Stack:** Manages the execution of **synchronous code**.
* **Web APIs:** Browser interfaces that handle **asynchronous tasks** like timers (`setTimeout`), network requests (`fetch`), or DOM events.
* **Task Queue (Callback Queue):** Holds callbacks from **Web APIs** waiting for execution.
* **Microtask Queue:** Holds callbacks from **Promise handlers** (`.then()`, `.catch()`) and certain other high-priority tasks.
* **Event Loop:** The orchestrator that constantly monitors the Call Stack and moves tasks from the queues to the Call Stack for execution.

---

## 2. The Call Stack and Blocking Code

The **Call Stack** works on a **LIFO (Last-In, First-Out)** basis, handling one execution context at a time.

A major issue arises with **long-running synchronous tasks** (e.g., heavy computation). Since the Call Stack is single-threaded, if a task takes a long time, it **blocks the entire program** (the website becomes unresponsive).

To avoid this blocking behavior, JavaScript utilizes **Web APIs** to offload asynchronous tasks.

---

## 3. Web APIs and Offloading Asynchronous Tasks

**Web APIs** expose browser features that allow us to start asynchronous processes in the background.

When an asynchronous function (like `setTimeout` or `fetch`) is called:
1.  The function invocation is briefly added to the **Call Stack**.
2.  It immediately **pops off the Call Stack** to hand the asynchronous task over to the **browser (Web APIs)** for processing.
3.  The **Call Stack is now free** to process other synchronous code, keeping the application responsive.

Asynchronous Web APIs are generally **callback-based** (e.g., `setTimeout`, `geolocation`) or **promise-based** (e.g., `fetch`).

---

## 4. The Queues and The Event Loop

### The Task Queue (Callback Queue)

* **What it holds:** Callbacks from **callback-based Web APIs** (e.g., `setTimeout`, `addEventListener`, `geolocation`).
* **Flow:** Once a Web API task is complete (e.g., the `setTimeout` timer expires), its associated callback function is moved to the **Task Queue**.
* **Important Note:** The time delay specified in `setTimeout(callback, delay)` is the **minimum time until the callback is pushed to the Task Queue**, not the guaranteed time until execution. The callback must still wait until the Call Stack is empty to be executed.

### The Microtask Queue

* **What it holds:** Handlers for **promise-based APIs** (e.g., `.then()`, `.catch()`, `.finally()`), `queueMicrotask` callbacks, and code execution after `await`.
* **Flow (Example with `fetch`):** When a `fetch` request resolves, the associated `.then()` handler is immediately pushed to the **Microtask Queue**.

### The Event Loop (Priority and Execution Order)

The **Event Loop** constantly monitors the **Call Stack**. When the Call Stack is empty, it acts as follows:

1.  **Microtask Priority:** The Event Loop **prioritizes the Microtask Queue**. It will check the Microtask Queue first and ensure it is **entirely empty** before moving on to the Task Queue.
2.  **Task Queue Check:** Only once the Microtask Queue is clear does the Event Loop take the first task from the **Task Queue** and push it onto the Call Stack for execution.
3.  **Re-check:** After *each* task is processed from the Task Queue, the Event Loop **re-checks the Microtask Queue** again before fetching the next Task Queue item.
