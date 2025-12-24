Learning Document – JavaScript Runtime & Event Loop
1. JavaScript Runtime Overview
JavaScript is single-threaded. It has:
•	A Call Stack (runs one function at a time)
•	Memory (heap)
•	The browser provides Web APIs to offload asynchronous tasks.
Because JS can execute only one task at a time, long-running tasks can freeze the page. So browsers provide async capabilities to avoid blocking the call stack.
2. Call Stack Execution
Each function call creates an execution context:
•	It is pushed onto the call stack
•	Runs
•	Gets popped off
Example: simple functions like log1, log2, log3 run one after another, synchronously.
If we run heavy computation, the call stack is busy and the UI becomes unresponsive until the task finishes.
3. Web APIs
Web APIs allow JS to outsource long tasks to the browser, such as:
•	setTimeout
•	fetch
•	Geolocation
•	DOM events
•	Sensors, camera, etc.
These APIs run in the background while the call stack continues executing other code.
When you call an async Web API:
1.	The function is added to the call stack.
2.	It registers callbacks.
3.	It is removed from the call stack.
4.	Browser performs the async work separately.
4. Task Queue (Macrotask Queue)
Callbacks from callback-based Web APIs (like setTimeout, geolocation, events) go into the task queue.
The callback is added to the task queue after the delay finishes, NOT executed immediately.
Execution happens only when:
•	The call stack is empty,
•	And all microtasks are completed.
5. Microtask Queue
Contains:
•	Promise .then, .catch, .finally
•	queueMicrotask
•	async/await continuation
•	MutationObserver callbacks
Microtasks have higher priority than macrotasks.
Event Loop rule:
1.	When the call stack is empty → run all microtasks.
2.	After microtasks → run one task from the task queue.
3.	Repeat.
Microtasks can schedule more microtasks; this may block the task queue if it never empties.
6. How fetch Works
1.	fetch() is added to the call stack.
2.	It creates a pending Promise.
3.	Browser starts network request (in background).
4.	.then() registers a reaction but waits.
5.	When the server responds:
o	Promise resolves,
o	Reaction goes to microtask queue,
o	Event loop executes the microtask and logs the result.
7. Example Order Output (5, 1, 3, 4, 2)
With:
•	Resolved promise
•	setTimeout
•	queueMicrotask
•	console.log
Order reasoning:
1.	5 → synchronous
2.	1 → Promise microtask
3.	3 → first queueMicrotask
4.	4 → microtask created inside another microtask
5.	2 → setTimeout (task queue)
Microtasks always complete before task queue execution.
