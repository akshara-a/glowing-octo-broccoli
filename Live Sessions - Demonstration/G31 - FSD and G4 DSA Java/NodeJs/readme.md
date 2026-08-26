# Node.js Todo API with NeonDB and Drizzle ORM

This project is a simple backend API for a todo list. It uses:

- Node.js to run JavaScript on the server
- Express to create API routes
- NeonDB as the hosted PostgreSQL database
- Drizzle ORM to write database queries using JavaScript objects and methods
- dotenv to read the database connection string from a `.env` file

The API supports the main todo actions:

- Add a todo
- View all todos
- Edit a todo title or completed status
- Delete a todo

## Folder Files

```text
NodeJs/
  db.js          Database connection and todos table schema
  server.js      Express API routes
  package.json   Project dependencies and scripts
  .env.example   Example environment variables
  readme.md      Project explanation
```

## What Is NeonDB?

NeonDB is a cloud PostgreSQL database. PostgreSQL stores data in tables, rows, and columns.

For this todo API, the database has one table named `todos`.

Each todo row stores:

- `id`: unique number for the todo
- `title`: todo text
- `completed`: true or false value
- `created_at`: when the todo was created
- `updated_at`: when the todo was last edited

## What Is an ORM?

ORM means Object Relational Mapper.

Normally, we write SQL like this:

```sql
SELECT * FROM todos;
```

With Drizzle ORM, we can write database code in JavaScript:

```js
const allTodos = await db.select().from(todos);
```

The ORM helps us map JavaScript code to database tables.

## Setup Steps

### 1. Install Dependencies

Run this inside the `NodeJs` folder:

```bash
npm install
```

### 2. Create a NeonDB Database

1. Go to the Neon website.
2. Create a new project.
3. Copy the PostgreSQL connection string.
4. The connection string will look similar to this:

```text
postgresql://username:password@ep-example-123456.us-east-2.aws.neon.tech/neondb?sslmode=require
```

### 3. Create the `.env` File

Create a file named `.env` in the `NodeJs` folder.

Copy the values from `.env.example`:

```env
DATABASE_URL=your_neondb_connection_string_here
PORT=3200
```

Replace `your_neondb_connection_string_here` with your actual NeonDB connection string.

Do not commit the real `.env` file to GitHub because it contains your database password.

### 4. Start the Server

For normal start:

```bash
npm start
```

For development with automatic restart:

```bash
npm run dev
```

The server runs at:

```text
http://localhost:3200
```

When the server starts, `db.js` creates the `todos` table if it does not already exist.

## How the Code Works

### `db.js`

This file handles the database.

```js
import 'dotenv/config';
```

This loads variables from the `.env` file into `process.env`.

```js
export const sql = neon(process.env.DATABASE_URL);
export const db = drizzle(sql);
```

This connects to NeonDB and gives the project a Drizzle ORM database object.

```js
export const todos = pgTable('todos', {
  id: serial('id').primaryKey(),
  title: text('title').notNull(),
  completed: boolean('completed').notNull().default(false),
  createdAt: timestamp('created_at').notNull().defaultNow(),
  updatedAt: timestamp('updated_at').notNull().defaultNow(),
});
```

This defines the todo table structure for Drizzle.

### `server.js`

This file creates the Express server and API routes.

```js
app.use(express.json());
```

This allows Express to read JSON request bodies.

Example request body:

```json
{
  "title": "Learn Node.js"
}
```

## API Routes

### Health Check

```http
GET /
```

Checks if the API is running.

### Get All Todos

```http
GET /api/todos
```

Returns all todos from the database.

Example response:

```json
[
  {
    "id": 1,
    "title": "Learn Node.js",
    "completed": false,
    "createdAt": "2026-08-20T10:00:00.000Z",
    "updatedAt": "2026-08-20T10:00:00.000Z"
  }
]
```

### Add a Todo

```http
POST /api/todos
```

Request body:

```json
{
  "title": "Build a todo API"
}
```

Example curl command:

```bash
curl -X POST http://localhost:3200/api/todos ^
  -H "Content-Type: application/json" ^
  -d "{\"title\":\"Build a todo API\"}"
```

### Edit a Todo

```http
PATCH /api/todos/:id
```

Use this route to update the todo title, completed status, or both.

Request body:

```json
{
  "title": "Build a todo API with NeonDB",
  "completed": true
}
```

Example curl command:

```bash
curl -X PATCH http://localhost:3200/api/todos/1 ^
  -H "Content-Type: application/json" ^
  -d "{\"title\":\"Build a todo API with NeonDB\",\"completed\":true}"
```

### Delete a Todo

```http
DELETE /api/todos/:id
```

Example curl command:

```bash
curl -X DELETE http://localhost:3200/api/todos/1
```

## Request Validation

The API checks basic input before saving data:

- A todo title is required when adding a todo.
- A todo title cannot be empty when editing.
- The todo id must be a number.
- `completed` must be `true` or `false`.
- If a todo id does not exist, the API returns `404`.

## Important Concepts

### Express

Express is used to create routes such as:

```js
app.get('/api/todos', async (req, res) => {
  // route logic
});
```

### Route Parameters

In this route:

```js
app.patch('/api/todos/:id', ...)
```

`:id` is a route parameter. If the request URL is `/api/todos/5`, then `req.params.id` is `5`.

### Async and Await

Database operations take time, so the API uses `async` and `await`.

```js
const allTodos = await db.select().from(todos);
```

This means: wait for the database query to finish, then store the result in `allTodos`.

## Testing Order

Test the API in this order:

1. Start the server with `npm run dev`.
2. Open `http://localhost:3200`.
3. Add a todo using `POST /api/todos`.
4. View todos using `GET /api/todos`.
5. Edit a todo using `PATCH /api/todos/1`.
6. Delete a todo using `DELETE /api/todos/1`.

## Summary

This project shows how a backend API works with a real database:

- Express receives HTTP requests.
- Drizzle ORM converts JavaScript database methods into SQL queries.
- NeonDB stores the todo data permanently.
- The API sends JSON responses back to the client.
