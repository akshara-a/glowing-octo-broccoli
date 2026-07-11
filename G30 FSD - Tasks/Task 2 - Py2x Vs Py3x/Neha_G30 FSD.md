1. Support & Compatibility
  Python 2: Officially discontinued as of January 2020.
  Python 3: Actively supported, recommended for all new projects.

2. User Input
  Python 3 removes the unsafe input behavior found in Python 2.

  Python 2
    raw_input()     # returns string
    input()         # executes input as code
  
  Python 3
    input()         # always returns a string

3. Integer Division
  Division produces different results depending on the version.
  
  Python 2
  15 / 6      # 2
  
  Python 3
  15 / 6      # 2.5
  15 // 6     # 2

4. Iterables & Range
  Python 3 merges and optimizes iteration behavior.
  
  Python 2
    range(5)      # list
    xrange(5)     # efficient iterator
  
  Python 3
    range(5)      # efficient iterator (xrange removed)

5. Print Usage
  Print is upgraded from a statement to a function.
  
  Python 2
    print "Machine Learning"
  
  Python 3
    print("Machine Learning")

6. String Encoding
  Unicode becomes the standard in Python 3.
  
  Python 2
    "hello"       # ASCII
    u"hello"      # Unicode
  
  Python 3
    "hello"       # Unicode by default

7. Dictionary Output Types

Method	Python 2 Output	        Python 3 Output
keys()	   list	               dict_keys (view)
items()	   list	               dict_items (view)
values()	 list	               dict_values (view)

8. Exception Structure
  Python 3 switches to a clearer exception syntax.
  
  Python 2
    except ZeroDivisionError, e:
  
  Python 3
    except ZeroDivisionError as e:

9. Standard Library Changes
  Python 3 reorganized modules for better structure.
  
  Examples:
    Queue → queue
    ConfigParser → configparser
    urllib2 split into multiple submodules

10. Additional Improvements in Python 3

  a. Optional Type Hints
    def greet(name: str) -> str:
        return "Hello " + name
  
  b. Iterator-Based Functions
    zip(), map(), and filter() return iterators, not lists.
  
  c. Strict Import Rules
    Python 3 removes implicit relative imports to avoid ambiguity.
