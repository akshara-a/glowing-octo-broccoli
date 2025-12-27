# Overview of JavaScript Runtime Components and Event Loop

## JavaScript Runtime Overview
- The **event loop** is a key part of JavaScript but only one component of the runtime.
- The JavaScript runtime includes:
  - **JavaScript Engine** — contains the **call stack** and **memory heap**.
  - **Web APIs** — Browser-provided interfaces such as DOM, fetch, setTimeout, geolocation, etc.
  - **Task Queue (Callback Queue)** and **Microtask Queue** — for handling asynchronous callbacks.
- JavaScript is **single-threaded**, executing one task at a time via the call stack.

---

## Call Stack Execution
- Each function or statement creates an **execution context** that is pushed onto the call stack.
- Example execution:
  - `console.log(1)` — pushes to stack, prints `1`, then pops.
  - `console.log(2)` — same.
  - Nested functions: `logThreeAndFour()` → `logThree()` → `console.log(3)` → return → `console.log(4)`
- Long-running synchronous tasks block the call stack and freeze the program.

---

## Asynchronous Tasks & Web APIs
- Real applications need long tasks like network requests or timers without blocking UI.
- **Web APIs handle async tasks outside the call stack**, allowing continued execution.
- Web APIs include:
  - Networking (`fetch`)
  - Timers (`setTimeout`)
  - Device features (camera, sensors, geolocation)

---

## Callback-Based Web APIs (Geolocation Example)
- Many Web APIs use **callbacks**.
- `getCurrentPosition(success, error)` registers callbacks then returns immediately.
- Browser handles permission & location independently.
- When ready, callback goes to **task queue**, not directly to the call stack.
- Executed only when the call stack is empty.

---

## Event Loop
- Monitors the call stack and task queue.
- If the call stack is empty, it moves the first callback from the task queue to the stack.
- Example with `setTimeout`:
  - Delay defines the *earliest possible execution time*, not a guaranteed exact time.
  - Busy call stack delays execution even after timer expires.

---

## Microtask Queue & Promises
- Promises and async/await use the **microtask queue**.
- Contains:
  - `.then()`, `.catch()`, `.finally()` callbacks
  - Tasks after `await`
  - `MutationObserver` callbacks
- **Microtask queue has priority over task queue**.
  - When stack becomes empty → run **all** microtasks before any task queue callbacks.
  - After each task queue callback, microtask queue is checked again.

---

## Fetch API (Promise Example)
Workflow:
1. `fetch()` creates a pending promise.
2. Browser handles network request asynchronously.
3. Synchronous code continues (e.g., `console.log('end of script')`).
4. When resolved, `then()` callback is placed in **microtask queue**.
5. Event loop processes the microtask when the stack is clear.

---

## Infinite Microtask Loops
- Microtasks may enqueue more microtasks → potential infinite loop.
- Can block the task queue and freeze the app.
- Node.js includes mechanisms to prevent unbounded recursion.

---

## Promisifying Callback-Based APIs
Callback APIs like geolocation can be wrapped in a Promise:
```js
const getLocation = () =>
  new Promise((resolve, reject) => {
    navigator.geolocation.getCurrentPosition(resolve, reject);
  });