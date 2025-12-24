#  JavaScript Event Loop & Async Runtime
                                     By Varsha - G30 FSD
## Overview
JavaScript is a single-threaded language, meaning it has one call stack and can execute one task at a time.
However, modern applications require asynchronous operations such as:

- Network requests
- Timers
- User interactions
- Reading sensors, geolocation, etc.

To handle these without blocking the UI, JavaScript relies on the JavaScript Runtime, which includes:

- Call Stack
- Web APIs
- Task Queue (Callback Queue)
- Microtask Queue
- Event Loop

Together, these allow JavaScript to run asynchronous code efficiently and non-blocking.

---
## 1. Call Stack

The Call Stack executes code in order.

Example:
```
console.log(1);
console.log(2);
function log3And4() {
  console.log(3);
  console.log(4);
}
log3And4();
```

Flow:
- console.log(1) → logs 1
- console.log(2) → logs 2
- log3And4() pushed → executes logs 3 & 4
- All execution contexts pop off

If you run a long operation (heavy computation), the call stack gets blocked → UI freezes.

---
## 2. Web APIs

The browser environment provides powerful APIs:

- ```fetch```
- ```setTimeout```
- ```Geolocation```
- DOM Manipulation
- Timers, sensors, camera, network stack, etc.

These APIs allow us to offload long-running tasks to the browser.

Example:
```
navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
```

Call is added to call stack  
Callbacks are registered  
Actual location fetching happens in the browser (NOT in call stack)  
When ready → callback moves to Task Queue

---
## 3. Task Queue (Callback Queue)

Holds callbacks from:
- ```setTimeout```
- ```setInterval```
- Web API callbacks
- User event handlers

Tasks in this queue run only when call stack is empty.

Example:
```
setTimeout(() => console.log("Hello"), 1000);
```

**1000 ms is NOT the exact execution time.**  
It only ensures the callback is moved to Task Queue after 1000ms.  
Execution happens later, when the call stack becomes empty.

---
## 4. Microtask Queue

This queue has higher priority than the task queue.

Contains:
1. ```Promise.then```
2. ```Promise.catch```
3. ```Promise.finally```
4. async/await continuation
5. ```queueMicrotask``` callbacks
6. MutationObserver callbacks

**Event Loop always empties microtask queue first.**

---
## 5. Event Loop – The Heart of Async JS

Event Loop continuously checks:

1. Is the call stack empty? :  If yes → run all microtasks first.

2. After microtasks are done → Move one task from the Task Queue to the call stack.

3. Repeat forever : Event Loop is what makes JavaScript asynchronous despite being single-threaded.

---
## 6. Promise-based APIs vs Callback-based APIs

**Callback-based examples:**

- ```setTimeout```
- Geolocation API

     Their callbacks go to Task Queue.

**Promise-based examples:**

- fetch
- ```Promise.resolve()```
        
     Their ```.then()``` callbacks go to Microtask Queue (highest priority).

Example:
```
fetch(url).then(res => console.log(res));
```

Flow:
1. fetch starts network request in browser
2. JS continues running
3. When data arrives → ```.then()``` pushed to microtask queue
4. Event loop executes it after call stack clears

---
## 7. Microtask Queue Can Block Everything

If a microtask keeps adding more microtasks, the event loop never reaches the Task Queue, causing a freeze.

Example:
```
queueMicrotask(() => queueMicrotask(() => queueMicrotask(...)));
```
---

## 8. Example Quiz Output

Given code logs:

 **5 1 3 4 2**

Reason:

- ```console.log(5)``` → synchronous
- Promise → microtask → logs 1
- queueMicrotask → logs 3
- nested microtask → logs 4
- setTimeout → task queue → logs 2 last

---

##  Key Takeaways

1. JavaScript is **single-threaded** but appears asynchronous due to runtime components.
2. **Web APIs** handle long tasks outside the call stack.
3. **Task Queue** handles callback-based async tasks.
4. **Microtask Queue** (Promised-based) runs with highest priority.
5. **Event Loop** coordinates when tasks and microtasks run.
6. Understanding this flow helps explain execution order of async code.

---
## Conclusion

The JavaScript Event Loop plays a crucial role in enabling asynchronous and non-blocking behavior in a single-threaded language. By understanding how the call stack, Web APIs, task queue, and microtask queue interact, I gained clarity on why certain operations run immediately while others wait their turn.

Mastering these concepts helps us to write more efficient and predictable applications. It also prevents common issues such as UI freezing, unexpected timing bugs, and race conditions. When we clearly understand how JavaScript schedules tasks and prioritizes microtasks over normal callbacks, we can design code that is smoother, faster, and more responsive.

Overall, the Event Loop is the backbone of JavaScript’s asynchronous model, and a solid grasp of it is essential for building modern, performant web applications.