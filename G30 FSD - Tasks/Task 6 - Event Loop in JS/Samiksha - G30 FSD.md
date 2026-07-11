# JavaScript Event Loop
1. JavaScript executes on a single main thread (the JS engine).  
2. Synchronous code runs on the call stack and executes immediately.  
3. Asynchronous APIs (timers, XHR/fetch, DOM events, I/O) are handled outside the JS call stack by the environment (browser or Node) and schedule callbacks to run later.  
4. When an async operation completes, its callback is queued rather than executed immediately.  
5. There are two important scheduling categories:
   - Microtasks (higher priority): Promise callbacks (.then/.catch/.finally), queueMicrotask, MutationObserver, and in Node: process.nextTick (which has special behavior).
   - Macrotasks (sometimes called "tasks"): setTimeout, setInterval, I/O callbacks, UI events, setImmediate (Node), and others.
6. After the call stack becomes empty, the runtime runs:
   - All pending microtasks (draining the microtask queue completely),
   - Then rendering steps if needed (in browsers),
   - Then one macrotask from the macrotask queue, and repeat.
7. Therefore microtasks always run before the next macrotask; microtasks scheduled during microtask processing are processed in the same microtask drain.
8. setTimeout(..., 0) does not run immediately — it runs as a macrotask after microtasks and other queued macrotasks. Browsers may also enforce minimum timer clamping (e.g., 4ms for nested timers).
9. Node and browsers differ in some details (e.g., process.nextTick runs before other microtasks in Node; setImmediate and timers have different scheduling).

## Example

```javascript
console.log("Start");

setTimeout(() => {
  console.log("From Timeout");
}, 0);

Promise.resolve().then(() => {
  console.log("From Promise");
});

console.log("End");
```

Output :
```
    Start  
    End  
    From Promise  
    From Timeout
```

## Summary
+ The event loop ensures that synchronous code runs first, then microtasks are drained, then macrotasks are processed. This helps prevent UI freezes, unexpected ordering bugs and makes async code predictable.
markdown
+ Always display this snippet in chat as markdown in the language provided.

