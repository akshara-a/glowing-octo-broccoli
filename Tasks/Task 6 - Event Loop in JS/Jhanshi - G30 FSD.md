INTRODUCTION:

 I clearly understood how JavaScript handles asynchronous tasks even though it is single-threaded.
JavaScript can normally execute only one task at a time, but still it manages timers, API calls, promises, animations, events, etc. without blocking the main program.

The video explained this using 4 main concepts:

Call Stack
Web APIs
Task Queue
Microtask Queue & Event Loop

1) Call Stack:

The Call Stack is the place where JavaScript runs code line by line.
I understood it like this:
When we call a function, it is pushed onto the call stack.
When the function finishes, it is popped off the stack.
Only one function can run at a time because JavaScript is single-threaded.

 Asynchronous Tasks Are Needed: 

If JavaScript works only with the call stack, then:
a slow network request
or a long timer
or a heavy calculation
will block everything, and the webpage will become unresponsive.

The video explained that this is why browsers provide Web APIs to help JavaScript.

2) Web APIs:

Web APIs do the long tasks outside JavaScript.

Examples:
setTimeout
fetch / API calls
DOM events like click, scroll, keyup

My understanding of the process:

JavaScript calls setTimeout
Browser Web API takes responsibility and handles the timer
After time completes, callback is sent to a queue
JavaScript will run the callback only when the call stack becomes empty
So JavaScript does not actually wait.
It continues other work while the Web API is doing its job.

3) Task Queue :

After a Web API finishes, the callback function does not run immediately.
Instead, it goes into the Task Queue (also called Macro-task Queue).

Examples of tasks entering this queue:

setTimeout callback
setInterval callback
click events
API response handlers

The Event Loop checks:

If the Call Stack is empty
Then takes the first task from the Task Queue and pushes it to the Call Stack
Only then the callback runs.

setTimeout

The video explained that setTimeout(fn, 0) does not run immediately.

Reason:

Even with 0ms, the callback must wait in the task queue
It can run only after the call stack is empty
And after all microtasks are completed

4) Microtask Queue :

This was an important part of the video.

Promises and queueMicrotask do not go into the normal task queue.
They go into the Microtask Queue
 Microtasks always run before normal tasks.

So if both are waiting:

First, all microtasks execute

Then macro-tasks

5) Event Loop :

The Event Loop is the controller that keeps checking:

Is the Call Stack empty?
Are there Microtasks waiting?
If yes → execute all microtasks first
Then take the next task from the Task Queue
Push it onto the Call Stack
Repeat forever
This cycle is what gives JavaScript asynchronous power even though it is single-threaded.

Promisifying Callbacks :

The video explained how earlier callback-based asynchronous code can be converted into Promises.

Promisifying means wrapping a callback-based API inside a Promise.


