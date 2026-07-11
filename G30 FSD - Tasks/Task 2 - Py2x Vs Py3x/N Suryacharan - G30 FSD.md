# Python 2.x vs Python 3.x – Complete Comparison

A clear, structured, and developer-friendly comparison between **Python 2.x** and **Python 3.x**, including explanations, examples, and a 10-marks long answer format.  
This README helps beginners and students understand why Python 3 is the standard version used today.

---

## Overview

Python has two major versions:

- **Python 2.x** – Introduced earlier, now outdated and discontinued.
- **Python 3.x** – Modern, powerful, fast, and actively supported.

Python 3 was created to fix the problems and limitations that existed in Python 2.

---

## Table: Python 2.x vs Python 3.x

| Python 2.x | Python 3.x |
|------------|------------|
| `print` is a statement | `print()` is a function |
| `5/2 = 2` (integer division) | `5/2 = 2.5` (true division) |
| Strings are ASCII by default | Strings are Unicode by default |
| Uses `raw_input()` | Uses only `input()` |
| Has `range()` and `xrange()` | Only `range()` (efficient) |
| `except E, e` syntax | `except E as e` syntax |
| Old-style + new-style classes | Only new-style classes |
| No updates after 2020 | Fully supported and updated |

---

#1. Print Statement vs Print Function**
- **Python 2:** `print "Hello"`
- **Python 3:** `print("Hello")`  
Python 3 makes the syntax more consistent and future-proof.

---

#2. Integer Division Behavior**
- Python 2:** `5/2` → `2`  
- Python 3:** `5/2` → `2.5`  
Python 3 performs accurate mathematical division.

---

# 3. Unicode Support**
Python 2 stores strings as ASCII.  
Python 3 stores strings as Unicode by default, supporting all languages smoothly.

---

# 4. Input Handling**
Python 2:
```python
name = raw_input("Enter name: ")
  