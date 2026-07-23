import { Component, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-root',
  imports: [FormsModule],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  title = 'Header'

  name = '';
  message = '';

  showGreeting(): void {
    if (this.name.trim()) {
      this.message = `Hello, ${this.name}`;
    }
    else {
      this.message = "Please enter a valid name"
    }
  }
}
