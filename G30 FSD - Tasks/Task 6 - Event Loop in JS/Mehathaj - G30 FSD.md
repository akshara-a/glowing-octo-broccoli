#JavaScript Event Loop

##JavaScript Core Behavior
- JavaScript is **single-threaded** (executes one task at a time).
- Uses a **Call Stack** to run all synchronous code.
- Asynchronous behavior is handled by the **browser Web APIs** or Node environment.

---

##Call Stack
- Executes functions in **LIFO (Last In First Out)** order.
- Blocks new tasks until current execution finishes.

---

##Web APIs
- Not part of JavaScript engine.
- Handle async operations like:
  - `setTimeout`
  - `fetch`
  - DOM events
- After completing tasks, they send callbacks to queues.

---

##Task Queue (Macrotask Queue)
- Stores callbacks from:
  - `setTimeout`
  - `setInterval`
  - DOM events
- Executed only **after** all microtasks finish.

---

##Microtask Queue
- Stores higher-priority tasks:
  - `Promise.then()`
  - `catch`
  - `async/await`
- Runs **immediately after current script** and **before any macrotask**.

---

##Event Loop
- Constantly monitors:
  1. Is the Call Stack empty?
  2. Run **all microtasks**.
  3. Run **one macrotask**.
  4. Repeat.

---

##Execution Order (Very Important)
1. **Synchronous code**
2. **All microtasks (Promises)**
3. **One macrotask (setTimeout)**
4. Event Loop cycles again

---

##Most Important Takeaways
- Promises always run **before** setTimeout.
- Async tasks do NOT run immediately; they wait in queues.
- The event loop ensures JavaScript stays **non-blocking**.
- Microtask queue has **higher priority** than macrotask queue.
- Understanding queues helps avoid unexpected output order bugs.