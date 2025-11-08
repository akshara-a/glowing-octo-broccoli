# CSS Specificity Explained

CSS **specificity** determines which styles are applied when multiple CSS rules target the same element.  
It acts like a scoring system, the rule with the **highest weight** wins.

---

## Specificity Formula (Official W3C)

Specificity is represented as a **3-part value:** 
(a, b, c)


| Part | Represents | Example | Weight |
|------|-------------|----------|---------|
| **a** | Inline styles (via the `style` attribute) | `<div style="color:red">` | (1, 0, 0) |
| **b** | Number of **ID selectors** | `#header` | (0, 1, 0) |
| **c** | Number of **class selectors**, **attributes**, **pseudo-classes**, **elements**, and **pseudo-elements** | `.nav`, `[type="text"]`, `:hover`, `div`, `::before` | (0, 0, 1) |

---

## Specificity Weights

| Selector Type | Example | Specificity |
|----------------|----------|--------------|
| **Inline style** | `<p style="color:red;">` | (1, 0, 0) |
| **ID selector** | `#main` | (0, 1, 0) |
| **Class selector** | `.container` | (0, 0, 1) |
| **Attribute selector** | `[type="text"]` | (0, 0, 1) |
| **Pseudo-class** | `:hover`, `:nth-child(2)` | (0, 0, 1) |
| **Element selector** | `div`, `p`, `h1` | (0, 0, 1) |
| **Pseudo-element** | `::before`, `::after` | (0, 0, 1) |

---

### Example
#header .nav li { color: blue; } 
Inline = 0
ID selectors = 1 → (0, 1, 0)
Class selectors = 1
Element selectors = 1
Total: (0, 1, 2)

## Important Rules
Order of comparison: Specificity is compared from left to right → a → b → c.  
Higher number wins: (0, 1, 0) beats (0, 0, 10) because an ID selector is stronger than multiple classes.     
If specificity is equal: The later rule in the CSS file takes precedence.   
The !important rule: Overrides all specificity calculations. Should be used sparingly — it makes debugging harder. Inline styles with !important are the most powerful.
