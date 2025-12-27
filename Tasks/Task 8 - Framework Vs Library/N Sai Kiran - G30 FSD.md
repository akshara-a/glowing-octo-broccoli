# Library

A **library** provides a set of helper functions / objects / modules which your application code calls for specific functionality. Libraries typically focus on a narrow scope (e.g., strings, IO, sockets), so their APIs tend to be smaller and require fewer dependencies.

It is just a collection of class definitions.

## Why do we need libraries?

The reason is very simple: **code reuse**. We use code that has already been written by other developers.

### Example

Suppose a library has a method named `findLastIndex(char)` to find the last index of a particular character in a string. We can directly call the `findLastIndex(charToFind)` function of the library and pass the character whose position we want to find.

---

# Framework

A **framework**, on the other hand, has defined open or unimplemented functions or objects which the user writes to create a custom application (C++/Java users can relate this to implementing abstract functions).

Because a framework is itself an application, it has a wider scope and includes almost everything necessary to make a user application according to specific needs.

---

## Inversion of Control (IoC)

The key difference lies in **Inversion of Control (IoC)**:

* When we call a method from a **library**, **we are in control**.
* In a **framework**, the control is inverted — **the framework calls us**.

A framework defines a skeleton, and the application fills in the required features.

---

## Example: Framework (JavaScript – jQuery)

javascript
$(document).ready(function () {
// This call is made by the jQuery framework
// when the document is ready
});

---

## Example: Library

```javascript
let str = "Geeks.ForGeeks";
let pos = str.lastIndexOf("."); // Calling a function from the string library
````

---

# Important Points

## Library

* Performs a set of **specific and well-defined operations**
* Examples:

  * Network protocols
  * Compression
  * Image manipulation
  * String utilities
  * Regular expression evaluation
  * Mathematical operations

## Framework

* Acts as a **skeleton** where the application defines the content of operations
* Defines the overall structure, while the application provides functionality useful to end-users
* Examples:

  * Web application systems
  * Plug-in managers
  * GUI systems

---

# Difference Between Framework and Library

| S.No | Framework                                                                     | Library                                                                         |
| ---- | ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| 1    | Comprises many APIs, compilers, support programs, libraries, etc.             | Collection of helper modules, classes, objects, functions, and pre-written code |
| 2    | Difficult to replace                                                          | Easy to replace with another library                                            |
| 3    | Requires a lot of code, which may decrease performance and increase load time | Requires less code, resulting in better performance and faster load time        |
| 4    | Difficult to integrate smoothly into an existing project                      | Easily integrated into existing projects for specific functionality             |
| 5    | Examples: AngularJS, Spring, NodeJS                                           | Examples: jQuery, React JS                                                      |

-------------------------------------


# Why Bootstrap Is a Framework

Bootstrap is considered a **framework** rather than just a library because it provides a **complete, structured foundation** for building responsive web applications. It does not only offer reusable code but also defines **how an application should be designed and organized**.

---

## 1. Provides a Complete Structure

Bootstrap offers a predefined structure for:
- Layouts (grid system)
- UI components (buttons, forms, cards, modals)
- Styling rules and utilities

Developers build their application **within this structure**, which is a key characteristic of a framework.

---

## 2. Inversion of Control (IoC)

Bootstrap controls many aspects of the UI behavior and design:
- HTML classes must follow Bootstrap’s conventions
- Components behave according to Bootstrap’s predefined logic

Instead of developers deciding everything, **Bootstrap dictates how components look and behave**, which reflects *Inversion of Control*—a defining feature of frameworks.

---

## 3. Integrated Components and Tools

Bootstrap includes:
- CSS framework
- JavaScript components (dropdowns, modals, tooltips)
- Responsive utilities
- Theme and customization support

These components are designed to work together as a **cohesive system**, not as isolated functions.

---

## 4. Opinionated Design Approach

Bootstrap enforces:
- Consistent UI patterns
- Standard spacing, typography, and colors
- Mobile-first responsive design

This opinionated approach guides developers toward a specific way of building interfaces, which is typical of frameworks.

---

## 5. Application-Level Scope

Bootstrap addresses **application-wide concerns** such as:
- Responsiveness
- Cross-browser compatibility
- Accessibility (ARIA support)

Libraries usually solve a *single problem*, while Bootstrap helps shape the **entire front-end of an application**.

---

## Conclusion

Bootstrap is a **framework** because:
- It provides a complete UI skeleton
- It enforces conventions and structure
- It controls component behavior and layout
- It supports application-level development

> **In short:**  
> You build your UI *inside Bootstrap’s structure*, not just by calling a few helper functions—this is why Bootstrap is a framework.
