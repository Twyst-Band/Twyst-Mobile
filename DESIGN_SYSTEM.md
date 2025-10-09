# Twyst Design System

## Overview
Twyst follows a clean, modern design language inspired by Duolingo's gamification approach. The design emphasizes clarity, consistency, and engagement through bold colors, clear typography, and consistent spacing.

**Platform**: Web (HTML/CSS/React)

---

## Color Palette

### Primary Colors
- **Light Blue** - `#4A90E2` - Primary brand color
  - **CSS Variable**: `--color-primary`
  - Used for: Primary actions, active states, links, highlights
  - Example: Primary buttons, skill tree nodes, progress indicators

- **Dark Blue** - `#2C5AA0` - Secondary brand color
  - **CSS Variable**: `--color-primary-dark`
  - Used for: Headers, important text, emphasis
  
- **Gold Yellow** - `#FFD700` - Accent/Achievement color
  - **CSS Variable**: `--color-accent`
  - Used for: Achievements, XP, rewards, challenges, special highlights
  - Example: Challenge badges, streak indicators, premium features

### Semantic Colors
- **Custom Red** - `#FF3B30` - Destructive/Warning
  - **CSS Variable**: `--color-danger`
  - Used for: Delete actions, warnings, errors, heart rate indicators
  - Example: "Log Out", "Delete Account", "Delete Profile" buttons

- **Green** - `#34C759` - Success/Completion
  - **CSS Variable**: `--color-success`
  - Used for: Completed items, success states, checkmarks
  - Example: Completed skill nodes, verified states

- **Orange** - `#FF9500` - Energy/Streak
  - **CSS Variable**: `--color-warning`
  - Used for: Streaks, fire indicators, warm accents
  - Example: Streak counters, body profile icons

### Neutral Colors
- **White** - `#FFFFFF` - Primary background
  - **CSS Variable**: `--color-background`
  - Used for: All page backgrounds, card backgrounds
  - **Important**: Background color should always be pure white

- **Black with Opacity**
  - `rgba(0, 0, 0, 0.7)` - **CSS Variable**: `--text-primary` - Primary text
  - `rgba(0, 0, 0, 0.6)` - **CSS Variable**: `--text-secondary` - Secondary text
  - `rgba(0, 0, 0, 0.5)` - **CSS Variable**: `--text-tertiary` - Section headers
  - `rgba(0, 0, 0, 0.4)` - **CSS Variable**: `--text-disabled` - Disabled states
  - `rgba(0, 0, 0, 0.3)` - Subtle separators
  - `rgba(0, 0, 0, 0.1)` - Light borders, card backgrounds

- **Light Gray** - `#D1D1D6` - Borders and strokes
  - **CSS Variable**: `--color-border`
  - Used for: Primary border color with 2px width
  - Example: All card borders, input field borders, container borders

### CSS Variables Setup
```css
:root {
  /* Primary Colors */
  --color-primary: #4A90E2;
  --color-primary-dark: #2C5AA0;
  --color-accent: #FFD700;
  
  /* Semantic Colors */
  --color-danger: #FF3B30;
  --color-success: #34C759;
  --color-warning: #FF9500;
  
  /* Neutral Colors */
  --color-background: #FFFFFF;
  --color-border: #D1D1D6;
  
  /* Text Colors */
  --text-primary: rgba(0, 0, 0, 0.7);
  --text-secondary: rgba(0, 0, 0, 0.6);
  --text-tertiary: rgba(0, 0, 0, 0.5);
  --text-disabled: rgba(0, 0, 0, 0.4);
}
```

---

## Typography

### Font Family
- **DIN Round Pro** - Primary typeface for all text
  - Available weights: Light (300), Regular (400), Medium (500), Bold (700), Black (900)
  - Fallback: `'DIN Round Pro', 'Helvetica Neue', Arial, sans-serif`

### @font-face Declaration
```css
@font-face {
  font-family: 'DIN Round Pro';
  src: url('/fonts/DINRoundPro-Regular.otf') format('opentype');
  font-weight: 400;
  font-style: normal;
}

@font-face {
  font-family: 'DIN Round Pro';
  src: url('/fonts/DINRoundPro-Medium.otf') format('opentype');
  font-weight: 500;
  font-style: normal;
}

@font-face {
  font-family: 'DIN Round Pro';
  src: url('/fonts/DINRoundPro-Bold.otf') format('opentype');
  font-weight: 700;
  font-style: normal;
}
```

### Font Sizes & Weights

#### Headers
- **Large Headers**: `32px`, `font-weight: 700` - Page titles, exercise names
- **Section Headers**: `24px`, `font-weight: 700` - Major section titles
- **Subsection Headers**: `20px`, `font-weight: 700` - Card titles, section headings
- **Small Headers**: `18px`, `font-weight: 700` - Subsection titles
- **Mini Headers**: `14px`, `font-weight: 700` - Category labels, small section titles

#### Body Text
- **Default Body**: `16px`, `font-weight: 500` - Primary body text
- **Small Body**: `14px`, `font-weight: 500` - Secondary descriptions
- **Caption**: `12px`, `font-weight: 500` - Captions, helper text
- **Tiny**: `10px`, `font-weight: 500` - Micro labels, tags

#### Interactive Elements
- **Button Text**: `16px`, `font-weight: 700`
- **Tab Labels**: `12px`, `font-weight: 700`
- **Badge Text**: `14px`, `font-weight: 700`

### Typography Classes
```css
.text-large-header {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 32px;
  font-weight: 700;
  color: var(--text-primary);
}

.text-section-header {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 24px;
  font-weight: 700;
  color: var(--text-primary);
}

.text-body {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 16px;
  font-weight: 500;
  color: var(--text-secondary);
}
```

---

## Border Radius

### Standard Values (CSS Variables)
```css
:root {
  --radius-sm: 8px;    /* Small elements, badges */
  --radius-md: 10px;   /* Input fields, standard cards */
  --radius-lg: 12px;   /* Large cards, sections, buttons */
  --radius-xl: 16px;   /* Banner cards, special containers */
  --radius-pill: 20px; /* Stat indicators, pill-shaped elements */
  --radius-circle: 50%; /* Profile pictures, circular badges */
}
```

### Usage
```css
.card {
  border-radius: var(--radius-lg); /* 12px */
}

.input-field {
  border-radius: var(--radius-md); /* 10px */
}

.profile-picture {
  border-radius: var(--radius-circle); /* 50% */
}
```

---

## Borders & Strokes

### Standard Border Style
- **Width**: `2px`
- **Color**: `var(--color-border)` or `#D1D1D6`
- **Implementation**:
```css
.card {
  border: 2px solid var(--color-border);
  border-radius: var(--radius-lg);
}
```

### Highlighted/Active Borders
- **Width**: `2px` or `3px` for emphasis
- **Color**: `var(--color-primary)` (primary), `var(--color-accent)` (special), `var(--color-danger)` (destructive)
```css
.card-active {
  border: 2px solid var(--color-primary);
}

.card-emphasis {
  border: 3px solid var(--color-accent);
}
```

### Subtle Borders
- **Width**: `2px`
- **Color**: `rgba(0, 0, 0, 0.1)`
```css
.divider {
  border-bottom: 2px solid rgba(0, 0, 0, 0.1);
}
```

---

## Spacing & Padding

### Spacing Scale (CSS Variables)
```css
:root {
  --spacing-xs: 6px;   /* Extra small */
  --spacing-sm: 8px;   /* Small */
  --spacing-md: 12px;  /* Medium */
  --spacing-lg: 16px;  /* Large */
  --spacing-xl: 20px;  /* Extra large */
  --spacing-2xl: 24px; /* 2X large */
}
```

### Usage Examples
```css
.card {
  padding: var(--spacing-lg); /* 16px */
}

.section {
  margin-bottom: var(--spacing-2xl); /* 24px */
}

.badge {
  padding: var(--spacing-xs) var(--spacing-md); /* 6px 12px */
}
```

---

## Shadows

### Standard Shadow
```css
.shadow-default {
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}
```

### Card Shadow (Optional)
```css
.shadow-card {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}
```

### Skill Tree Node Shadow
```css
.skill-node {
  box-shadow: 0 4px 8px rgba(74, 144, 226, 0.3); /* Primary color with opacity */
}
```

---

## Component Patterns

### Primary Button
```html
<button class="btn btn-primary">
  Button Text
</button>
```

```css
.btn {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 16px;
  font-weight: 700;
  padding: 12px 16px;
  border-radius: var(--radius-lg);
  border: none;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn-primary {
  background-color: var(--color-primary);
  color: #FFFFFF;
}

.btn-primary:hover {
  background-color: var(--color-primary-dark);
}

.btn-primary:active {
  transform: scale(0.98);
}
```

### Secondary Button
```css
.btn-secondary {
  background-color: #FFFFFF;
  color: var(--color-primary);
  border: 2px solid var(--color-primary);
}

.btn-secondary:hover {
  background-color: rgba(74, 144, 226, 0.1);
}
```

### Destructive Button
```css
.btn-danger {
  background-color: var(--color-danger);
  color: #FFFFFF;
}

.btn-danger:hover {
  background-color: #E02020;
}
```

### Card Container
```html
<div class="card">
  <!-- Content -->
</div>
```

```css
.card {
  background-color: var(--color-background);
  padding: var(--spacing-lg);
  border-radius: var(--radius-lg);
  border: 2px solid var(--color-border);
}
```

### Input Field
```html
<div class="input-group">
  <label class="input-label">Label</label>
  <input type="text" class="input-field" placeholder="Placeholder" />
</div>
```

```css
.input-group {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-sm);
}

.input-label {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 16px;
  font-weight: 500;
  color: var(--text-primary);
}

.input-field {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 16px;
  font-weight: 500;
  color: var(--text-primary);
  padding: 12px 16px;
  background-color: var(--color-background);
  border: 2px solid var(--color-border);
  border-radius: var(--radius-md);
  transition: border-color 0.2s ease;
}

.input-field:focus {
  outline: none;
  border-color: var(--color-primary);
}
```

### Badge
```html
<span class="badge badge-primary">Badge Text</span>
```

```css
.badge {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 14px;
  font-weight: 700;
  padding: 6px 12px;
  border-radius: var(--radius-lg);
  display: inline-block;
}

.badge-primary {
  color: var(--color-primary);
  background-color: rgba(74, 144, 226, 0.15);
}

.badge-accent {
  color: var(--color-accent);
  background-color: rgba(255, 215, 0, 0.15);
}

.badge-success {
  color: var(--color-success);
  background-color: rgba(52, 199, 89, 0.15);
}
```

### Stat Box
```html
<div class="stat-box">
  <div class="stat-value">123</div>
  <div class="stat-label">Label</div>
</div>
```

```css
.stat-box {
  padding: var(--spacing-lg);
  background-color: var(--color-background);
  border: 2px solid rgba(0, 0, 0, 0.1);
  border-radius: var(--radius-md);
}

.stat-value {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 24px;
  font-weight: 700;
  color: var(--text-primary);
}

.stat-label {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 12px;
  font-weight: 500;
  color: var(--text-tertiary);
  margin-top: var(--spacing-sm);
}
```

---

## Layout Patterns

### Sticky Header Pattern
```html
<div class="page-container">
  <header class="sticky-header">
    <button class="btn-back">
      <svg><!-- chevron icon --></svg>
      <span>Back</span>
    </button>
    
    <h1 class="header-title">Page Title</h1>
    
    <!-- Spacer for symmetry -->
    <div class="header-spacer"></div>
  </header>
  
  <main class="page-content">
    <!-- Scrollable content -->
  </main>
</div>
```

```css
.page-container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--color-background);
}

.sticky-header {
  position: sticky;
  top: 0;
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--spacing-lg) var(--spacing-xl);
  padding-bottom: var(--spacing-md);
  background-color: var(--color-background);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.btn-back {
  display: flex;
  align-items: center;
  gap: 4px;
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 16px;
  font-weight: 500;
  color: var(--color-primary);
  background: none;
  border: none;
  cursor: pointer;
}

.header-title {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 20px;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0;
}

.header-spacer {
  width: 60px; /* Match back button width for centering */
}

.page-content {
  flex: 1;
  overflow-y: auto;
  padding: var(--spacing-xl);
}
```

### List Item Pattern
```html
<div class="list-item">
  <div class="list-icon">
    <svg><!-- icon --></svg>
  </div>
  
  <div class="list-content">
    <div class="list-title">Title</div>
    <div class="list-subtitle">Subtitle</div>
  </div>
  
  <svg class="list-chevron"><!-- chevron right --></svg>
</div>
```

```css
.list-item {
  display: flex;
  align-items: center;
  gap: var(--spacing-md);
  padding: var(--spacing-lg);
  background-color: var(--color-background);
  border: 2px solid var(--color-border);
  border-radius: var(--radius-md);
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.list-item:hover {
  background-color: rgba(0, 0, 0, 0.02);
}

.list-icon {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(74, 144, 226, 0.1);
  border-radius: var(--radius-sm);
  color: var(--color-primary);
}

.list-content {
  flex: 1;
}

.list-title {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 16px;
  font-weight: 700;
  color: var(--text-primary);
}

.list-subtitle {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 12px;
  font-weight: 500;
  color: var(--text-tertiary);
  margin-top: 2px;
}

.list-chevron {
  color: rgba(0, 0, 0, 0.3);
}
```

---

## Progress Indicators

### Progress Bar
```html
<div class="progress-bar">
  <div class="progress-fill" style="width: 60%;"></div>
</div>
```

```css
.progress-bar {
  height: 4px;
  background-color: rgba(209, 209, 214, 0.2);
  border-radius: 2px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background-color: var(--color-primary);
  transition: width 0.3s ease;
}

/* For goal completion */
.progress-fill.success {
  background-color: var(--color-success);
}
```

### Circular Progress
```html
<svg class="progress-circle" width="120" height="120">
  <circle class="progress-circle-bg" cx="60" cy="60" r="54"></circle>
  <circle class="progress-circle-fill" cx="60" cy="60" r="54" 
    style="stroke-dashoffset: calc(339.292 - (339.292 * 0.6));"></circle>
</svg>
```

```css
.progress-circle {
  transform: rotate(-90deg);
}

.progress-circle-bg {
  fill: none;
  stroke: rgba(209, 209, 214, 0.2);
  stroke-width: 8;
}

.progress-circle-fill {
  fill: none;
  stroke: var(--color-success);
  stroke-width: 8;
  stroke-dasharray: 339.292;
  stroke-linecap: round;
  transition: stroke-dashoffset 0.5s ease;
}
```

---

## Special Components

### Skill Tree Nodes
```html
<div class="skill-node skill-node-unlocked">
  <div class="skill-node-inner">
    <span class="skill-node-label">Level 1</span>
  </div>
</div>
```

```css
.skill-node {
  width: 70px;
  height: 70px;
  border-radius: 50%;
  padding: 4px;
  cursor: pointer;
  transition: transform 0.2s ease;
}

.skill-node-unlocked {
  background: var(--color-primary);
  box-shadow: 0 4px 8px rgba(74, 144, 226, 0.3);
}

.skill-node-completed {
  background: var(--color-success);
  box-shadow: 0 4px 8px rgba(52, 199, 89, 0.3);
}

.skill-node-locked {
  background: var(--color-border);
  opacity: 0.4;
  cursor: not-allowed;
}

.skill-node:hover:not(.skill-node-locked) {
  transform: scale(1.05);
}

.skill-node-inner {
  width: 100%;
  height: 100%;
  background: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.skill-node-label {
  font-family: 'DIN Round Pro', sans-serif;
  font-size: 12px;
  font-weight: 700;
  color: var(--text-primary);
  text-align: center;
}
```

### Gamification Elements
```html
<!-- XP Badge -->
<div class="badge badge-xp">
  <svg><!-- sparkle icon --></svg>
  <span>+50 XP</span>
</div>

<!-- Streak Indicator -->
<div class="badge badge-streak">
  <svg><!-- flame icon --></svg>
  <span>12 Day Streak</span>
</div>
```

```css
.badge-xp {
  color: var(--color-accent);
  background-color: rgba(255, 215, 0, 0.15);
}

.badge-streak {
  color: var(--color-warning);
  background-color: rgba(255, 149, 0, 0.15);
}
```

---

## Animations

### Standard Transitions
```css
/* Smooth transitions for interactive elements */
.interactive {
  transition: all 0.2s ease;
}

/* Button press effect */
.btn:active {
  transform: scale(0.98);
}

/* Hover effects */
.card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
```

### Spring Animation (using CSS)
```css
@keyframes spring {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}

.animated-element {
  animation: spring 0.3s ease;
}
```

---

## React/Component Examples

### Primary Button Component (React)
```jsx
const PrimaryButton = ({ children, onClick, variant = 'primary' }) => {
  return (
    <button 
      className={`btn btn-${variant}`}
      onClick={onClick}
    >
      {children}
    </button>
  );
};

// Usage
<PrimaryButton variant="primary" onClick={handleClick}>
  Click Me
</PrimaryButton>
```

### Card Component (React)
```jsx
const Card = ({ children, className = '' }) => {
  return (
    <div className={`card ${className}`}>
      {children}
    </div>
  );
};
```

### Badge Component (React)
```jsx
const Badge = ({ children, variant = 'primary' }) => {
  return (
    <span className={`badge badge-${variant}`}>
      {children}
    </span>
  );
};
```

---

## Responsive Design

### Breakpoints
```css
:root {
  --breakpoint-mobile: 640px;
  --breakpoint-tablet: 768px;
  --breakpoint-desktop: 1024px;
  --breakpoint-wide: 1280px;
}
```

### Media Query Usage
```css
/* Mobile first approach */
.container {
  padding: var(--spacing-lg);
}

@media (min-width: 768px) {
  .container {
    padding: var(--spacing-xl);
  }
}

@media (min-width: 1024px) {
  .container {
    padding: var(--spacing-2xl);
  }
}
```

---

## Accessibility

### Text Contrast
- Ensure primary text (`rgba(0, 0, 0, 0.7)`) meets WCAG AA standards on white
- Secondary text should remain readable (`rgba(0, 0, 0, 0.5-0.6)`)

### Focus States
```css
.btn:focus,
.input-field:focus {
  outline: 2px solid var(--color-primary);
  outline-offset: 2px;
}
```

### Touch Targets (Mobile)
- Minimum touch target: `44px × 44px`
- Ensure adequate spacing between interactive elements

### Semantic HTML
- Use proper heading hierarchy (`<h1>`, `<h2>`, etc.)
- Use `<button>` for clickable actions, not `<div>`
- Include `alt` text for images
- Use `aria-label` for icon-only buttons

---

## Dos and Don'ts

### ✅ Do
- Always use DIN Round Pro font
- Use pure white (`#FFFFFF`) for backgrounds
- Apply consistent 2px borders with `var(--color-border)`
- Use `var(--color-primary)` for primary actions
- Maintain consistent border radius (10-12px for most elements)
- Use sticky headers for scrollable content with back buttons
- Cache randomly generated data to prevent re-render changes
- Use CSS variables for consistency
- Follow semantic HTML practices

### ❌ Don't
- Use system fonts (Arial, Helvetica) as primary fonts
- Use off-white or gray backgrounds (always pure white)
- Mix different border widths on similar components
- Use gradients (stick to solid colors)
- Create inconsistent spacing (follow the spacing scale)
- Skip borders on cards/containers
- Use non-standard color values (use CSS variables)

---

## File Organization

### Recommended Structure
```
src/
├── styles/
│   ├── variables.css       # CSS variables
│   ├── typography.css      # Font definitions
│   ├── components.css      # Component styles
│   └── utilities.css       # Utility classes
├── components/
│   ├── Button/
│   │   ├── Button.jsx
│   │   └── Button.css
│   ├── Card/
│   │   ├── Card.jsx
│   │   └── Card.css
│   └── Badge/
│       ├── Badge.jsx
│       └── Badge.css
└── assets/
    ├── fonts/              # DIN Round Pro font files
    └── images/             # Images and icons
```

---

## Version
- **Version**: 1.0
- **Last Updated**: October 2025
- **Platform**: Web (HTML/CSS/React)

---

This design system ensures consistency across the Twyst web application and provides clear guidelines for future development. When in doubt, reference existing components or consult this documentation for proper implementation patterns.
