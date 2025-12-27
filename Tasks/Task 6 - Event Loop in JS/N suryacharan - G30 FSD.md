Learning Document – JavaScript Event Loop & Task Queues

Name: N.suryacharan
Date: 09-12-2025
Task: Understanding the Event Loop from the assigned YouTube video

What I Learned

Today, I watched a video about how JavaScript handles asynchronous code using the Event Loop, Web APIs, Task Queue, and Microtask Queue.
Before this, I only knew that JavaScript runs code line by line, but I didn’t clearly understand how setTimeout() and Promise behave differently.
After watching the video, I now have a clearer idea of how JavaScript executes tasks in the background.

Call Stack

The call stack is where JavaScript executes normal (synchronous) code.
It follows LIFO (Last In, First Out).
Only one task runs at a time because JavaScript is single-threaded.

Example:

console.log("Start");
function test() {
  console.log("Inside function");
}
test();
console.log("End");


The output follows the exact order of the functions being stacked and removed.

Web APIs

Web APIs are features provided by the browser, not JavaScript itself.
These are used to handle asynchronous tasks without blocking the main thread.

Some examples:

setTimeout()

fetch()

Event listeners

setInterval()

These tasks run separately and return the result later.

Task Queue (Macrotask Queue)

When the Web APIs finish, some callbacks are placed into the Task Queue.
These tasks wait there until the call stack becomes empty.

Examples:

setTimeout

setInterval

DOM events

Microtask Queue

This queue has higher priority than the task queue.
Before JavaScript runs any macrotask, it will run all microtasks first.

Examples:

Promises (then, catch)

queueMicrotask()

This is why promise callbacks run faster than setTimeout().

How It All Works (Flow)

The Event Loop continuously checks:

Is the call stack empty?

If yes → execute all microtasks.

After microtasks → execute one macrotask.

Repeat.

Example That Helped Me Understand
console.log("1");

setTimeout(() => {
  console.log("2");
}, 0);

Promise.resolve().then(() => console.log("3"));

console.log("4");


Output:

1
4
3
2


At first, I expected 2 before 3, but now I understand:

console.log() runs first.

Promise runs earlier because microtasks have higher priority.

setTimeout runs last because it goes to the task queue.

Key Points I Understood

JavaScript is single-threaded and uses the event loop for async tasks.

Microtasks (Promises) run before macrotasks.

Web APIs help JavaScript handle async operations without blocking execution.

The event loop decides what runs next based on queues.

Final Reflection

This video helped me clearly understand why Promises run before setTimeout() and how the browser works behind the scenes while executing JavaScript code. Now I have a much better understanding of asynchronous behavior in JavaScript.