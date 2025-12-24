# Python 2.x vs Python 3.x Comparison
---
## Brief comparison
- **Python 3.x is the modern, supported, and recommended version** for all development.
- Python 3 offers:
  - Unicode strings by default
  - Cleaner and more consistent syntax
  - Better memory efficiency with iterators
  - Improved modules and reorganized standard library
  - Enhanced features like type hints and async/await
- Python 2.x:
  - Uses outdated syntax (e.g., print statement, old exception format)
  - Lacks many modern Python features
  - Reached **End of Life on January 1, 2020**
  - No longer receives updates, security patches, or library support
- Use tools like **2to3**, **six**, and **future** to migrate old Python 2 codebases.
- All new tutorials, frameworks, and libraries support **Python 3 only**.

## 1. Print Function

- **Python 2.x:** Print is a statement.
  ```python
  print "Hello, world"
  ```
- **Python 3.x:** Print is a function (requires parentheses).
  ```python
  print("Hello, world")
  ```

## 2. Input Function

- **Python 2.x:**
  - `input()` evaluates input as code.
  - `raw_input()` gets input as string.
- **Python 3.x:** Only `input()` exists; always returns string.

## 3. Division Rules

- **Python 3:**  
  Uses true division by default dividing integers yields a float:
  ```python
  print(3 / 2)  # Output: 1.5
  ```
  Use `//` explicitly for integer (floor) division:
  ```python
  print(3 // 2)  # Output: 1
  ```

## 4. Unicode Handling

- **Python 2.x:**  
  Strings are ASCII by default; Unicode requires a prefix:
  ```python
  "text"      # ASCII string
  u"text"     # Unicode string
  ```
- **Python 3.x:**  
  All strings are Unicode by default:
  ```python
  "text"      # Unicode string
  ```

## 5. Exception Syntax

- **Python 2.x:**
  ```python
  except ValueError, e:
      pass
  ```
  Uses a comma to assign the exception object.

- **Python 3.x:**
  ```python
  except ValueError as e:
      pass
  ```
  Uses `as` for clearer and more consistent exception assignment.

**Difference:**  
Python 2 uses a comma to capture the exception object, while Python 3 uses the `as` keyword for better readability and consistency across different types of exceptions.

## 6. Range vs Xrange

- **Python 2.x:**
  ```python
  range(5)    # returns a list: [0, 1, 2, 3, 4]
  xrange(5)   # returns an iterator (for memory efficiency)
  ```
   `range(5)` creates and stores a list of all values in memory.   
   `xrange(5)` generates values one by one, without storing the full list.

- **Python 3.x:**
  ```python
  range(5)    # returns a lazy iterator (xrange removed)
  ```
   `range(5)` produces an immutable sequence and behaves like Python 2's `xrange`, generating values on the fly for better performance.

## 7. Dictionary Methods

- **Python 2.x:**  
  `dict.items()`, `dict.keys()`, and `dict.values()` return lists.  
  `iteritems()`, `iterkeys()`, and `itervalues()` return iterators.

- **Python 3.x:**  
  `dict.items()`, `dict.keys()`, and `dict.values()` return iterators (views).  
  The `iter*` methods are removed.

*Difference: Python 3's dictionary methods return iterators for better performance and memory efficiency.*

## 8. Standard Library Changes

- Module renaming, relocation, and deprecations are common. For example:
  - `urllib`, `urlparse`, etc., have changed structure.
  - Some modules are removed entirely.

## 9. Syntax Improvements

- **Python 3.x:** 
  - Function annotations (type hints)
  - Keyword-only arguments
  - Async/await syntax
  - More consistent error messages

## 10. Data Type Differences

- **Python 2.x:** `str` is bytes; Unicode is `unicode` type.
- **Python 3.x:** `str` is Unicode; bytes are separate `bytes` type.

## 11. Dictionary Iteration Changes

- **Python 2.x:**
  ```python
  for k, v in mydict.iteritems():
      pass
  ```
- **Python 3.x:**
  ```python
  for k, v in mydict.items():
      pass
  ```
 **Conclusion:**  
If you’re starting new projects, learning Python today, or maintaining code **Python 3 is the only viable choice.**



---
