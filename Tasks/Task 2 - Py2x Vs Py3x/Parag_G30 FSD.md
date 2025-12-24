# Python 2 vs Python 3


**Python 2 (Py2.x)** and **Python 3 (Py3.x)**

------------------------------------------------------------------------

## 📌 1. Overview

-   **Python 2** is legacy and reached end‑of‑life on **January 1,
    2020**.
-   **Python 3** is the modern, actively developed version with major
    improvements in:
    -   Unicode
    -   Code clarity
    -   Performance
    -   Standard library structure

------------------------------------------------------------------------

## 🧩 2. Key Syntax Differences

### ▶ Print

-   Py2: `print "hello"`
-   Py3: `print("hello")`

### ▶ Integer Division

-   Py2: `3/2 → 1`
-   Py3: `3/2 → 1.5` (true division)

### ▶ Ranges

-   Py2: `range()` → list, `xrange()` → iterator
-   Py3: `range()` → iterator-like (xrange removed)

### ▶ Input

-   Py2: `raw_input()`
-   Py3: `input()`

------------------------------------------------------------------------

## 🔤 3. Strings & Unicode

  Python 2             Python 3
  -------------------- -------------------
  'abc' → bytes      `'abc'` → Unicode
  `u'abc'` → Unicode   `b'abc'` → bytes

Python 3 separates **text** (`str`) and **bytes** (`bytes`) cleanly,
eliminating many encoding bugs.

------------------------------------------------------------------------

## 📚 4. Standard Library Changes

Examples: - `ConfigParser` → `configparser` - `Queue` → `queue` -
`StringIO` → `io` - `urllib`, `urllib2` reorganized into
`urllib.request`, `urllib.parse`, etc.

------------------------------------------------------------------------

## 🔁 5. Dict Iteration

-   Py2: `dict.iteritems()`
-   Py3: `dict.items()` (returns a view)

------------------------------------------------------------------------

## ⚠ 6. Exception Syntax

-   Py2: `except Exception, e:`
-   Py3: `except Exception as e:`

------------------------------------------------------------------------

## 📄 7. File Handling

-   Py3 `open()` returns text mode by default.
-   Use `"rb"` for binary files.

------------------------------------------------------------------------

## 🚀 8. New Features in Python 3

-   `async` / `await`
-   `typing` (type hints)
-   Better generators, comprehensions
-   Faster runtime

------------------------------------------------------------------------

## 🛠 9. Migration Tools

-   `2to3`

-   `python-modernize`

-   `future` / `six`

-   Add Py3 features to Py2 using:

     python
    from __future__ import print_function, division, unicode_literals
    

------------------------------------------------------------------------

## ✔ 10. Migration Checklist

-   Replace print statements with `print()`.
-   Replace `xrange()` with `range()`.
-   Fix text/bytes (`str` vs `bytes`).
-   Update exception syntax.
-   Update imports (`urllib`, `queue`, etc.).
-   Run automatic fixers + manual cleanup.

------------------------------------------------------------------------

## 📝 Example Side-by-Side Code

### Print & Division

python
# Python 2
print "sum:", 3/2

# Python 3
print("sum:", 3/2)


### Unicode

python
# Python 3
s = "αβγ"
b = b"abc"

------------------------------------------------------------------------

## 🎯 Conclusion

Python 3 is the recommended version for all modern development.
Python 2 should only be used for maintaining legacy systems.

------------------------------------------------------------------------

