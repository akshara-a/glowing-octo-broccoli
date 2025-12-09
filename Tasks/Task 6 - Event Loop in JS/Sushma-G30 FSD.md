# javascript event loop
# 1. Introduction

The video explains how JavaScript, even though it is a single-threaded and synchronous programming language, can still perform tasks like waiting for timers, handling network requests, and responding to user actions without blocking the main thread.
This is made possible through the Event Loop, Web APIs, Call Stack, and various task queues.

# 2. JavaScript is Single-Threaded

JavaScript runs code one line at a time on a single call stack.
Because of this, it cannot execute multiple instructions in parallel on the same thread.
To handle asynchronous tasks efficiently, JavaScript depends on the surrounding environment (like the browser).

# 3. Call Stack

The Call Stack is where JavaScript executes all synchronous code.

Whenever a function is called, it is pushed onto the stack, and once completed, it is popped off.

Only one function executes at a time.

Example: console.log() runs directly in the call stack.

# 4. Web APIs (Browser-Provided APIs)

The JavaScript engine itself cannot manage asynchronous tasks like:

setTimeout

fetch()

DOM event listeners

These tasks are handled by Web APIs, which belong to the browser environment.
When such functions are encountered, they are moved out of the call stack and managed separately.

# 5. Completion of Async Tasks and Queues

Once Web APIs finish their work (e.g., a timer expires or network response arrives), they do not run the callback immediately.
Instead, the callback is sent to a queue.

JavaScript uses two main types of queues:

# 6. Macrotask Queue (Task Queue)

Contains “larger” asynchronous tasks such as:

setTimeout

setInterval

DOM events

I/O callbacks

These tasks are handled after all microtasks are completed.

# 7. Microtask Queue

Contains high-priority tasks such as:

Promise.then()

async/await resolved callbacks

MutationObservers

Microtasks are always executed before macrotasks.

# 8. Event Loop

The Event Loop continuously monitors the system and follows these steps:

Check if the Call Stack is empty.

If empty, execute all microtasks from the microtask queue.

After that, run one task from the macrotask queue.

Repeat the cycle.

This mechanism ensures that JavaScript handles asynchronous operations properly while maintaining non-blocking behavior.

# 9. Priority: Microtasks Before Macrotasks

Even if a timer finishes first, Promise callbacks still run earlier because they are placed in the microtask queue, which has higher priority.

Example Order:

console.log("A");

setTimeout(() => console.log("B"), 0);

Promise.resolve().then(() => console.log("C"));

console.log("D");


Output: A D C B



This clearly shows microtasks (Promise) executing before macrotasks (setTimeout).

# 10. Why JavaScript Feels Asynchronous

Even though JavaScript executes code in a single thread, the combination of:

Web APIs

Event Loop

Microtask Queue

Macrotask Queue

allows JavaScript to handle asynchronous operations without blocking the UI.
This makes web applications fast, responsive, and capable of performing background tasks efficiently.

# 11. Conclusion

The video provides a clear visualization of how the JavaScript event loop works.
By understanding how the call stack, Web APIs, microtask queue, macrotask queue, and event loop interact, developers can write better asynchronous code and predict the execution order more accurately.