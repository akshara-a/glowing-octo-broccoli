task 6

# What I learned in the video

# Introduction:

JavaScript can run only one task at a time because it is single-threaded.

If we write a slow task, the page may stop responding.

To solve this problem, JavaScript uses asynchronous programming.

The feature that helps JavaScript run tasks smoothly is called the Event Loop.


# Call Stack — this is where functions are stacked and executed one by one in Last-In-First-Out order.

# Web APIs & Asynchronous Tasks — when you do something like fetch() or setTimeout(), browser handles them outside main JS thread, so JS doesn’t freeze.

# Event Loop — monitors the call stack and task queues; when stack is empty, it picks the next task to execute (from micro-task or callback queue).

# Microtask Queue vs Macrotask / Callback Queue — some tasks (like Promise resolution) go to micro-tasks (higher priority), others (like callbacks or timers) go to the regular queue.

# Non-blocking Behavior — thanks to this architecture, JS can start a long operation (network request, timer, etc.) and still let UI respond or other code run — no freezing.