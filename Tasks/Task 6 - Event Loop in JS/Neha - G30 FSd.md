1) JS has one call stack. Functions go on, run, come off. console.log(1) then 2. Prints 1 then 2. But big loops block everything till done. Page freezes.

2) Browser has Web APIs - timers, fetch, location stuff. Call setTimeout? JS hands it off to browser, keeps going. Browser runs timer in back, no freeze.

3) Task queue: Normal line for setTimeout, clicks. Waits till microtasks done.

4) Microtask queue: Fast pass for promises (.then), await, queueMicrotask. All these run first.

5) Loop checks: stack empty? Do every microtask. Then one task. Repeat. Promises win over timers always.

Example: 
Promise.resolve().then(() => console.log(1));
setTimeout(() => console.log(2), 0);
queueMicrotask(() => console.log(3));
console.log(5);

Prints: 5, 1, 3, 2
