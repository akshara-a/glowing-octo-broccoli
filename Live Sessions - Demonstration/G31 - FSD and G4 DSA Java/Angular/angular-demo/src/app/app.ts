import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink, RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  imports: [FormsModule, RouterLink, RouterOutlet],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  title = 'Header';

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
