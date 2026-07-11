Topic: JavaScript Event Loop
Video: JavaScript Visualized – Event Loop, Web APIs, Microtask Queue
1. What is the Event Loop?
JavaScript can only do one thing at a time (single-thread).
But we still need it to wait for things like:
timers
button clicks
API responses
The event loop is a system that helps JavaScript handle these tasks without stopping the whole program.

2. Important Parts
A. Call Stack
This is where normal code runs.
JavaScript reads one line at a time and executes it.
B. Web APIs (Browser Help)
The browser provides extra features that run in the background, like:
setTimeout (timers)
fetch (internet requests)
event listeners (click, scroll)
These do their work separately and report back when finished.
C. Task Queue (Macrotask Queue)
When background tasks finish, they send their result here.
Example: setTimeout callback goes into this queue.
D. Microtask Queue
This is a faster, more important queue.
It stores promise-related tasks.
Example:
Promise.then()
Microtasks run before normal tasks.

3. How the Event Loop Works (Very Simple)
JavaScript first runs all normal code.
Then it checks the microtask queue (Promises).
After microtasks are done, it runs one task from the task queue.
It keeps repeating this cycle.

4. Why Promises Run First
Even if you write:
a setTimeout with 0ms delay
a Promise
The Promise will run first because microtasks have higher priority.

5. What Happens If Code is Too Heavy?
If JavaScript runs a big loop or heavy work:
The event loop cannot continue
Timers and events wait
The page may freeze
So heavy tasks should be avoided or broken into smaller parts.

6. Main Points to Remember:
JavaScript does one thing at a time.
Browser helps with background tasks.
Promises run before timers.
The event loop decides what runs next.
Heavy code can slow down or block everything.

7. Conclusion:
The event loop helps JavaScript stay fast and responsive.
It makes sure tasks run in the correct order, even though only one thing runs at a time.
This is why websites don’t freeze when waiting for timers or server responses.
