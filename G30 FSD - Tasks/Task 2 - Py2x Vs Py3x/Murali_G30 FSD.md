

----------

```markdown
# Python 2 vs Python 3 — Major Differences (With Examples)

Python 3 is the present and future of Python, while Python 2 reached its end of life on January 1, 2020.  
This document explains the key differences with clear explanations and examples.

---

## 1. Print Statement vs Print Function

### Python 2
```python
print "Hello World"

```

### Python 3

```python
print("Hello World")

```

### Explanation

-   Python 2 uses `print` as a **statement**.
    
-   Python 3 uses `print()` as a **function**, improving consistency.
    

----------

## 2. Integer Division

### Python 2

```python
print(5 / 2)   # Output: 2

```

### Python 3

```python
print(5 / 2)   # Output: 2.5

```

### Explanation

-   Python 2 performs **floor division** when dividing integers.
    
-   Python 3 performs **true division**.
    

To get Python 3 behavior in Python 2:

```python
from __future__ import division

```

----------

## 3. Unicode and String Handling

### Python 2

```python
s = "hello"       # ASCII
u = u"hello"      # Unicode

```

### Python 3

```python
s = "hello"       # Unicode by default

```

### Explanation

-   Python 3 makes Unicode the default, improving text and international support.
    

----------

## 4. xrange() vs range()

### Python 2

```python
for i in xrange(5):
    print(i)

```

### Python 3

```python
for i in range(5):
    print(i)

```

### Explanation

-   `xrange()` (lazy iterator) was removed.
    
-   `range()` in Python 3 behaves like `xrange()` — memory efficient.
    

----------

## 5. Exception Handling Syntax

### Python 2

```python
try:
    1 / 0
except ZeroDivisionError, e:
    print e

```

### Python 3

```python
try:
    1 / 0
except ZeroDivisionError as e:
    print(e)

```

### Explanation

-   Python 3 requires the `as` keyword for exception binding.
    

----------

## 6. User Input

### Python 2

```python
name = raw_input("Enter name: ")

```

### Python 3

```python
name = input("Enter name: ")

```

### Explanation

-   `raw_input()` was renamed to `input()` in Python 3.
    
-   Python 2’s `input()` was unsafe and removed.
    

----------

## 7. Iteration Changes (dict, zip, map)

### Python 2

```python
d = {"a": 1, "b": 2}
print(d.keys())   # returns a list

```

### Python 3

```python
d = {"a": 1, "b": 2}
print(d.keys())   # returns a view object (dynamic iterator)

```

### More Examples

Python 2:

```python
map(lambda x: x*x, [1,2,3])   # returns list

```

Python 3:

```python
map(lambda x: x*x, [1,2,3])   # returns iterator

```

### Explanation

-   Python 3 replaced many list-returning functions with memory-efficient iterators.
    

----------

## 8. Using **future** for Compatibility

```python
from __future__ import print_function, unicode_literals

```

Allows writing code that works in both Python 2 and Python 3.

----------

## 9. Library Support Differences

### Python 2

-   No longer supported by most libraries.
    
-   Officially deprecated.
    

### Python 3

-   Actively supported and improved.
    

----------

## 10. Syntax & Feature Improvements

### Type Hints (Python 3 only)

```python
def add(a: int, b: int) -> int:
    return a + b

```

### F-strings (Python 3.6+)

```python
name = "Sam"
print(f"Hello {name}")

```

### Explanation

-   Python 3 adds modern features improving readability and performance.
    

----------

```
