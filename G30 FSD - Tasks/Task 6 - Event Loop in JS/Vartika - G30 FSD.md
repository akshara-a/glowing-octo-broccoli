## JavaScript Event Loop, Web APIs, Task Queue & Microtask Queue
# 1. Introduction

The JavaScript Event Loop is often considered a tricky topic, but it is actually just one small part of the entire JavaScript runtime environment.
This runtime includes:

Call Stack

Memory Heap

Web APIs

Task Queue (Callback Queue)

Microtask Queue

Event Loop

All of these components work together to enable JavaScript—despite being single-threaded—to handle asynchronous operations without blocking the main thread.

# 2. JavaScript Engine & Call Stack

JavaScript uses a single call stack, which means only one task can be executed at a time.

Example Execution Flow

console.log(1) → pushed to stack → executed → popped

console.log(2) → executed

Function calls create new execution contexts on the stack

Once the function finishes, its context is removed

Important

If a task takes too long (e.g., a heavy calculation), the entire page can freeze.
To prevent this, long-running operations are delegated to Web APIs.

# 3. Web APIs

Web APIs are features provided by the browser. Examples include:

DOM (Document Object Model)

fetch()

setTimeout()

Geolocation API

Timers

Networking operations

Device features (camera, sensors, geolocation, etc.)

These APIs allow JavaScript to run tasks asynchronously, without blocking the call stack.

# 4. How Callback-Based Web APIs Work

Example using the Geolocation API:

navigator.geolocation.getCurrentPosition(successCallback, errorCallback);

Flow

The function call enters the call stack

It registers the callbacks and starts the async task

The call stack continues immediately

The browser handles the popup in the background

Once the user clicks Allow, the success or error callback is moved to the Task Queue

The Event Loop pushes it to the call stack only when the stack is empty

This ensures the UI remains responsive.

# 5. setTimeout() Behavior

setTimeout() accepts:

A callback function

A delay (in milliseconds)

Important Note

The delay does not guarantee when the callback will run.
It only determines when the callback will move to the Task Queue.

If the call stack is busy, the callback must wait longer.

# 6. Task Queue (Callback Queue)

The Task Queue contains callbacks from Web APIs.

The Event Loop continuously checks:

Is the call stack empty?

Yes → move the next task from the Task Queue to the call stack

No → keep waiting

# 7. Promises & the Microtask Queue

Promise-based APIs (like fetch) push their callbacks into the Microtask Queue, not the Task Queue.

The Microtask Queue includes:

.then()

.catch()

.finally()

Code after await

queueMicrotask()

MutationObserver callbacks

Priority Rule

The Microtask Queue has higher priority than the Task Queue.

The Event Loop will:

Completely empty the Microtask Queue

Then execute one task from the Task Queue

Then check the Microtask Queue again

Repeat

# 8. Example With fetch()
fetch(url)
  .then(res => console.log(res));

console.log("End of script");

Flow

fetch() creates a Promise (initially pending) and starts a network request

.then() registers a promise reaction

Synchronous code runs → "End of script"

Network response arrives → the Promise is fulfilled

The .then() callback goes into the Microtask Queue

The Event Loop executes it (because microtasks run before tasks)

# 9. Microtask Queue Infinite Loop

Microtasks can schedule more microtasks.
If this continues indefinitely, the Event Loop never reaches the Task Queue, causing the program to freeze.

Node.js prevents this by limiting the number of microtasks per cycle.

# 10. Converting Callback APIs to Promises (Promisifying)

Example with the Geolocation API:

function getPosition() {
  return new Promise((resolve, reject) => {
    navigator.geolocation.getCurrentPosition(resolve, reject);
  });
}


This makes the code more readable and easier to work with.

# 11. Quiz Result Explained

Output: 5 → 1 → 3 → 4 → 2

Explanation:

5 runs first (synchronous)

1 runs next (Promise .then() → microtask)

3 runs (queueMicrotask())

4 runs (nested microtask)

2 runs last (setTimeout() callback → task queue)

# 12. Summary

## ✔ JavaScript is single-threaded
## ✔ Web APIs allow long tasks to run in the background
## ✔ The Task Queue stores callback-based async tasks
## ✔ The Microtask Queue stores Promise-based callbacks
## ✔ Event Loop cycle:

Execute call stack

Empty Microtask Queue

Execute one Task Queue item

Repeat

Understanding these concepts helps explain why different parts of asynchronous JavaScript execute in a particular order.