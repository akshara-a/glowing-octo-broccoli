# Finora — Responsive Financial Landing Page

## 📌 Project Overview

**Finora** is a modern, responsive financial management landing page built using **HTML and Tailwind CSS**.

The project was developed as part of a Tailwind CSS assignment to demonstrate the use of **Tailwind utility classes, responsive design, Flexbox, CSS Grid, hover effects, transitions, dark mode, and interactive JavaScript functionality**.

Finora represents a simple financial management platform that helps users track expenses, manage budgets, and build better financial habits.

---

## 🎯 Objective

The main objective of this project is to practice building a modern responsive website using **Tailwind CSS utility classes** with minimal custom CSS.

The website demonstrates:

* Responsive layouts
* Tailwind CSS utility classes
* Typography and color utilities
* Flexbox and CSS Grid
* Spacing utilities
* Borders and rounded corners
* Shadows
* Hover effects
* Responsive breakpoints
* Dark mode
* Animations and transitions
* Interactive JavaScript functionality

---

## 🛠️ Technologies Used

### Frontend

* HTML5
* Tailwind CSS
* JavaScript

### Tailwind CSS

Tailwind CSS is loaded using the CDN:

```html
<script src="https://cdn.tailwindcss.com"></script>
```

Dark mode is configured using Tailwind's class-based dark mode.

---

## 📂 Project Structure

```text
Finora/
│
├── index.html
├── style.css
├── script.js
├── README.md
│
└── assets/
    └── images/
```

> The `assets` folder can be included if additional images or other assets are used in the project.

---

# 🧩 Website Sections

## 1. Navigation Bar

The navigation bar contains:

* Finora logo
* Home
* Features
* How It Works
* Plans
* Contact
* Responsive mobile navigation
* Theme toggle
* Get Started CTA

The navigation adapts to different screen sizes using Tailwind responsive utilities.

---

## 2. Hero Section

The hero section introduces the Finora platform with:

### Main Heading

**Your money.
Your plan.
Your future.**

### Description

Finora provides a simple way to track expenses, manage budgets, and build better financial habits.

### Call-to-Action

* Get Started
* Explore Features

The hero section uses a responsive two-column layout on larger screens and automatically adapts for smaller devices.

A custom financial dashboard UI is also included to visually represent the Finora product.

---

## 3. Financial Dashboard

The hero section contains a financial dashboard representing the Finora application.

The dashboard demonstrates:

* Total balance
* Monthly growth
* Income
* Expenses
* Savings goal
* Savings progress
* Financial status

The dashboard also includes hover interaction and responsive styling.

---

## 4. Features Section

The Features section contains three feature cards.

### 💰 Smart Budgeting

Create flexible budgets and understand how much you can spend.

### 📊 Expense Tracking

Track your spending and understand where your money goes.

### 🎯 Savings Goals

Set financial goals and monitor your savings progress.

The cards use Tailwind utilities such as:

```text
grid
flex
p-*
m-*
rounded-*
shadow-*
hover:*
transition
```

---

## 5. How Finora Works

A simple three-step process explains how users can manage their finances using Finora.

The section uses a responsive grid layout that changes according to screen size.

---

## 6. Pricing Section

The pricing section contains three pricing plans:

### Starter

**₹0/month**

Includes:

* Expense tracking
* Basic budgeting
* 3 savings goals

### Plus

**₹299/month**

Includes:

* Everything in Starter
* Advanced insights
* Unlimited goals
* Monthly reports

### Pro

**₹599/month**

Includes:

* Everything in Plus
* Smart insights
* Custom budgets
* Priority support

The pricing cards include hover effects and interactive buttons.

---

## 7. Testimonials

A testimonial section is included as a bonus feature.

It contains user feedback demonstrating how Finora can help users develop better financial habits.

The testimonial cards use responsive CSS Grid and Tailwind styling.

---

## 8. Contact Section

The contact section contains a responsive form with:

* Name
* Email
* Message
* Submit button

The form is styled using Tailwind CSS utilities.

JavaScript is used to provide:

* Input validation
* Error states
* Success states
* Form submission feedback

---

## 9. Footer

The footer contains:

* Finora branding
* Product links
* Company links
* Contact link
* Privacy Policy
* Terms
* Social media links
* Copyright information

Example:

```text
© 2026 Finora. All rights reserved.
```

---

# 📱 Responsive Design

The website is designed to work across:


* 💻 Laptops
* 🖥️ Desktop screens

Tailwind responsive prefixes are used to create adaptive layouts.



Responsive layouts are implemented using utilities such as:

```html
grid-cols-1
md:grid-cols-3
lg:grid-cols-2
```

This allows sections and cards to automatically rearrange according to the available screen size.

---

# 🌙 Bonus Features

The project implements several bonus requirements.

## Dark Mode

Finora includes a light/dark theme toggle.

The selected theme is stored using browser `localStorage`, allowing the theme preference to remain available when the page is revisited.

---

## 🎬 Animations and Transitions

The website includes:

* Scroll reveal animations
* Hero background animation
* Card hover animations
* Button hover transitions
* Navigation underline animation
* Theme transition effects
* Savings progress animation

Reduced-motion support is also included for users who prefer reduced animations.

---

## 📱 Mobile Navigation

A mobile navigation menu is implemented using JavaScript.

On smaller screens, the desktop navigation is replaced with a mobile menu button.

The menu can be opened and closed interactively.

---

## 🖱️ Interactive Pricing Cards

Pricing buttons provide interactive feedback.

When a pricing plan is selected:

* The selected card is highlighted
* The selected button changes appearance
* A notification is displayed
* The user receives visual feedback

---

## 🔔 Notification System

A reusable notification system is implemented using JavaScript.

It provides feedback for user actions and includes:

* Notification title
* Notification message
* Confirmation action
* Close button
* Automatic dismissal

---

# 🎨 Tailwind CSS Concepts Demonstrated

This project demonstrates the following Tailwind CSS concepts:

| Concept              | Usage                                |
| -------------------- | ------------------------------------ |
| Typography           | Headings, paragraphs, labels         |
| Colors               | Backgrounds, text and accent colors  |
| Spacing              | Margin and padding utilities         |
| Flexbox              | Navigation, buttons and card content |
| CSS Grid             | Hero, features, pricing and footer   |
| Borders              | Cards, forms and navigation          |
| Rounded corners      | Buttons, cards and UI elements       |
| Shadows              | Dashboard, cards and buttons         |
| Hover states         | Cards, buttons and navigation        |
| Responsive utilities | Mobile, tablet and desktop layouts   |
| Width/Height         | Dashboard and UI components          |
| Dark mode            | Complete light/dark theme            |
| Transitions          | Interactive UI elements              |

---

# ⚡ JavaScript Functionality

JavaScript is used to add interactivity to the website.

Implemented functionality includes:

* Dark mode toggle
* Theme persistence using localStorage
* Mobile navigation
* Scroll reveal
* Active navigation highlighting
* Pricing plan selection
* Notifications
* Get Started interaction
* Contact form validation
* Form success state
* Interactive UI feedback

---


# 📸 Screenshots

Screenshots demonstrating the responsive design should be included with the submission.

Recommended screenshots:

### Desktop View

Show:

* Navigation
* Hero section
* Dashboard
* Features
* Pricing
* Testimonials
* Contact
* Footer

### Mobile View

Show:

* Mobile navigation
* Responsive hero
* Feature cards
* Pricing cards
* Contact form
* Footer



# 📌 Conclusion

Finora demonstrates how **Tailwind CSS utility classes** can be used to build a modern, responsive and interactive landing page with minimal custom CSS.

The project goes beyond the basic assignment requirements by implementing **dark mode, animations, responsive mobile navigation, testimonials, interactive pricing cards, notifications, scroll animations and JavaScript-based form validation**.

The final result is a responsive financial management landing page designed to provide a clean, modern and user-friendly experience.
