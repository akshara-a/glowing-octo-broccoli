# CSS Font-Family Tri‑List (Quick Stacks)

A compact set of **three‑font fallback stacks** you can paste into your CSS. Each stack lists: **Preferred → Common fallback → Generic family**.

---

## Sans‑Serif
```css
/* System UI (fastest) */
font-family: system-ui, -apple-system, Segoe UI;

/* Modern humanist */
font-family: "Inter", "Segoe UI", Arial;

/* Neo-grotesque */
font-family: "Helvetica Neue", Helvetica, Arial;

/* Google-friendly */
font-family: Roboto, Arial, sans-serif;

/* Friendly rounded */
font-family: "SF Pro Rounded", "Nunito", sans-serif;
```

## Serif
```css
/* Classic bookish */
font-family: Georgia, "Times New Roman", serif;

/* Transitional */
font-family: "Times New Roman", Times, serif;

/* Modern serif */
font-family: "Merriweather", Georgia, serif;
```

## Monospace
```css
/* System monospace */
font-family: ui-monospace, "SFMono-Regular", Menlo;

/* Cross‑platform dev */
font-family: "Fira Code", "Source Code Pro", monospace;

/* Windows‑friendly */
font-family: Consolas, "Courier New", monospace;
```

## Display / Branding
```css
/* Geometric display */
font-family: "Poppins", "Avenir Next", sans-serif;

/* Editorial display serif */
font-family: "Playfair Display", "Times New Roman", serif;

/* Condensed headline */
font-family: "Oswald", "Helvetica Neue", Arial;
```

---

## Drop‑in Utilities (CSS Custom Properties)
```css
:root{
  --ff-sans: system-ui, -apple-system, "Segoe UI";
  --ff-serif: Georgia, "Times New Roman", serif;
  --ff-mono: ui-monospace, "SFMono-Regular", Menlo;
}

.sans { font-family: var(--ff-sans); }
.serif { font-family: var(--ff-serif); }
.mono { font-family: var(--ff-mono); }
```

## SCSS Mixins
```scss
@mixin ff-sans   { font-family: system-ui, -apple-system, "Segoe UI"; }
@mixin ff-serif  { font-family: Georgia, "Times New Roman", serif; }
@mixin ff-mono   { font-family: ui-monospace, "SFMono-Regular", Menlo; }
```

## @font-face + Fallback (pattern)
```css
/* Self-hosted example (WOFF2 first) */
@font-face{
  font-family: "Acme Sans";
  src: url("/fonts/acme-sans.woff2") format("woff2"),
       url("/fonts/acme-sans.woff") format("woff");
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

/* Use custom → safe fallback → generic */
.title {
  font-family: "Acme Sans", "Segoe UI", Arial, sans-serif;
}
```

---

## Notes & Best Practices
- **3 items only** keeps rendering predictable and fast.
- Put **web fonts first**, then **safe system fonts**, then **generic family** (`serif`, `sans-serif`, `monospace`).
- Prefer **`font-display: swap`** for @font-face to avoid invisible text.
- Case‑sensitive names go in **quotes** (e.g., `"Helvetica Neue"`), generic families don’t.
- Consider **language needs** (e.g., Noto family) if you support multi‑script content.

---

### Copy‑ready Snippets

**Minimal tri‑list presets**
```css
/* Sans */
font-family: system-ui, -apple-system, "Segoe UI";

/* Serif */
font-family: Georgia, "Times New Roman", serif;

/* Mono */
font-family: ui-monospace, "SFMono-Regular", Menlo;
```

**Utility classes**
```css
.ff-sans { font-family: system-ui, -apple-system, "Segoe UI"; }
.ff-serif { font-family: Georgia, "Times New Roman", serif; }
.ff-mono { font-family: ui-monospace, "SFMono-Regular", Menlo; }
```
