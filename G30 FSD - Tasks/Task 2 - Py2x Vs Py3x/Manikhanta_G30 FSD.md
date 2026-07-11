# Python 2.x vs Python 3.x --- Complete Markdown Notes

## **1. Print Statement**

### Python 2

``` python
print "Hello World"
```

### Python 3

``` python
print("Hello World")
```

------------------------------------------------------------------------

## **2. Division Difference**

### Python 2

``` python
5 / 2   # Output: 2  (integer division)
```

### Python 3

``` python
5 / 2   # Output: 2.5  (true division)
5 // 2  # Output: 2    (floor division)
```

------------------------------------------------------------------------

## **3. Unicode Handling**

-   **Python 2:** ASCII by default

    ``` python
    u"hello"   # Unicode
    ```

-   **Python 3:** All strings are Unicode by default

    ``` python
    "hello"
    ```

------------------------------------------------------------------------

## **4. range() vs xrange()**

### Python 2

-   `range()` → list\
-   `xrange()` → iterator (memory efficient)

### Python 3

-   `range()` behaves like `xrange()` → iterator

------------------------------------------------------------------------

## **5. Input Function**

### Python 2

-   `raw_input()` → returns string\
-   `input()` → evaluates input (unsafe)

### Python 3

-   `input()` → always returns string

------------------------------------------------------------------------

## **6. Exception Syntax**

### Python 2

``` python
except ValueError, e:
```

### Python 3

``` python
except ValueError as e:
```

------------------------------------------------------------------------

## **7. Dictionary Methods**

  Method            Python 2 Output   Python 3 Output
  ----------------- ----------------- -----------------
  `dict.keys()`     list              view object
  `dict.values()`   list              view object
  `dict.items()`    list              view object

------------------------------------------------------------------------

## **8. Standard Library Changes**

-   Many modules renamed/improved in Python 3\
    Example:
    -   `urllib2` (Python 2) → `urllib.request` (Python 3)

------------------------------------------------------------------------

## **9. EOL (End of Life)**

-   **Python 2:** Officially ended January 2020 (no support)
-   **Python 3:** Fully supported and recommended for all development

------------------------------------------------------------------------

## **Summary**

  Feature      Python 2.x           Python 3.x
  ------------ -------------------- -----------------
  Print        Statement            Function
  Division     Integer by default   True division
  Strings      ASCII default        Unicode default
  range        List                 Iterator
  Input        raw_input/input      input only
  Exceptions   `except E, e`        `except E as e`
  Support      Ended                Active

------------------------------------------------------------------------
