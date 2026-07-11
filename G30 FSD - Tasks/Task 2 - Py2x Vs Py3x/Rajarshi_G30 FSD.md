# Python 2.x vs Python 3.x

## 1. Print Statement
- **Python 2.x:** `print "Hello"`
- **Python 3.x:** `print("Hello")`

## 2. Integer Division
- **Python 2.x:** `5/2 = 2`
- **Python 3.x:** `5/2 = 2.5`

## 3. Unicode Support
- **Python 2.x:** Strings are ASCII by default.
- **Python 3.x:** Strings are Unicode by default.

## 4. xrange vs range
- **Python 2.x:** `xrange()` for iteration, `range()` returns a list.
- **Python 3.x:** `range()` behaves like `xrange()` (lazy sequence).

## 5. Error Handling Syntax
- **Python 2.x:** `except Exception, e:`
- **Python 3.x:** `except Exception as e:`

## 6. Input Method
- **Python 2.x:** `raw_input()` reads string, `input()` evaluates.
- **Python 3.x:** `input()` always reads a string.

## 7. Library Support
- **Python 2.x:** No longer supported after 2020.
- **Python 3.x:** Fully supported and updated.

## 8. Iteration Behavior
- **Python 2.x:** `.keys()`, `.values()`, `.items()` return lists.
- **Python 3.x:** They return iterators (memory efficient).

## 9. Unicode Literals
- **Python 2.x:** Need prefix `u"text"` for Unicode.
- **Python 3.x:** Unicode is default.

## 10. Division Behavior
- **Python 2.x:** `/` = integer division when both operands are integers.
- **Python 3.x:** `/` = float division, `//` = integer division.
