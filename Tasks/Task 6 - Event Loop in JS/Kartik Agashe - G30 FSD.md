# JavaScript Event Loop, Task Queue & Microtask Queue

## Author
**Kartik Agashe**

---

## 1. Introduction

JavaScript is a single-threaded language, which means it can run only one line of code at a time.  
If we run a long or slow task, the whole page can freeze.

To avoid this problem, JavaScript uses asynchronous programming and a system called the Event Loop.

The event loop works with:

- Call Stack
- Web APIs
- Task Queue
- Microtask Queue

These components help JavaScript run smoothly without blocking the main thread.

---

## 2. Key Points

### JavaScript Runtime Parts

- **Call Stack**: Runs normal synchronous code.
- **Web APIs**: Handles async work such as fetch, setTimeout, geolocation, etc.
- **Task Queue (Macrotask Queue)**: Stores callbacks from `setTimeout`, events, intervals.
- **Microtask Queue**: Stores Promise handlers (`then`, `catch`, `finally`) and `async/await` results.
- **Event Loop**: Moves tasks from queues to the call stack at the correct time.

---

### Why Blocking Happens

JavaScript runs only one thing at a time.  
A long synchronous task (like a large loop) can block everything and freeze the UI.

---

### How Asynchronous Code Works

1. JavaScript offloads async work to Web APIs.
2. When work is finished, the callback or promise resolution is placed in a queue.
3. The Event Loop checks when the call stack is empty and then moves queued tasks back to the stack.

---

### What Executes First?

**Microtasks always run before macrotasks**, even if the macrotask timeout is 0ms.

Example:  
`Promise.then()` runs before `setTimeout()`.

---

### Promise Execution

- `fetch()` immediately returns a pending promise.
- Network request happens in Web APIs.
- After finishing, the `.then()` callback is added to the microtask queue.
- The event loop always runs microtasks before macrotasks.

---

### Microtask Starvation

If microtasks keep creating more microtasks, the task queue may never run.  
This condition is called **microtask starvation**.

---

### Order of Execution (Important Rule)

1. Run all synchronous code.
2. Run all microtasks (Promise handlers).
3. Run the next macrotask (like `setTimeout`).
4. Repeat.

This rule helps predict output when asynchronous operations are mixed.

---

## 3. What I Learned

- JavaScript is single-threaded, so async behavior is needed to keep apps smooth.
- Web APIs handle background work, so the call stack is not blocked.
- Promise callbacks run before `setTimeout` because they go into the microtask queue.
- The Event Loop controls when callbacks and tasks should run.
- Execution order (sync → microtasks → macrotasks) helps predict output.
- New concepts learned:
  - Call Stack
  - Microtask Queue
  - Macrotask Queue
  - Starvation
  - Promisification

These explain how JavaScript handles async operations internally.

---

## 4. Conclusion

The Event Loop is one of the most important concepts in JavaScript.  
It allows JavaScript to handle asynchronous tasks without freezing the page.

### Execution Order Summary

1. Synchronous code runs first.
2. Microtasks (Promises) run second.
3. Macrotasks (timeouts, events) run third.

Understanding this makes debugging and writing async code much easier.

---
