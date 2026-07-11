# Python 2 (Py2.x) vs Python 3 (Py3.x)

## 1. Summary

- **Python 2** (final stable series: 2.7.x) is legacy and reached official end-of-life on **January 1, 2020**.
- **Python 3** is the actively developed, modern version with improvements in Unicode handling, standard library reorganization, clearer semantics, and many performance and language enhancements.

If we are starting new projects, prefer Python 3. If maintaining legacy Py2 code, plan to port or isolate it (containers/VMs) because Py2 is not receiving security updates.

---

## 2. Key language differences (syntax & semantics)

- **Print**

  - Py2: `print "hello"` (statement)
  - Py3: `print("hello")` (function)

- **Integer division**

  - Py2: `3/2 == 1` (floor for ints)
  - Py3: `3/2 == 1.5`; use `//` for integer (floor) division in both.

- ``\*\* / \*\*``

  - Py2: `range()` returns list, `xrange()` returns iterator-like object.
  - Py3: `range()` behaves like `xrange()` (lazy sequence). `xrange` removed.

- ``\*\* / \*\*``

  - Py2: `raw_input()` returns string; `input()` evaluates input as Python code.
  - Py3: `input()` returns string. `raw_input` removed.

- **Comparisons**

  - Py2 allowed comparisons between unrelated types (sometimes); Py3 is stricter and will often raise `TypeError`.

---

## 3. Strings, bytes, and text handling

- **Text vs bytes** is explicit in Py3:

  - Py3 `str` is Unicode (text). `bytes` is a sequence of raw 8-bit values.
  - Py2 `str` is bytes; `unicode` is text. This ambiguity caused many bugs.

- **Literals**

  - Py2: `'abc'` -> bytes; `u'abc'` -> Unicode (Py2.7 supports `u` literal).
  - Py3: `'abc'` -> Unicode; `b'abc'` -> bytes.

- **Encoding defaults**

  - Py3 uses UTF-8 source encoding by default (PEP 3120/PEP 263 compatibility), making Unicode handling safer.

---

## 4. Standard library changes

- Many modules were renamed, reorganized or moved to more logical packages. Examples:

  - `ConfigParser` → `configparser`
  - `Queue` → `queue`
  - `cStringIO` / `StringIO` → `io` (new I/O stack)
  - `urllib`, `urllib2`, `urlparse` reorganized into `urllib.request`, `urllib.parse`, `urllib.error`.

- Some built-ins removed or changed behavior (e.g., `cmp()` removed).

---

## 5. Iteration, loops and comprehensions

- `dict.iteritems()`, `dict.iterkeys()`, `dict.itervalues()` removed in Py3; use `dict.items()`, `dict.keys()`, `dict.values()` — these return view objects in Py3 (lazy-ish) instead of lists.

- Generator expressions and list comprehensions behave more consistently in Py3 (list comprehension variables don't leak to outer scope as they did in Py2).

---

## 6. Exceptions

- Syntax changed:

  - Py2: `except Exception, e:`
  - Py3: `except Exception as e:`

- `raise` semantics slightly revised; chaining exceptions uses `raise from` in Py3 to preserve context.

---

## 7. I/O and file handling

- Py3’s `open()` returns a text file with `str` by default; use `open(..., 'rb')` to get bytes.
- The `io` module provides a uniform I/O API (binary/text, buffered/unbuffered) and replaces older `file` behavior.

---

## 8. Functions, arguments and annotations

- **Function annotations** were introduced in Py3 (PEP 3107) and are widely used for type hints (with `typing` module added later).
- Keyword-only arguments are supported in Py3 via `*` in function signature.
- `__future__` imports can bring some Py3 behavior into Py2 (e.g., `from __future__ import division, print_function, unicode_literals`) to ease porting.

---

## 9. Classes and object model

- Py3 uses **new-style classes only** (all classes implicitly inherit from `object`).

- Py2 had two kinds of classes: old-style and new-style. Prefer `class MyClass(object):` in Py2 to use new-style behavior.

- **Metaclasses** syntax changed:

  - Py2: `__metaclass__ = Meta` (module-level) or in class body
  - Py3: `class C(metaclass=Meta):`

---

## 10. Concurrency and async

- `async` / `await` keywords added in Py3.5+ (syntax stabilized in later versions). Core async primitives (`asyncio`) were added in Py3.4/3.5 and expanded later.
- Py2 has no built-in `asyncio` and lacks native `async`/`await` syntax.

---

## 11. Tools & migration strategies

- **Tools:**

  - `2to3` — automatic fixer scripts to translate Py2 code to Py3.
  - `futurize` / `pasteurize` (from `python-future`) — help write code that runs on both.
  - `six` — compatibility library that provides shims for runtime compatibility.
  - `modernize` — similar to `futurize` for modern codebases.

- **Strategy options:**

  - **Dual-support**: write code compatible with both Py2 and Py3 (use `six`/`future`, avoid semantics differences). Useful if you must support existing Py2 users.
  - **Port & modernize**: Convert codebase to Py3-only (recommended if possible).
  - **Isolate**: Run legacy code in containers or VMs while new code uses Py3.

---

## 12. Porting checklist (practical)

- Add `from __future__ import print_function, division, unicode_literals` in Py2 during transition.
- Make text vs bytes explicit; audit network I/O, file I/O, subprocess pipes.
- Replace `print` statements with `print()` function calls.
- Replace `xrange` with `range` and remove `long` usages (in Py3 `int` covers all integers).
- Update exception syntax to `except Exception as e:`.
- Replace `dict.iteritems()` → `dict.items()` (and similar for keys/values).
- Fix library imports (urllib, Queue, ConfigParser, etc.).
- Run `2to3` (or `futurize`) and inspect diffs; write tests and run them under Py3.
- Add CI for Py3 and (if necessary) Py2 while porting.

---

## 13. Timeline & support

- Python 2.7 reached end-of-life on **2020-01-01**. No upstream security fixes or improvements since.
- Python 3.x is actively maintained; pick recent stable releases (3.11/3.12 and above) for performance and features.

---

## Example side-by-side snippets

**Print & division**

```py
# Py2
print "sum:", 3/2  # prints: sum: 1

# Py3
print("sum:", 3/2) # prints: sum: 1.5
```

**Unicode / bytes**

```py
# Py2
s = 'abc'        # bytes
u = u'αβγ'       # unicode

# Py3
s = 'αβγ'        # str (unicode)
b = b'abc'       # bytes
```

**Iteration over dict**

```py
# Py2
for k, v in mydict.iteritems():
    pass

# Py3
for k, v in mydict.items():
    pass
```

##
