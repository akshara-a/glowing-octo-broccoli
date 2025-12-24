# JavaScript Visualized --- Event Loop, Web APIs & Queues (Modified Version)

JavaScript is **single-threaded**, meaning it executes one piece of code
at a time. But modern web apps still manage timers, network calls, and
events smoothly using the **Event Loop**, **Web APIs**, and **Queues**.

## 1. Call Stack --- The Execution Center

The call stack runs JavaScript code line-by-line.

``` js
console.log("Hello");
console.log("World");
```

Each line waits for the previous one.

## 2. Web APIs --- Browser Side Helpers

Operations handled by Web APIs: - setTimeout() - setInterval() -
fetch() - DOM events

Example:

``` js
setTimeout(() => {
  console.log("Done");
}, 1000);
```

## 3. Callback Queue (Macrotask Queue)

After a Web API finishes, its callback enters the callback queue.

``` js
console.log("Start");

setTimeout(() => console.log("Timeout"), 0);

console.log("End");
```

Output:

    Start
    End
    Timeout

## 4. Microtask Queue --- Highest Priority

Promises and async operations enter the microtask queue (higher
priority).

``` js
console.log("Start");

setTimeout(() => console.log("Timeout"), 0);

Promise.resolve().then(() => console.log("Promise"));

console.log("End");
```

Output:

    Start
    End
    Promise
    Timeout

## 5. Event Loop --- The Manager

Order: 1. Check if call stack is empty. 2. Run **all microtasks**. 3.
Then run **callback queue** tasks.

This loop keeps JavaScript responsive and asynchronous.
