# Angular Component Architecture

## What is a Component?

A component is the basic building block of an Angular application. It controls a portion of the screen (view) and contains the logic and data needed for that view.

Think of components as reusable, self-contained pieces of UI that can be combined to build complex applications.

## Component Structure

Every Angular component consists of four main parts:

### 1. **TypeScript Class** (.ts file)
- Contains the component logic
- Defines properties and methods
- Handles data and business logic

### 2. **HTML Template** (.html file)
- Defines the view/UI
- Uses Angular syntax for data binding
- Displays data from the component class

### 3. **CSS Styles** (.css/.scss file)
- Defines the appearance
- Scoped to the component (encapsulated)
- Can use CSS, SCSS, SASS, or LESS

### 4. **Metadata** (@Component decorator)
- Provides configuration
- Links template, styles, and class together
- Defines selector and other properties

## Component Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    ANGULAR APPLICATION                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │              APP COMPONENT (Root)                   │    │
│  │              <app-root>                             │    │
│  │  ┌──────────────────────────────────────────────┐  │    │
│  │  │          HEADER COMPONENT                     │  │    │
│  │  │          <app-header>                         │  │    │
│  │  │  ┌────────────┐  ┌────────────┐             │  │    │
│  │  │  │    Logo    │  │Navigation  │             │  │    │
│  │  │  │ Component  │  │  Component │             │  │    │
│  │  │  └────────────┘  └────────────┘             │  │    │
│  │  └──────────────────────────────────────────────┘  │    │
│  │                                                      │    │
│  │  ┌──────────────────────────────────────────────┐  │    │
│  │  │          PRODUCT-LIST COMPONENT               │  │    │
│  │  │          <app-product-list>                   │  │    │
│  │  │  ┌────────────┐  ┌────────────┐             │  │    │
│  │  │  │  Product   │  │  Product   │             │  │    │
│  │  │  │   Card     │  │   Card     │  (Repeated) │  │    │
│  │  │  │ Component  │  │ Component  │             │  │    │
│  │  │  └────────────┘  └────────────┘             │  │    │
│  │  └──────────────────────────────────────────────┘  │    │
│  │                                                      │    │
│  │  ┌──────────────────────────────────────────────┐  │    │
│  │  │          FOOTER COMPONENT                     │  │    │
│  │  │          <app-footer>                         │  │    │
│  │  └──────────────────────────────────────────────┘  │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Component File Structure

```
src/
└── app/
    ├── app.component.ts          # Root component class
    ├── app.component.html        # Root component template
    ├── app.component.css         # Root component styles
    ├── app.component.spec.ts     # Root component tests
    │
    ├── header/
    │   ├── header.component.ts
    │   ├── header.component.html
    │   ├── header.component.css
    │   ├── header.component.spec.ts
    │   │
    │   ├── logo/
    │   │   ├── logo.component.ts
    │   │   ├── logo.component.html
    │   │   ├── logo.component.css
    │   │   └── logo.component.spec.ts
    │   │
    │   └── navigation/
    │       ├── navigation.component.ts
    │       ├── navigation.component.html
    │       ├── navigation.component.css
    │       └── navigation.component.spec.ts
    │
    ├── product-list/
    │   ├── product-list.component.ts
    │   ├── product-list.component.html
    │   ├── product-list.component.css
    │   ├── product-list.component.spec.ts
    │   │
    │   └── product-card/
    │       ├── product-card.component.ts
    │       ├── product-card.component.html
    │       ├── product-card.component.css
    │       └── product-card.component.spec.ts
    │
    └── footer/
        ├── footer.component.ts
        ├── footer.component.html
        ├── footer.component.css
        └── footer.component.spec.ts
```

## Component Anatomy

### Example Component

**user.component.ts** (TypeScript Class)
```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'app-user',           // How to use in HTML: <app-user></app-user>
  templateUrl: './user.component.html',  // Link to template
  styleUrls: ['./user.component.css']    // Link to styles
})
export class UserComponent {
  // Properties (data)
  userName: string = 'John Doe';
  age: number = 25;
  isActive: boolean = true;
  
  // Methods (behavior)
  greetUser(): string {
    return `Hello, ${this.userName}!`;
  }
  
  updateName(newName: string): void {
    this.userName = newName;
  }
}
```

**user.component.html** (Template)
```html
<div class="user-card">
  <h2>{{ userName }}</h2>
  <p>Age: {{ age }}</p>
  <p>Status: {{ isActive ? 'Active' : 'Inactive' }}</p>
  
  <button (click)="greetUser()">Greet</button>
  
  <input 
    type="text" 
    [(ngModel)]="userName" 
    placeholder="Enter name"
  />
</div>
```

**user.component.css** (Styles)
```css
.user-card {
  border: 1px solid #ccc;
  padding: 20px;
  border-radius: 8px;
  max-width: 300px;
}

h2 {
  color: #333;
  margin-bottom: 10px;
}

button {
  background-color: #007bff;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
```

## Component Decorator Properties

| Property | Description | Example |
|----------|-------------|---------|
| `selector` | CSS selector to identify component in template | `'app-user'` |
| `templateUrl` | Path to external HTML template | `'./user.component.html'` |
| `template` | Inline HTML template | `'<h1>Hello</h1>'` |
| `styleUrls` | Array of paths to external stylesheets | `['./user.component.css']` |
| `styles` | Array of inline styles | `['h1 { color: red; }']` |
| `providers` | Services available to this component | `[UserService]` |
| `standalone` | Makes component standalone (Angular 14+) | `true` or `false` |

## Component Lifecycle

Angular components go through several phases from creation to destruction. These are managed by lifecycle hooks:

```
┌─────────────────────────────────────────────────────────┐
│              COMPONENT LIFECYCLE                         │
└─────────────────────────────────────────────────────────┘

    ┌─────────────────┐
    │   Constructor   │  ← Component is instantiated
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │   ngOnInit()    │  ← Component initialization
    └────────┬────────┘    (Called once)
             │
             ▼
    ┌─────────────────┐
    │  ngOnChanges()  │  ← Input properties change
    └────────┬────────┘    (Called multiple times)
             │
             ▼
    ┌─────────────────┐
    │  ngDoCheck()    │  ← Custom change detection
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │ngAfterViewInit()│  ← View initialization complete
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │   Component     │  ← Component is active
    │   Running       │    and displayed
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  ngOnDestroy()  │  ← Component cleanup
    └─────────────────┘    (Called once before removal)
```

### Lifecycle Hook Example

```typescript
import { Component, OnInit, OnDestroy } from '@angular/core';

@Component({
  selector: 'app-example',
  templateUrl: './example.component.html'
})
export class ExampleComponent implements OnInit, OnDestroy {
  
  constructor() {
    console.log('1. Constructor called');
  }
  
  ngOnInit(): void {
    console.log('2. ngOnInit called - Component initialized');
    // Initialization logic here (API calls, subscriptions)
  }
  
  ngOnDestroy(): void {
    console.log('3. ngOnDestroy called - Component destroyed');
    // Cleanup logic here (unsubscribe, clear timers)
  }
}
```

## Component Communication

### 1. Parent to Child Communication (@Input)

**Parent Component**
```typescript
// parent.component.ts
export class ParentComponent {
  parentMessage = "Message from Parent";
}
```

```html
<!-- parent.component.html -->
<app-child [childMessage]="parentMessage"></app-child>
```

**Child Component**
```typescript
// child.component.ts
import { Component, Input } from '@angular/core';

export class ChildComponent {
  @Input() childMessage: string = '';
}
```

```html
<!-- child.component.html -->
<p>{{ childMessage }}</p>
```

### 2. Child to Parent Communication (@Output)

**Child Component**
```typescript
// child.component.ts
import { Component, Output, EventEmitter } from '@angular/core';

export class ChildComponent {
  @Output() messageEvent = new EventEmitter<string>();
  
  sendMessage() {
    this.messageEvent.emit('Message from Child');
  }
}
```

```html
<!-- child.component.html -->
<button (click)="sendMessage()">Send to Parent</button>
```

**Parent Component**
```typescript
// parent.component.ts
export class ParentComponent {
  receiveMessage(message: string) {
    console.log(message);
  }
}
```

```html
<!-- parent.component.html -->
<app-child (messageEvent)="receiveMessage($event)"></app-child>
```

## Component Communication Diagram

```
┌──────────────────────────────────────────────────────┐
│              PARENT COMPONENT                         │
│                                                       │
│  parentData = "Hello"                                │
│                                                       │
│  ┌────────────────────────────────────────────────┐ │
│  │  @Input()                                       │ │
│  │  [childData]="parentData"    ──────────┐       │ │
│  │                                         │       │ │
│  │  ┌──────────────────────────────────┐  │       │ │
│  │  │     CHILD COMPONENT              │  │       │ │
│  │  │                                  │  │       │ │
│  │  │  @Input() childData: string     │◄─┘       │ │
│  │  │                                  │          │ │
│  │  │  @Output() dataEvent            │          │ │
│  │  │    = new EventEmitter()         │          │ │
│  │  │                                  │          │ │
│  │  │  sendData() {                   │          │ │
│  │  │    this.dataEvent.emit(data)    │──┐       │ │
│  │  │  }                               │  │       │ │
│  │  └──────────────────────────────────┘  │       │ │
│  │                                         │       │ │
│  │  (dataEvent)="receiveData($event)" ◄───┘       │ │
│  └────────────────────────────────────────────────┘ │
│                                                       │
│  receiveData(data) { ... }                           │
│                                                       │
└──────────────────────────────────────────────────────┘
```

## Key Component Concepts

### 1. **Encapsulation**
- Styles are scoped to the component
- Prevents style conflicts
- Can be configured with `ViewEncapsulation`

### 2. **Reusability**
- Components can be used multiple times
- Accept different inputs via `@Input()`
- Promote DRY (Don't Repeat Yourself) principle

### 3. **Modularity**
- Break complex UI into smaller components
- Each component has single responsibility
- Easier to test and maintain

### 4. **Data Binding**
- **Interpolation**: `{{ data }}`
- **Property Binding**: `[property]="data"`
- **Event Binding**: `(event)="handler()"`
- **Two-way Binding**: `[(ngModel)]="data"`

## Best Practices

1. **Keep components small and focused** - One responsibility per component
2. **Use meaningful names** - Name should describe what component does
3. **Use `OnPush` change detection** - For better performance
4. **Implement lifecycle hooks** - Initialize in `ngOnInit`, cleanup in `ngOnDestroy`
5. **Use `@Input()` and `@Output()`** - For component communication
6. **Avoid business logic in components** - Use services instead
7. **Use smart and dumb components** - Separate data logic from presentation
8. **Keep templates simple** - Complex logic should be in component class

## Smart vs Dumb Components

### Smart Components (Container Components)
- Manage data and state
- Communicate with services
- Handle business logic
- Pass data to dumb components

### Dumb Components (Presentational Components)
- Receive data via `@Input()`
- Emit events via `@Output()`
- Focus on presentation
- No direct service communication
- Highly reusable

```
┌────────────────────────────────────────────┐
│     SMART COMPONENT (Container)            │
│                                            │
│  - Fetches data from service               │
│  - Manages state                           │
│  - Handles business logic                  │
│                                            │
│  ┌──────────────────────────────────────┐ │
│  │   DUMB COMPONENT (Presentational)    │ │
│  │                                      │ │
│  │  - Displays data                     │ │
│  │  - Emits user events                 │ │
│  │  - Pure presentation                 │ │
│  └──────────────────────────────────────┘ │
└────────────────────────────────────────────┘
```

## Summary

Angular's component architecture provides:
- **Modularity**: Break app into small, manageable pieces
- **Reusability**: Use components multiple times
- **Maintainability**: Easy to update and test
- **Scalability**: Build large applications efficiently
- **Separation of Concerns**: Clear division between logic, template, and styles
