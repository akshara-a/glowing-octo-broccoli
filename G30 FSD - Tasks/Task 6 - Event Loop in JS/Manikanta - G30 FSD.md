# JavaScript Event Loop and Execution Model

## 1. Introduction

JavaScript is **single-threaded**, meaning it executes one task at a
time.\
But it can still handle asynchronous operations (like setTimeout, API
calls).\
This is possible because of the **Event Loop**.

------------------------------------------------------------------------

## 2. Key Components

### **1. Call Stack**

-   Stores functions to be executed.
-   Works on **LIFO** (Last In First Out).

**Example:**

``` javascript
function a() {
  console.log("A");
}
function b() {
  a();
  console.log("B");
}
b();
```

**Execution Order:** 1. `b()` pushed → executed\
2. `a()` pushed → executed\
3. `console.log("A")`\
4. `console.log("B")`

------------------------------------------------------------------------

### **2. Web APIs**

These are provided by browsers (not JavaScript engine): - setTimeout\
- DOM events\
- fetch API\
- Event listeners

------------------------------------------------------------------------

### **3. Callback Queue / Task Queue**

Stores callbacks from Web APIs when they finish.

Examples: - setTimeout callbacks\
- click events\
- API response callback

------------------------------------------------------------------------

### **4. Microtask Queue**

Contains: - Promises (`.then`)\
- Mutation observers

**Microtasks run BEFORE callback queue tasks.**

------------------------------------------------------------------------

## 3. Event Loop

The Event Loop continuously checks:

1.  **Is Call Stack empty?**\
2.  **Are Microtasks present?** → Run them first\
3.  **Then run tasks from Callback Queue**

------------------------------------------------------------------------

## 4. Simple Example Showing Event Loop Behavior

``` javascript
console.log("Start");

setTimeout(() => {
  console.log("Timeout");
}, 0);

Promise.resolve().then(() => {
  console.log("Promise");
});

console.log("End");
```

### **Output:**

    Start
    End
    Promise
    Timeout

### **Why?**

-   `Start` + `End` → synchronous → run first\
-   Promise → microtask → runs next\
-   Timeout → callback queue → runs last

------------------------------------------------------------------------

## 5. Visual Diagram (Simple)

            ┌───────────────┐
            │   Call Stack  │
            └──────┬────────┘
                   │
           Event Loop Checks
                   │
     ┌─────────────┴─────────────┐
     │      Microtask Queue       │
     └─────────────┬─────────────┘
                   │
          Callback (Task) Queue

------------------------------------------------------------------------

## 6. Summary

-   JavaScript runs one task at a time (single-threaded).
-   Web APIs handle async operations.
-   Microtasks run before normal tasks.
-   Event Loop manages execution flow efficiently.

------------------------------------------------------------------------

## 7. Final Example (Async + Promise)

``` javascript
async function test() {
  console.log("1");
  await Promise.resolve();
  console.log("2");
}
test();
console.log("3");
```

### Output:

    1
    3
    2

------------------------------------------------------------------------

**This is a simple and exam‑friendly explanation of JavaScript Event
Loop.**
