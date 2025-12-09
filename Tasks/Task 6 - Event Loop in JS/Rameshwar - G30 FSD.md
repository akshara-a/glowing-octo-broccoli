1. Introduction

JavaScript is a single-threaded programming language.
This means:

It can execute only one line of code at a time

It uses a Call Stack to run functions

It relies on the Browser (Web APIs) for asynchronous operations

It uses Queues (Microtask & Callback Queues) to manage async tasks

The Event Loop decides what runs next

Although JS is single-threaded, it still handles asynchronous tasks smoothly due to this architecture.

2. Call Stack (Execution Stack)

The Call Stack is the main workspace of JavaScript.

✔ How it works:

Follows LIFO (Last In, First Out)

Holds functions that are currently executing

A function must finish before the next one runs

Example:
function first() {
  second();
}

function second() {
  console.log("Hello");
}

first();


How the Call Stack processes it:

| second() |
| first()  |
| global() |


When a function completes, JS pops it from the stack.

3. Web APIs (Browser Environment)

Some functions don’t run in JavaScript engine.
They are handed to the browser environment.

Examples:

setTimeout()

fetch()

DOM events

setInterval()

AJAX requests

Timers

Role of Web APIs:

Receive async tasks

Process them in background

Send results back to task queues

4. Callback Queue (Macrotask Queue)

This queue stores callbacks from Web APIs that are ready to run.

Common macrotasks:

setTimeout

setInterval

DOM event callbacks

fetch() response callbacks (depending on environment)

Order:
They wait here until the Call Stack is empty.

5. Microtask Queue (Higher Priority)

Microtasks are small, urgent tasks that must run before other async tasks.

Common microtasks:

Promise.then()

Promise.catch()

Promise.finally()

queueMicrotask()

MutationObserver

Priority:
Microtasks always run before macrotasks, even if a timer has expired.

6. Event Loop

The Event Loop continuously checks:

Is the Call Stack empty?

If yes → Run ALL microtasks

After all microtasks → Run the next macrotask

Repeat forever…

Event Loop Responsibilities:

Moves tasks from queues to call stack

Maintains order

Ensures JavaScript remains non-blocking

7. Complete Example
console.log("Start");

setTimeout(() => {
  console.log("Timeout");
}, 0);

Promise.resolve().then(() => {
  console.log("Promise");
});

console.log("End");

Step-by-step execution:

"Start" → printed

"End" → printed

Promise callback → goes to Microtask Queue

setTimeout callback → goes to Macrotask Queue

Microtask (“Promise”) runs first

Macrotask (“Timeout”) runs next

Final Output:
Start
End
Promise
Timeout

8. Visual Diagram
               ┌───────────────┐
               │   Call Stack   │
               └───────▲───────┘
                       │
             Event Loop │
                       ▼
        ┌────────────────────────┐
        │    Microtask Queue     │  ← Promises, queueMicrotask()
        └────────────────────────┘
                       │
                       ▼
        ┌────────────────────────┐
        │   Callback Queue       │  ← setTimeout, events
        └────────────────────────┘
                       │
                       ▼
        ┌────────────────────────┐
        │        Web APIs        │
        └────────────────────────┘

9. Quick Summary (Cheat Sheet)
Call Stack

Runs functions one at a time.

Web APIs

Handle async actions.

Microtask Queue

Promise callbacks — highest priority.

Callback Queue

Timer, events — run after microtasks.

Event Loop

Controls what to run next.
