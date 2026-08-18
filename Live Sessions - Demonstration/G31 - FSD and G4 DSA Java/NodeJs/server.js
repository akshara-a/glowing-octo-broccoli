const express = require('express');

const app = express();
const port = 3200;

// Middleware to parse JSON requests
app.use(express.json());

// Sample route
app.get('/api/sample', (req, res) => {
  res.send('Hello, World!');
});


// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});