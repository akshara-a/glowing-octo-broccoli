# JavaScript Event Loop 

## 1. JavaScript Execution Model
- JavaScript is **single-threaded**.
- Executes code on one **Call Stack**.
- Asynchronous behavior is handled through:
  - Web APIs
  - Microtask Queue
  - Macrotask Queue (Task Queue)
  - Event Loop



## 2. Call Stack
- Executes **synchronous** JavaScript code.
- Functions are pushed when called and popped when completed.
- Only one function runs at a time.



## 3. Web APIs (Browser Environment)
- Provided by the browser, not JavaScript.
- Handle asynchronous operations in background.
- Examples:
  - `setTimeout`
  - `setInterval`
  - `fetch`
  - DOM events
  - Promise resolution mechanism



## 4. Event Loop
- Controls execution order.
- Continuously performs:
  1. Check if Call Stack is empty  
  2. Execute **all microtasks**  
  3. Execute **one macrotask**  
- Repeats forever.

---

## 5. Microtask Queue
- High-priority async queue.
- Processed **before macrotasks**.
- Runs until completely empty.
- Examples:
  - `Promise.then()`
  - `async/await` continuation
  - `queueMicrotask()`
  - MutationObserver



## 6. Macrotask Queue (Task Queue)
- Lower-priority async queue.
- Event Loop executes **one macrotask per cycle**.
- Examples:
  - `setTimeout`
  - `setInterval`
  - DOM events
  - `fetch` response callback



