# Learning Document – JavaScript Event Loop

1. JavaScript is single-threaded and runs code on the call stack.
2. When async functions run, the browser uses Web APIs to handle them.
3. After finishing, Web APIs send callbacks to queues.
4. There are two queues: macrotask queue (setTimeout, events) and microtask queue (Promises).
5. **Microtasks run before macrotasks.
6. Example: Promise → microtask, setTimeout → macrotask.
7. Even if setTimeout is 0ms, it waits for microtasks.
8. Event loop checks if the call stack is empty.
9. If empty, it runs all microtasks first.
10. After microtasks finish, it takes one macrotask and runs it.
11. Synchronous code always runs first before async callbacks.
12. `fetch()` resolves as a microtask (Promise).
13. UI rendering happens between macrotasks if microtasks don’t block it.
14. Too many microtasks can freeze UI.
15. `queueMicrotask()` forces high-priority tasks.
16. Understanding this helps debug async code timing.
17. Order example: `start → end → promise → timeout`.
18. Promises never skip the queue—they wait for call stack to clear.
19. Event loop repeats continuously until all work is done.
20. Key takeaway: **Promise callbacks always run before setTimeout callbacks**.
