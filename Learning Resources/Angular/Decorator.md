# Angular Decorators

## What is a Decorator?

A **decorator** is a special kind of declaration in TypeScript that can be attached to classes, methods, properties, or parameters. In Angular, decorators are used to add metadata and configure how classes and their members behave.

Decorators are preceded by the `@` symbol and are placed directly before the item they decorate.

### Syntax
```typescript
@DecoratorName
class MyClass { }

@DecoratorName()
class MyClass { }

@DecoratorName(config)
class MyClass { }
```

## Why Use Decorators?

- **Add Metadata**: Provide additional information about classes, properties, methods
- **Configuration**: Configure how Angular handles components, services, etc.
- **Dependency Injection**: Tell Angular what to inject into constructors
- **Data Binding**: Enable communication between components
- **Clean Code**: Make code more readable and maintainable

## Types of Angular Decorators

```
┌─────────────────────────────────────────────────────────┐
│              ANGULAR DECORATORS                          │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌────────────────────────────────────────────────┐    │
│  │        CLASS DECORATORS                         │    │
│  │  • @Component                                   │    │
│  │  • @Directive                                   │    │
│  │  • @Pipe                                        │    │
│  │  • @Injectable                                  │    │
│  │  • @NgModule                                    │    │
│  └────────────────────────────────────────────────┘    │
│                                                          │
│  ┌────────────────────────────────────────────────┐    │
│  │        PROPERTY DECORATORS                      │    │
│  │  • @Input()                                     │    │
│  │  • @Output()                                    │    │
│  │  • @ViewChild()                                 │    │
│  │  • @ViewChildren()                              │    │
│  │  • @ContentChild()                              │    │
│  │  • @ContentChildren()                           │    │
│  │  • @HostBinding()                               │    │
│  └────────────────────────────────────────────────┘    │
│                                                          │
│  ┌────────────────────────────────────────────────┐    │
│  │        METHOD DECORATORS                        │    │
│  │  • @HostListener()                              │    │
│  └────────────────────────────────────────────────┘    │
│                                                          │
│  ┌────────────────────────────────────────────────┐    │
│  │        PARAMETER DECORATORS                     │    │
│  │  • @Inject()                                    │    │
│  │  • @Optional()                                  │    │
│  │  • @Self()                                      │    │
│  │  • @SkipSelf()                                  │    │
│  │  • @Host()                                      │    │
│  └────────────────────────────────────────────────┘    │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

---

## 1. Class Decorators

Class decorators are applied to class declarations and are used to modify or annotate the class.

### @Component

Marks a class as an Angular component and provides configuration metadata.

**Syntax:**
```typescript
@Component({
  selector: 'app-example',
  templateUrl: './example.component.html',
  styleUrls: ['./example.component.css']
})
export class ExampleComponent { }
```

**Properties:**

| Property | Description | Example |
|----------|-------------|---------|
| `selector` | CSS selector for the component | `'app-user'` |
| `templateUrl` | Path to HTML template | `'./user.component.html'` |
| `template` | Inline HTML template | `'<h1>Hello</h1>'` |
| `styleUrls` | Array of stylesheet paths | `['./user.component.css']` |
| `styles` | Inline styles | `['h1 { color: red; }']` |
| `providers` | Services for dependency injection | `[UserService]` |
| `standalone` | Standalone component (Angular 14+) | `true` |

**Example:**
```typescript
@Component({
  selector: 'app-user-profile',
  template: `
    <div class="profile">
      <h2>{{ userName }}</h2>
      <p>{{ email }}</p>
    </div>
  `,
  styles: [`
    .profile {
      padding: 20px;
      border: 1px solid #ccc;
    }
  `]
})
export class UserProfileComponent {
  userName = 'John Doe';
  email = 'john@example.com';
}
```

### @NgModule

Defines an Angular module and its metadata.

**Syntax:**
```typescript
@NgModule({
  declarations: [AppComponent, UserComponent],
  imports: [BrowserModule, FormsModule],
  providers: [UserService],
  bootstrap: [AppComponent]
})
export class AppModule { }
```

**Properties:**

| Property | Description |
|----------|-------------|
| `declarations` | Components, directives, pipes belonging to this module |
| `imports` | Other modules whose exported classes are needed |
| `exports` | Classes to make available to other modules |
| `providers` | Services available application-wide |
| `bootstrap` | Root component to bootstrap (only in root module) |

**Example:**
```typescript
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    FooterComponent
  ],
  imports: [
    BrowserModule,
    FormsModule
  ],
  providers: [
    DataService,
    AuthService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
```

### @Injectable

Marks a class as available for dependency injection.

**Syntax:**
```typescript
@Injectable({
  providedIn: 'root'
})
export class DataService { }
```

**Example:**
```typescript
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'  // Available throughout the application
})
export class UserService {
  private apiUrl = 'https://api.example.com/users';
  
  constructor(private http: HttpClient) { }
  
  getUsers() {
    return this.http.get(this.apiUrl);
  }
}
```

**providedIn Options:**

| Value | Description |
|-------|-------------|
| `'root'` | Single instance throughout the application |
| `'any'` | New instance for each lazy-loaded module |
| `ModuleName` | Available only in specific module |

### @Directive

Creates a custom directive.

**Example:**
```typescript
import { Directive, ElementRef, HostListener } from '@angular/core';

@Directive({
  selector: '[appHighlight]'
})
export class HighlightDirective {
  constructor(private el: ElementRef) { }
  
  @HostListener('mouseenter') onMouseEnter() {
    this.el.nativeElement.style.backgroundColor = 'yellow';
  }
  
  @HostListener('mouseleave') onMouseLeave() {
    this.el.nativeElement.style.backgroundColor = '';
  }
}
```

**Usage:**
```html
<p appHighlight>Hover over me!</p>
```

### @Pipe

Creates a custom pipe for transforming data in templates.

**Example:**
```typescript
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'exponential'
})
export class ExponentialPipe implements PipeTransform {
  transform(value: number, exponent: number = 1): number {
    return Math.pow(value, exponent);
  }
}
```

**Usage:**
```html
<p>{{ 2 | exponential:3 }}</p>  <!-- Output: 8 -->
```

---

## 2. Property Decorators

Property decorators are applied to class properties.

### @Input()

Allows data to flow from parent component to child component.

**Child Component:**
```typescript
import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-child',
  template: '<p>{{ childData }}</p>'
})
export class ChildComponent {
  @Input() childData: string = '';
  
  // With alias
  @Input('parentData') childData2: string = '';
}
```

**Parent Component:**
```html
<app-child [childData]="parentMessage"></app-child>
<app-child [parentData]="parentMessage"></app-child>
```

**Diagram:**
```
┌──────────────────────────────────┐
│      PARENT COMPONENT            │
│                                  │
│  data = "Hello"                  │
│                                  │
│  [childData]="data"              │
│         │                        │
│         │ @Input()               │
│         ▼                        │
│  ┌──────────────────────┐       │
│  │  CHILD COMPONENT     │       │
│  │                      │       │
│  │  @Input()            │       │
│  │  childData: string   │       │
│  └──────────────────────┘       │
└──────────────────────────────────┘
```

### @Output()

Allows data to flow from child component to parent component via events.

**Child Component:**
```typescript
import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-child',
  template: '<button (click)="sendData()">Send</button>'
})
export class ChildComponent {
  @Output() dataEvent = new EventEmitter<string>();
  
  sendData() {
    this.dataEvent.emit('Data from child');
  }
}
```

**Parent Component:**
```typescript
export class ParentComponent {
  receiveData(data: string) {
    console.log(data);
  }
}
```

```html
<app-child (dataEvent)="receiveData($event)"></app-child>
```

**Diagram:**
```
┌──────────────────────────────────┐
│      PARENT COMPONENT            │
│                                  │
│  (dataEvent)="receiveData($event)"
│         ▲                        │
│         │ @Output()              │
│         │                        │
│  ┌──────────────────────┐       │
│  │  CHILD COMPONENT     │       │
│  │                      │       │
│  │  @Output()           │       │
│  │  dataEvent = new     │       │
│  │  EventEmitter()      │       │
│  │                      │       │
│  │  sendData() {        │       │
│  │    emit('data')      │       │
│  │  }                   │       │
│  └──────────────────────┘       │
└──────────────────────────────────┘
```

### @ViewChild()

Provides access to a child component, directive, or DOM element.

**Example:**
```typescript
import { Component, ViewChild, ElementRef, AfterViewInit } from '@angular/core';

@Component({
  selector: 'app-parent',
  template: `
    <input #myInput type="text">
    <app-child></app-child>
  `
})
export class ParentComponent implements AfterViewInit {
  @ViewChild('myInput') inputElement!: ElementRef;
  @ViewChild(ChildComponent) childComponent!: ChildComponent;
  
  ngAfterViewInit() {
    console.log(this.inputElement.nativeElement.value);
    this.childComponent.someMethod();
  }
}
```

### @ViewChildren()

Provides access to multiple child components or elements.

**Example:**
```typescript
import { Component, ViewChildren, QueryList } from '@angular/core';

@Component({
  selector: 'app-parent',
  template: `
    <app-item *ngFor="let item of items"></app-item>
  `
})
export class ParentComponent {
  @ViewChildren(ItemComponent) itemComponents!: QueryList<ItemComponent>;
  
  items = [1, 2, 3, 4, 5];
  
  ngAfterViewInit() {
    console.log(this.itemComponents.length); // 5
  }
}
```

### @ContentChild() and @ContentChildren()

Access content projected into a component using `<ng-content>`.

**Example:**
```typescript
// Card Component
@Component({
  selector: 'app-card',
  template: `
    <div class="card">
      <ng-content></ng-content>
    </div>
  `
})
export class CardComponent {
  @ContentChild(CardHeaderComponent) header!: CardHeaderComponent;
  
  ngAfterContentInit() {
    console.log(this.header);
  }
}

// Usage
<app-card>
  <app-card-header>Title</app-card-header>
  <p>Content here</p>
</app-card>
```

### @HostBinding()

Binds a host element property to a component property.

**Example:**
```typescript
import { Directive, HostBinding, HostListener } from '@angular/core';

@Directive({
  selector: '[appHighlight]'
})
export class HighlightDirective {
  @HostBinding('style.backgroundColor') bgColor = 'transparent';
  @HostBinding('class.active') isActive = false;
  
  @HostListener('mouseenter')
  onMouseEnter() {
    this.bgColor = 'yellow';
    this.isActive = true;
  }
  
  @HostListener('mouseleave')
  onMouseLeave() {
    this.bgColor = 'transparent';
    this.isActive = false;
  }
}
```

---

## 3. Method Decorators

Method decorators are applied to class methods.

### @HostListener()

Listens to events on the host element.

**Example:**
```typescript
import { Directive, HostListener } from '@angular/core';

@Directive({
  selector: '[appClickTracker]'
})
export class ClickTrackerDirective {
  clickCount = 0;
  
  @HostListener('click', ['$event'])
  onClick(event: MouseEvent) {
    this.clickCount++;
    console.log(`Clicked ${this.clickCount} times`);
  }
  
  @HostListener('document:keydown', ['$event'])
  onKeyDown(event: KeyboardEvent) {
    console.log(`Key pressed: ${event.key}`);
  }
  
  @HostListener('window:resize', ['$event'])
  onResize(event: Event) {
    console.log('Window resized');
  }
}
```

**Common Events:**
- `click`, `dblclick`
- `mouseenter`, `mouseleave`
- `keydown`, `keyup`, `keypress`
- `focus`, `blur`
- `submit`
- `window:resize`
- `document:click`

---

## 4. Parameter Decorators

Parameter decorators are applied to constructor parameters for dependency injection.

### @Inject()

Specifies a dependency to inject.

**Example:**
```typescript
import { Component, Inject } from '@angular/core';
import { APP_CONFIG, AppConfig } from './app.config';

@Component({
  selector: 'app-root',
  template: '<h1>{{ title }}</h1>'
})
export class AppComponent {
  title: string;
  
  constructor(@Inject(APP_CONFIG) config: AppConfig) {
    this.title = config.appName;
  }
}
```

### @Optional()

Marks a dependency as optional (won't throw error if not provided).

**Example:**
```typescript
import { Component, Optional } from '@angular/core';
import { LoggerService } from './logger.service';

@Component({
  selector: 'app-example',
  template: '<p>Example</p>'
})
export class ExampleComponent {
  constructor(@Optional() private logger?: LoggerService) {
    if (this.logger) {
      this.logger.log('Component initialized');
    }
  }
}
```

### @Self()

Look for the dependency only in the current component's injector.

**Example:**
```typescript
import { Component, Self } from '@angular/core';
import { DataService } from './data.service';

@Component({
  selector: 'app-example',
  providers: [DataService]
})
export class ExampleComponent {
  constructor(@Self() private dataService: DataService) { }
}
```

### @SkipSelf()

Skip the current component's injector and look in parent injectors.

**Example:**
```typescript
import { Component, SkipSelf } from '@angular/core';
import { DataService } from './data.service';

@Component({
  selector: 'app-child'
})
export class ChildComponent {
  constructor(@SkipSelf() private dataService: DataService) {
    // Uses parent's DataService instance
  }
}
```

### @Host()

Look for dependency up to the host component.

**Example:**
```typescript
import { Component, Host } from '@angular/core';
import { FormComponent } from './form.component';

@Component({
  selector: 'app-input'
})
export class InputComponent {
  constructor(@Host() private form: FormComponent) { }
}
```

---

## Decorator Combinations

Multiple decorators can be used together:

**Example:**
```typescript
import { Component, Input, Output, EventEmitter, ViewChild } from '@angular/core';

@Component({
  selector: 'app-user-form',
  templateUrl: './user-form.component.html'
})
export class UserFormComponent {
  @Input() userId!: number;
  @Input() userName: string = '';
  
  @Output() formSubmit = new EventEmitter<any>();
  @Output() formCancel = new EventEmitter<void>();
  
  @ViewChild('userInput') userInput!: ElementRef;
  
  onSubmit() {
    this.formSubmit.emit({ id: this.userId, name: this.userName });
  }
  
  onCancel() {
    this.formCancel.emit();
  }
}
```

---

## Decorator Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    DECORATOR EXECUTION ORDER                 │
└─────────────────────────────────────────────────────────────┘

        ┌──────────────────────────┐
        │  CLASS DECORATOR         │
        │  @Component, @NgModule   │
        └────────────┬─────────────┘
                     │
                     ▼
        ┌──────────────────────────┐
        │  PROPERTY DECORATORS     │
        │  @Input, @Output         │
        └────────────┬─────────────┘
                     │
                     ▼
        ┌──────────────────────────┐
        │  METHOD DECORATORS       │
        │  @HostListener           │
        └────────────┬─────────────┘
                     │
                     ▼
        ┌──────────────────────────┐
        │  PARAMETER DECORATORS    │
        │  @Inject, @Optional      │
        └──────────────────────────┘
```

---

## Common Decorator Patterns

### 1. Component with Input/Output
```typescript
@Component({
  selector: 'app-user-card',
  template: `
    <div class="card">
      <h3>{{ user.name }}</h3>
      <button (click)="onDelete()">Delete</button>
    </div>
  `
})
export class UserCardComponent {
  @Input() user!: User;
  @Output() deleteUser = new EventEmitter<number>();
  
  onDelete() {
    this.deleteUser.emit(this.user.id);
  }
}
```

### 2. Service with Injection
```typescript
@Injectable({
  providedIn: 'root'
})
export class UserService {
  constructor(
    private http: HttpClient,
    @Inject(API_URL) private apiUrl: string
  ) { }
  
  getUsers() {
    return this.http.get(`${this.apiUrl}/users`);
  }
}
```

### 3. Directive with Host Bindings
```typescript
@Directive({
  selector: '[appTooltip]'
})
export class TooltipDirective {
  @Input('appTooltip') tooltipText: string = '';
  @HostBinding('attr.title') get title() {
    return this.tooltipText;
  }
  
  @HostListener('mouseenter')
  showTooltip() {
    console.log('Show:', this.tooltipText);
  }
}
```

---

## Summary Table

| Decorator | Type | Purpose | Example |
|-----------|------|---------|---------|
| `@Component` | Class | Define component | `@Component({selector: 'app-user'})` |
| `@NgModule` | Class | Define module | `@NgModule({declarations: []})` |
| `@Injectable` | Class | Enable DI | `@Injectable({providedIn: 'root'})` |
| `@Directive` | Class | Create directive | `@Directive({selector: '[app]'})` |
| `@Pipe` | Class | Create pipe | `@Pipe({name: 'custom'})` |
| `@Input()` | Property | Parent → Child data | `@Input() data: string` |
| `@Output()` | Property | Child → Parent events | `@Output() event = new EventEmitter()` |
| `@ViewChild()` | Property | Access child element | `@ViewChild('ref') element` |
| `@ViewChildren()` | Property | Access multiple children | `@ViewChildren(Component) list` |
| `@ContentChild()` | Property | Access projected content | `@ContentChild(Component) content` |
| `@HostBinding()` | Property | Bind host property | `@HostBinding('class.active')` |
| `@HostListener()` | Method | Listen to host events | `@HostListener('click')` |
| `@Inject()` | Parameter | Specify injection token | `constructor(@Inject(TOKEN))` |
| `@Optional()` | Parameter | Optional dependency | `constructor(@Optional())` |
| `@Self()` | Parameter | Current injector only | `constructor(@Self())` |
| `@SkipSelf()` | Parameter | Skip current injector | `constructor(@SkipSelf())` |

---

## Best Practices

1. **Use `@Input()` for data passing** - Prefer input properties over service sharing for parent-child communication
2. **Use `@Output()` for events** - Emit events from child to parent, not direct method calls
3. **Always use `@Injectable()`** - Even if not injecting anything, it's good practice for services
4. **Specify `providedIn: 'root'`** - For singleton services available app-wide
5. **Use `@ViewChild()` carefully** - Access only in `ngAfterViewInit()` lifecycle hook
6. **Combine decorators logically** - Group related decorators for better organization
7. **Use type safety** - Always specify types with decorators: `@Input() data!: string`
8. **Avoid optional inputs without defaults** - Provide default values for `@Input()` properties

---

## Conclusion

Decorators are fundamental to Angular development. They provide a clean, declarative way to configure components, services, and other Angular building blocks. Understanding decorators is essential for mastering Angular framework.
