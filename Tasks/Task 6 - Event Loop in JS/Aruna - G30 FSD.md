#JavaScript Event Loop

##1️⃣ JavaScript runs single-threaded

It can execute one line at a time --- no parallel execution inside the main thread.

##2️⃣ There is a Call Stack

All normal code (functions, loops, logs) gets executed here.

Example: console.log("Hi") goes directly to the stack and runs.

##3️⃣ Web APIs are separate from JS engine

setTimeout, fetch, DOM events, etc., are not run by JS. They are handled by browser Web APIs.

##4️⃣ Asynchronous functions go OUTSIDE the stack

When JS sees setTimeout(...) or fetch(...), it:

->removes it from the stack
->sends it to Web APIs to wait there

##5️⃣ After async work completes, callbacks go to queues

When a timer finishes or a network request completes:

->they don't run immediately
->they are put into queues

There are two main queues like follows:-

##6️⃣ Macrotask Queue (Task Queue)

Contains:

->setTimeout
->setInterval
->DOM events
->I/O callbacks

These are "big tasks."

##7️⃣ Microtask Queue

Contains:

-Promise.then
-async/await resolved jobs

These are "high priority tasks."

##8️⃣ Event Loop decides what runs next

The event loop checks:

-->Is the call stack empty?
-->If yes → run all microtasks first
-->Then run one macrotask
-->Repeat

##9️⃣ Microtasks always run before macrotasks

Even if setTimeout(..., 0) finishes first, Promise callbacks still run earlier.

Example:

console.log("A");

setTimeout(() =\> console.log("B"), 0);

Promise.resolve().then(() =\> console.log("C"));

console.log("D");

Output:

A D C B

##🔟 This is why JavaScript feels asynchronous

Even though JS is single-threaded, event loop + queues + Web APIs allow:

->background waiting
->non-blocking UI
->async tasks
->fast & responsive apps
