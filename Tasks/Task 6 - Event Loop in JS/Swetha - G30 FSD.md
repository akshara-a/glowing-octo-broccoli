JavaScript Event Loop :

JavaScript can do only one thing at a time.
But websites need to do many things — like waiting for network data, waiting for a timer, reacting to a button click.

To make this work without stopping the page, JavaScript uses:

1)Call Stack

2)Web APIs

3)Task Queue

4)Microtask Queue

5)Event Loop

Lets see one by one :

1)Call Stack
→ Code that is running right now.


2)Web APIs
→ Browser handles things like timers, fetch, clicks.


3)Task Queue (Macrotask)
→ Callbacks from setTimeout, setInterval, events.


4)Microtask Queue
→ Promise .then(), async/await tasks.
→ Runs BEFORE task queue.


5)Event Loop
→ Keeps checking if call stack is empty.
→ If empty, it runs microtasks first, then tasks.



Lets see examples : 
Example 1 

console.log("Start");
setTimeout(() => console.log("Timeout"), 0);
console.log("End");

Output for this code would be :

Start
End
Timeout


Example 2 

console.log("Start");
Promise.resolve().then(() => console.log("Promise"));
console.log("End");

Output for this code would be :

Start
End
Promise


This is all about JavaScript Event Loop.