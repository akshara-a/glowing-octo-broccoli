# JavaScript Event Loop & Asynchronous Runtime  
**By: Parag Tiwari**

---

## Overview

JavaScript is a **single-threaded programming language**, which means it can execute only one task at a time using a single **Call Stack**.  
Even though it is single-threaded, JavaScript is able to handle asynchronous operations like:

- Network requests  
- Timers  
- User events  
- Browser APIs such as geolocation  

This is possible because of the **JavaScript Runtime Environment** and the **Event Loop**, which together allow non-blocking execution.

The main parts of the JavaScript runtime are:

- Call Stack  
- Web APIs  
- Task Queue  
- Microtask Queue  
- Event Loop  

---

## 1. Call Stack

The **Call Stack** is responsible for executing JavaScript code.  
It follows the **Last In, First Out (LIFO)** principle.

### Example:
```js
console.log(1);
console.log(2);

function printValues() {
  console.log(3);
  console.log(4);
}

printValues();
Explanation:
console.log(1) executes first

console.log(2) executes next

printValues() is pushed to the stack

3 and 4 are printed

The stack becomes empty again

If a heavy or long-running task is executed, the Call Stack gets blocked and the browser UI may freeze.

2. Web APIs
Web APIs are provided by the browser and help JavaScript perform tasks that take time.

Examples of Web APIs:
setTimeout

fetch

Geolocation API

DOM events

Example:
js
Copy code
navigator.geolocation.getCurrentPosition(success, error);
Working:
The function is added to the Call Stack

Browser handles the actual operation

Once completed, the callback is sent to the Task Queue

3. Task Queue (Callback Queue)
The Task Queue stores callback functions from asynchronous operations.

Includes:
setTimeout

setInterval

Event handlers

Web API callbacks

Example:
js
Copy code
setTimeout(() => {
  console.log("Hello");
}, 1000);
The delay time does not mean exact execution time.
The callback executes only when the Call Stack is empty.

4. Microtask Queue
The Microtask Queue has higher priority than the Task Queue.

It contains:
Promise.then()

Promise.catch()

Promise.finally()

async / await

queueMicrotask()

Microtasks are always executed before normal tasks.

5. Event Loop
The Event Loop continuously checks the state of the Call Stack and queues.

Working of Event Loop:
Checks if Call Stack is empty

Executes all microtasks

Executes one task from the Task Queue

Repeats the process

This is how JavaScript manages asynchronous code efficiently.

6. Callback vs Promise Based APIs
Callback-based APIs:
setTimeout

Event listeners

Callbacks go to the Task Queue.

Promise-based APIs:
fetch

Promise.resolve()

.then() callbacks go to the Microtask Queue.

Example:
js
Copy code
fetch(url)
  .then(res => console.log(res));
7. Microtask Queue Issue
If microtasks keep adding more microtasks, normal tasks may never execute.

Example:
js
Copy code
queueMicrotask(() => {
  queueMicrotask(() => {
    queueMicrotask(() => {
      // keeps running
    });
  });
});
This situation can cause performance problems.

8. Output Example
Output:
Copy code
5 1 3 4 2
Reason:
5 is synchronous

1 is from Promise

3 and 4 are microtasks

2 is from setTimeout

Key Points
JavaScript is single-threaded

Web APIs handle background tasks

Microtask Queue has higher priority

Task Queue runs after microtasks

Event Loop controls execution order

Conclusion
The JavaScript Event Loop is an important concept that helps JavaScript run asynchronous code without blocking the browser.
By understanding the Call Stack, Web APIs, Task Queue, and Microtask Queue, we can clearly understand how JavaScript handles execution.

This knowledge helps in writing better code and avoiding issues like UI freezing and unexpected output order.
Overall, the Event Loop plays a major role in making JavaScript suitable for modern web applications.
