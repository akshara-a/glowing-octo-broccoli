# Differences Between Python 2.x and Python 3.x

## 1. Print Statement

-   **Python 2.x:** `print "Hello"`
-   **Python 3.x:** `print("Hello")` (print is a function)

## 2. Integer Division

-   **Python 2.x:** `5 / 2` → `2` (floor division)
-   **Python 3.x:** `5 / 2` → `2.5` (true division)

## 3. Unicode Support

-   **Python 2.x:** Default is ASCII, unicode requires `u"text"`
-   **Python 3.x:** Strings are Unicode by default

## 4. xrange() vs range()

-   **Python 2.x:** `range()` returns list, `xrange()` returns generator
-   **Python 3.x:** `range()` behaves like `xrange()`, `xrange()`
    removed

## 5. Input Function

-   **Python 2.x:** `input()` evaluates, `raw_input()` returns string
-   **Python 3.x:** `input()` always returns string

## 6. Error Handling Syntax

-   **Python 2.x:** `except Exception, e:`
-   **Python 3.x:** `except Exception as e:`

## 7. Standard Library Changes

| **Python 2.x** | **Python 3.x**     |
|----------------|--------------------|
| urllib2        | urllib.request     |
| configParser   | configparser       |
| Tkinter        | tkinter            |

## 8. Iteration Improvements

-   **Python 2.x:** `dict.items()` returns list
-   **Python 3.x:** `dict.items()` returns iterator

## 9. Raising Exceptions

-   **Python 2.x:** `raise "Error"`
-   **Python 3.x:** `raise Exception("Error")`

## 10. End of Life

-   **Python 2.x:** EOL (Jan 1, 2020)
-   **Python 3.x:** Actively supported
