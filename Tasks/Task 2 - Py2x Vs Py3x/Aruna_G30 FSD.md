# Python 2 vs Python 3 — Comparison Notes

1. Print Function
```python
# Python 2
print "Hello World"

# Python 3
print("Hello World")
==>In Python 2, print works as a statement.Python 3 makes it a function, which allows better formatting and consistency.

2. Division Rules
# Python 2
5 / 2      # 2 (integer division)

# Python 3
5 / 2      # 2.5 (true division)
5 // 2     # 2 (floor division)
==>Python 3 uses true division by default unless // is used.

3. Unicode Handling
# Python 2
"text"     # ASCII
u"text"    # Unicode

# Python 3
"text"     # Unicode by default
==>Python 3 treats all strings as Unicode automatically.

4. Range vs Xrange
# Python 2
range(5)    # returns list
xrange(5)   # returns iterator

# Python 3
range(5)    # efficient iterator (xrange removed)
==>Python 3 removes xrange() and optimizes range().

5. Input Function
# Python 2
raw_input()   # returns string
input()       # evaluates input

# Python 3
input()       # always returns string
==>Python 3 keeps only the safer input() function.

6. Exception Syntax
# Python 2
except ValueError, e:

# Python 3
except ValueError as e:
==>Python 3 enforces a more readable exception syntax.

7. Dictionary Methods
  Method	    Python 2	Python 3
dict.keys()	      list	      view
dict.values()	  list	      view
dict.items()	  list	      view
==>Python 3 uses dynamic and memory-efficient dictionary views.

8. Standard Library Changes
==>Python 3 reorganized various modules (e.g., urllib, queue) for better structure and naming clarity.

9. End-of-Life Status
==>Python 2 was officially discontinued in January 2020. Python 3 is fully supported and recommended for all new projects.