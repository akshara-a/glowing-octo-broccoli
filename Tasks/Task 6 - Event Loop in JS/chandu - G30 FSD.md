### **JavaScript Visualized: Event Loop, Web APIs \& Microtask Queue**

JavaScript runs on a single thread, meaning it can handle only one thing at a time. So if JavaScript is single-threaded, how does it still manage timers, fetch requests, button clicks and promises without freezing the page?

That's where the Event Loop, Web APIs, and different Queues come in.



##### **Call Stack — Where Code Runs**

The call stack is where JavaScript executes code line by line.



Example:

console.log("Hello");

console.log("World");



These run one after another because JavaScript waits for one task to finish before moving to the next.



##### **Web APIs — Browser Helping JavaScript**

Some tasks like:



•	setTimeout()

•	fetch()

•	DOM events (onclick)

•	setInterval()



are not handled by JavaScript directly.

They are sent to the browser’s Web APIs, which run them in the background.

So JavaScript doesn’t sit waiting and get stuck — it keeps moving.



Example:

setTimeout(() => {

&nbsp; console.log("Done");

}, 1000);



The timer runs in Web APIs, not on the call stack.



##### **Callback Queue (Task Queue)**

Once a Web API finishes its work, the callback function is placed in the callback queue.

But it doesn’t run immediately — it waits until the call stack is empty.



Example output order:

console.log("Start");



setTimeout(() => {

&nbsp; console.log("Timeout");

}, 0);



console.log("End");



**Output:**

Start

End

Timeout

Even though the timeout is 0ms, it waits because the call stack must clear first.



##### **Microtask Queue — Higher Priority Queue**

Some tasks don’t go to the normal callback queue. Instead, they go to the microtask queue.

This includes:



•	Promise.then()

•	async/await

•	queueMicrotask()

Microtasks run before normal callback tasks.



Example:

console.log("Start");



setTimeout(() => console.log("Timeout"), 0);



Promise.resolve().then(() => console.log("Promise"));



console.log("End");



**Output becomes:**

Start

End

Promise

Timeout

The promise runs before the timeout because microtasks have higher priority.



##### **Event Loop — The Traffic Controller**

The event loop keeps checking:

Is the call stack empty?

If yes:

1\.	First, it takes tasks from the microtask queue.

2\.	Then it takes tasks from the callback queue.

This cycle continues very fast, making JavaScript feel asynchronous and smooth.





