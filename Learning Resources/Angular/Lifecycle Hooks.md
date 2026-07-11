# Angular Lifecycle Hooks Reference

## Overview

Angular lifecycle hooks are methods that allow you to tap into key moments in a component's or directive's lifecycle. They provide visibility into these moments and the ability to act when they occur.

## Hook Execution Order

1. `ngOnChanges()` - Before `ngOnInit()` and whenever input properties change
2. `ngOnInit()` - Once after first `ngOnChanges()`
3. `ngDoCheck()` - During every change detection run
4. `ngAfterContentInit()` - Once after first `ngDoCheck()`
5. `ngAfterContentChecked()` - After `ngDoCheck()` and every subsequent check
6. `ngAfterViewInit()` - Once after first `ngAfterContentChecked()`
7. `ngAfterViewChecked()` - After `ngAfterViewInit()` and every subsequent check
8. `ngOnDestroy()` - Just before Angular destroys the component/directive

## Core Lifecycle Hooks

### ngOnChanges

Called before `ngOnInit()` and whenever one or more input properties change.

```typescript
import { Component, Input, OnChanges, SimpleChanges } from '@angular/core';

@Component({
  selector: 'app-example',
  template: '<p>{{ data }}</p>'
})
export class ExampleComponent implements OnChanges {
  @Input() data: string;

  ngOnChanges(changes: SimpleChanges): void {
    console.log('Previous:', changes['data'].previousValue);
    console.log('Current:', changes['data'].currentValue);
    console.log('First change:', changes['data'].firstChange);
  }
}
```

**Use cases:**
- React to input property changes
- Perform operations based on input values
- Initialize component state based on inputs

### ngOnInit

Called once after the first `ngOnChanges()`. Initializes the component after Angular sets the input properties.

```typescript
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-example',
  template: '<p>{{ message }}</p>'
})
export class ExampleComponent implements OnInit {
  message: string;

  ngOnInit(): void {
    this.message = 'Component initialized';
    // Fetch data from API
    // Set up subscriptions
    // Complex initialization logic
  }
}
```

**Use cases:**
- Fetch initial data from services or APIs
- Set up component state
- Initialize third-party libraries
- Perform complex initialization logic

### ngDoCheck

Called during every change detection run, immediately after `ngOnChanges()` and `ngOnInit()`.

```typescript
import { Component, DoCheck } from '@angular/core';

@Component({
  selector: 'app-example',
  template: '<p>{{ items.length }} items</p>'
})
export class ExampleComponent implements DoCheck {
  items: string[] = [];

  ngDoCheck(): void {
    // Detect changes that Angular can't catch automatically
    console.log('Change detection running');
  }
}
```

**Use cases:**
- Implement custom change detection
- Detect changes Angular doesn't catch automatically
- **Warning:** Can impact performance if overused

### ngAfterContentInit

Called once after the first `ngDoCheck()`. Responds after Angular projects external content into the component's view.

```typescript
import { Component, AfterContentInit, ContentChild } from '@angular/core';

@Component({
  selector: 'app-parent',
  template: '<ng-content></ng-content>'
})
export class ParentComponent implements AfterContentInit {
  @ContentChild(ChildComponent) child: ChildComponent;

  ngAfterContentInit(): void {
    console.log('Content initialized:', this.child);
    // Access projected content
  }
}
```

**Use cases:**
- Access and manipulate projected content (ng-content)
- Interact with child components passed via content projection

### ngAfterContentChecked

Called after `ngAfterContentInit()` and every subsequent `ngDoCheck()`.

```typescript
import { Component, AfterContentChecked } from '@angular/core';

@Component({
  selector: 'app-example',
  template: '<ng-content></ng-content>'
})
export class ExampleComponent implements AfterContentChecked {
  ngAfterContentChecked(): void {
    console.log('Content checked');
    // Respond after Angular checks projected content
  }
}
```

**Use cases:**
- Respond to changes in projected content
- **Warning:** Called frequently, avoid heavy operations

### ngAfterViewInit

Called once after the first `ngAfterContentChecked()`. Responds after Angular initializes the component's views and child views.

```typescript
import { Component, AfterViewInit, ViewChild, ElementRef } from '@angular/core';

@Component({
  selector: 'app-example',
  template: '<div #myDiv>Content</div>'
})
export class ExampleComponent implements AfterViewInit {
  @ViewChild('myDiv') divElement: ElementRef;

  ngAfterViewInit(): void {
    console.log('Native element:', this.divElement.nativeElement);
    // Access view elements
    // Initialize third-party libraries that need DOM
  }
}
```

**Use cases:**
- Access and manipulate view children and DOM elements
- Initialize third-party libraries that require DOM access
- Perform operations after view is fully initialized

### ngAfterViewChecked

Called after `ngAfterViewInit()` and every subsequent `ngAfterContentChecked()`.

```typescript
import { Component, AfterViewChecked } from '@angular/core';

@Component({
  selector: 'app-example',
  template: '<p>{{ data }}</p>'
})
export class ExampleComponent implements AfterViewChecked {
  ngAfterViewChecked(): void {
    console.log('View checked');
    // Respond after Angular checks component views
  }
}
```

**Use cases:**
- Respond to changes in the view
- **Warning:** Called very frequently, avoid expensive operations

### ngOnDestroy

Called just before Angular destroys the component/directive. Cleanup logic goes here.

```typescript
import { Component, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-example',
  template: '<p>Component</p>'
})
export class ExampleComponent implements OnDestroy {
  private subscription: Subscription;

  ngOnDestroy(): void {
    // Unsubscribe from observables
    this.subscription?.unsubscribe();
    
    // Detach event handlers
    // Stop timers
    // Clean up resources
  }
}
```

**Use cases:**
- Unsubscribe from observables
- Detach event handlers
- Stop timers and intervals
- Free up resources to prevent memory leaks

## Best Practices

1. **Always unsubscribe:** Use `ngOnDestroy()` to unsubscribe from observables to prevent memory leaks.

2. **Avoid heavy logic in frequently called hooks:** Hooks like `ngDoCheck()`, `ngAfterContentChecked()`, and `ngAfterViewChecked()` are called frequently and can impact performance.

3. **Use ngOnInit for initialization:** Prefer `ngOnInit()` over constructor for complex initialization logic.

4. **Be careful with view modifications:** Avoid modifying view state in `ngAfterViewInit()` and `ngAfterViewChecked()` as it can cause the "ExpressionChangedAfterItHasBeenCheckedError".

5. **Implement interfaces:** Always implement the corresponding interface when using a lifecycle hook for better type safety.

## Common Patterns

### Unsubscribing from Observables

```typescript
import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subject, takeUntil } from 'rxjs';

@Component({
  selector: 'app-example',
  template: '<p>Data component</p>'
})
export class ExampleComponent implements OnInit, OnDestroy {
  private destroy$ = new Subject<void>();

  ngOnInit(): void {
    this.dataService.getData()
      .pipe(takeUntil(this.destroy$))
      .subscribe(data => console.log(data));
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
}
```

### Accessing View Children

```typescript
import { Component, AfterViewInit, ViewChild } from '@angular/core';

@Component({
  selector: 'app-parent',
  template: '<app-child></app-child>'
})
export class ParentComponent implements AfterViewInit {
  @ViewChild(ChildComponent) child: ChildComponent;

  ngAfterViewInit(): void {
    // Safely access child component after view initialization
    this.child.someMethod();
  }
}
```

## Summary Table

| Hook | Called When | Common Use Cases |
|------|-------------|------------------|
| `ngOnChanges` | Input properties change | React to input changes |
| `ngOnInit` | Component initialization | Fetch data, setup |
| `ngDoCheck` | Every change detection | Custom change detection |
| `ngAfterContentInit` | Content projection initialized | Access projected content |
| `ngAfterContentChecked` | Projected content checked | Respond to content changes |
| `ngAfterViewInit` | View initialized | Access DOM, setup libraries |
| `ngAfterViewChecked` | View checked | Respond to view changes |
| `ngOnDestroy` | Before component destruction | Cleanup, unsubscribe |
