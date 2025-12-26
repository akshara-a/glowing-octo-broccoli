## What is the Video About

The video explains how **asynchronous JavaScript works under the hood** — specifically, how the:

- Call Stack
- Web APIs
- Task (Macrotask) Queue
- Microtask Queue
- Event Loop

work together to allow **non-blocking, asynchronous behavior** in a browser.

It addresses a core challenge:

> JavaScript runs on a **single thread** — meaning normally code executes one statement at a time, in sequence.
> But modern web apps often need to wait for **timers, network requests, or user-events without freezing the UI**.
> The **event loop + queues** solve this problem.

---

## Key Concepts & Components (From the Video)

### Call Stack

- This is where JavaScript code **executes one function at a time**.
- It follows **LIFO (Last-In, First-Out)** order.
- **Synchronous tasks** (regular code, function calls, loops) run here.
- These tasks **block further execution until they complete**.

---

### Web APIs (Browser APIs)

- APIs like:

  - `setTimeout`
  - `fetch`
  - DOM Event Listeners

  **do NOT run directly in the call stack**.
- Instead, the browser handles them **outside the JS engine**.
- Once these operations complete:

  - The **callback is moved to the queue** for execution later.

---

### Task Queue (Macrotask Queue) & Microtask Queue

#### Macrotask Queue

Stores callbacks from:

- `setTimeout`
- `setInterval`
- DOM Events
- I/O tasks

#### Microtask Queue

Stores **higher-priority tasks** like:

- `Promise.then()`
- `Promise.catch()`
- `queueMicrotask`
- `MutationObserver`

**Microtasks always execute before macrotasks once the call stack is empty.**

---

### Event Loop

- The **Event Loop is the manager** that controls execution.
- Its job:

  1. Check if the **call stack is empty**.
  2. If yes → run **all microtasks first**.
  3. If microtasks are empty → run **one macrotask**.

This ensures **asynchronous operations never block the main thread**, even in a single-threaded language.

---

## Execution Flow — What Happens When You Run Code

### Example Code:

```js
console.log("Start");

setTimeout(() => {
  console.log("Timeout callback");
}, 0);

Promise.resolve().then(() => {
  console.log("Promise callback");
});

console.log("End");
