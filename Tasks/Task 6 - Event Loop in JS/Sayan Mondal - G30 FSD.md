# JavaScript Visualized: Event Loop, Web APIs & Microtask Queue

JavaScript is a single-threaded language, meaning it executes one task at a time. Yet, it still manages timers, network requests, UI interactions, and asynchronous tasks smoothly. This is made possible through the **Event Loop**, **Web APIs**, and multiple **Queues**.

## 1. Call Stack — The Execution Area

The **Call Stack** is where JavaScript runs code line by line.

```javascript
console.log("Hello");
console.log("World");
```

These execute one after another because JS waits for each line to finish.

## 2. Web APIs — Browser's Background Workers

Some functions are not executed by JavaScript directly. They are handled by the browser's **Web APIs**, allowing JavaScript to continue running without waiting.

### Examples:
- `setTimeout()`
- `fetch()`
- DOM events (`onclick`, `addEventListener`)
- `setInterval()`

```javascript
setTimeout(() => {
  console.log("Done");
}, 1000);
```

The timer runs inside the browser, not the call stack.

## 3. Callback Queue (Task Queue)

After Web APIs finish their work, the callback is placed into the **Callback Queue**. But it only runs when the **Call Stack is empty**.

### Example:

```javascript
console.log("Start");

setTimeout(() => {
  console.log("Timeout");
}, 0);

console.log("End");
```

**Output:**
```
Start
End
Timeout
```

Even with 0ms, the callback waits until current tasks finish.

## 4. Microtask Queue — Higher Priority Tasks

Some tasks go into the **Microtask Queue**, which has **higher priority** than the callback queue.

### Microtasks include:
- `Promise.then()`
- `async/await`
- `queueMicrotask()`

### Example:

```javascript
console.log("Start");

setTimeout(() => console.log("Timeout"), 0);

Promise.resolve().then(() => console.log("Promise"));

console.log("End");
```

**Output:**
```
Start
End
Promise
Timeout
```

Microtasks always run before callback tasks.

## 5. Event Loop — The Traffic Controller

The **Event Loop** continuously checks:

1. Is the call stack empty?
2. If yes → run all **microtasks** first.
3. Once done → run tasks from the **callback queue**.

This makes JavaScript behave asynchronously even though it is single-threaded.

---

## Visual Summary

```
┌─────────────────┐
│   Call Stack    │ ← Executes code line by line
└─────────────────┘
        ↓
┌─────────────────┐
│    Web APIs     │ ← setTimeout, fetch, DOM events
└─────────────────┘
        ↓
┌─────────────────┐
│ Microtask Queue │ ← Promises, async/await (Higher Priority)
└─────────────────┘
        ↓
┌─────────────────┐
│ Callback Queue  │ ← setTimeout callbacks, event handlers
└─────────────────┘
        ↓
┌─────────────────┐
│   Event Loop    │ ← Monitors and moves tasks to call stack
└─────────────────┘
```

## Key Takeaways

- JavaScript is **single-threaded** but uses the **Event Loop** for asynchronous behavior
- **Web APIs** handle async operations in the background
- **Microtasks** (Promises) run before **macrotasks** (setTimeout)
- The **Event Loop** ensures tasks execute in the correct order