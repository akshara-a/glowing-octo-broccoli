1. JavaScript Execution Model

JavaScript is single-threaded — it can execute only one task at a time.
All synchronous code runs directly on the Call Stack.
Asynchronous code does not block the main thread.

2. Call Stack
A data structure where JavaScript executes functions line by line.
If a function is called → pushed to stack → after completion → popped out.
If the call stack is busy, nothing else can run.

3. Web APIs (Browser/Runtime APIs)
When JS encounters asynchronous functions (like setTimeout, network requests, DOM events),
it delegates them to Web APIs.
These APIs run in the background without blocking the call stack.
Examples of Web APIs:
setTimeout, setInterval
fetch / AJAX requests
Event listeners (click, scroll, input)
DOM timers & I/O operations

4. Task Queues (Two Types)
When an async operation finishes, its callback is sent to a queue.

A) Macrotask Queue (Task Queue / Callback Queue)
Stores callback tasks like:
setTimeout, setInterval
UI event callbacks
Network callbacks
Lower priority than microtasks.

B) Microtask Queue
Stores micro operations like:
Promise.then(), Promise.catch()
async/await resolutions
queueMicrotask()
MutationObserver
Highest priority queue in JavaScript.

5. Event Loop
The event loop continuously checks:
Is the Call Stack empty?
If yes → run ALL microtasks first
After microtasks are finished → pick one macrotask and run it
Repeat the cycle
So the priority order is:
Call Stack → Microtask Queue → Macrotask Queue

6. Execution Flow Summary
Synchronous code runs first (Call Stack)
Async tasks are handed to Web APIs
When completed, callbacks go:
Promises → Microtask Queue
Timers/Events → Macrotask Queue

Event Loop:
Empties microtask queue first
Then runs the next macrotask
Cycle repeats
This is how JavaScript becomes non-blocking and still remains single-threaded.

7. Output Ordering Example
console.log("Start");

setTimeout(() => console.log("Timeout"), 0); // macrotask
Promise.resolve().then(() => console.log("Promise")); // microtask

console.log("End");

Output:
Start
End
Promise
Timeout

✔ Microtasks always run before macrotasks
✔ After the call stack becomes empty

8. Why it Matters
Helps you understand when asynchronous code executes
Avoids timing issues and unexpected output
Improves debugging of Promises, async/await, event handling
Essential for writing efficient & responsive web applications
