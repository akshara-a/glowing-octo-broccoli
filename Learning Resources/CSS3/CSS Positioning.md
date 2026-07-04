# Beginner Guide to CSS Positioning

CSS positioning helps control **where elements appear on a webpage**.

---

## What is Positioning?

Positioning allows you to move and place HTML elements exactly where you want on the screen.

---

## Types of CSS Positioning

### 1. `static` (default)
Elements appear in normal page order.

```css
div {
  position: static; /* default */
}
```

---

### 2. `relative`
Moves an element **slightly** from its normal position.

```css
.box {
  position: relative;
  top: 10px;
  left: 10px;
}
```

- Still takes up space
- Good for small adjustments

---

### 3. `absolute`
Places an element **exactly** where you want it.

```css
.parent {
  position: relative;
}

.child {
  position: absolute;
  top: 0;
  right: 0;
}
```

- Removed from normal document flow
- Positioned relative to the **nearest ancestor with position**

---

### 4. `fixed`
Stays fixed on screen while scrolling.

```css
.button {
  position: fixed;
  bottom: 10px;
  right: 10px;
}
```

- Useful for floating action buttons, sticky menus

---

### 5. `sticky`
Sticks in place **after scrolling to a point**.

```css
header {
  position: sticky;
  top: 0;
}
```

- Great for sticky headers / section titles

---

## Summary Table

| Position | Stays in Page Flow? | Moves Relative To |
|---------|----------------------|-------------------|
| static  | ✅ Yes               | Browser flow      |
| relative | ✅ Yes              | Its original position |
| absolute | ❌ No               | Nearest positioned parent |
| fixed | ❌ No                  | Browser window |
| sticky | ✅ then ❌            | Scroll position |

---

## Real Usage Examples

| Use Case | Position |
|---------|----------|
Sticky navigation | `sticky` / `fixed` |
Tooltips | `absolute` |
Chat / Help popup | `fixed` |
Slight shift in an element | `relative` |

---

## Pro Tip

> Always use `position: relative` on the parent when using `absolute` children.

---


Happy Learning! 
