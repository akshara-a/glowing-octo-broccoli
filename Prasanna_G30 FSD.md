

Core Syntax and Functions:

1.'print' Statement vs. Function:
    Python 2: 
    -'print' is a statement 
    (ex: print "Hello").
    Python 3: 
    -'print' is a required function
    -It must use parentheses. 
    (ex: 'print("Hello")').
     
2.  Integer Division:
    Python 2: Division between two integers performs floor division (rounds down). 
    Ex:'5 / 2' = 2.
    Python 3:
     Division between two integers performs true division (returns a float). 
     Ex:'5 / 2' ='2.5'
      
3. 'input()' Function (User Input):
    Python 2: 
    -'input()' evaluates the user's input as Python code; you need 'raw_input()' to safely get a string.
    Python 3: 
    -'input()' always reads the user's input as a string, which is safer and simpler.
4.  Error Handling (Exceptions):
    Python 2:
    - Exceptions are bound using a ",":
     'except NameError, err:'
    Python 3:
    -Exceptions are bound using the 'as' keyword: 'except NameError as err:'
5.  Raising Exceptions:
    Python 2: 
    -The syntax is 'raise Exception, "message"'
    Python 3: The exception message must be passed as a function argument(in parentheses): 
    'raise Exception("message")'
6.  '!=' vs. '<>' Operator:
    Python 2:
    -Both '!=' and '<>' are valid for the "not-equal-to" operator.
    Python 3:
    - Only '!=' is valid, removing the redundant '<>' operator.


Data Types and Efficiency:

7. Unicode and Strings (The Biggest Change):
    Python 2: 
    -Strings are ASCII by default ('str').
    - To use Unicode, you need a prefix ('u"..."').
    Python 3:
    - Strings are Unicode (UTF-8) by default ('str'), making it natively easy to handle international languages and symbols.
    - Bytes are denoted by a prefix ('b"..."').
8.  'xrange' vs 'range':
    Python 2: 
    -'range()'creates a full list in memory
    -'xrange()' creates an efficient iterate(generator).
    Python 3: 
    -'range()' now works like P2's 'xrange()', creating a memory-efficient iterator(the old 'xrange' is removed).
9.  Iterator vs List Return:
    Python 2: Functions like 'zip()', 'map()', and 'dict.keys()' return full lists.
    Python 3: These functions return iterators or views, saving memory, especially for large datasets.
10. Long Integers:
    Python 2:
    - Has a separate 'long'integer type for very large numbers.
    Python 3: 
    -The standard 'int' type automatically handles integers of any size, removing the need for 'long'.
Language Consistency and Future

11.Library and Community Support:
   Python 2: 
   -Reached End-of-Life (EOL) in  January 2020.
  - It receives no new updates,  security patches, or new major libraries.

  Python 3:
  - Active, supported, and growing. -It is the standard for all new development.
12.Dictionary Iteration Methods:

   Python 2: Has three different methods for dictionary iteration:

   1)dict.keys()---->(returns a list of keys)

   2)dict.viewkeys() ---->(returns a view)

   3)dict.iterkeys() ---->(returns an iterator)

  Python 3:
  - Simplifies this by having only one method: dict.keys(), which returns a view object. 
  -This is more memory-efficient and removes the confusion of three separate methods.

