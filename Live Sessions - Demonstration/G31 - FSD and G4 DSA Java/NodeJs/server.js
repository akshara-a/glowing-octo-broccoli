import express from 'express';
import { asc, eq } from 'drizzle-orm';
import { createTodosTable, db, todos } from './db.js';

const app = express();
const port = process.env.PORT || 3200;

// Middleware to parse JSON requests
app.use(express.json());

// Health route to confirm the API is running.
app.get('/', (req, res) => {
  res.json({
    message: 'Todo API is running',
    routes: ['GET /api/todos', 'POST /api/todos', 'PATCH /api/todos/:id', 'DELETE /api/todos/:id'],
  });
});

// GET /api/todos
// Reads all todos from NeonDB using Drizzle ORM.
app.get('/api/todos', async (req, res, next) => {
  try {
    const allTodos = await db.select().from(todos).orderBy(asc(todos.id));
    res.json(allTodos);
  } catch (error) {
    next(error);
  }
});

// POST /api/todos
// Creates a new todo. The title comes from the request body.
app.post('/api/todos', async (req, res, next) => {
  try {
    if (typeof req.body.title !== 'string') {
      return res.status(400).json({ error: 'Todo title is required.' });
    }

    const title = req.body.title.trim();

    if (!title) {
      return res.status(400).json({ error: 'Todo title is required.' });
    }

    const [newTodo] = await db.insert(todos).values({ title }).returning();
    res.status(201).json(newTodo);
  } catch (error) {
    next(error);
  }
});

// PATCH /api/todos/:id
// Edits a todo title, completion status, or both.
app.patch('/api/todos/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);

    if (!Number.isInteger(id)) {
      return res.status(400).json({ error: 'Todo id must be a number.' });
    }

    const changes = {};

    if (req.body.title !== undefined) {
      if (typeof req.body.title !== 'string') {
        return res.status(400).json({ error: 'Todo title must be text.' });
      }

      const title = req.body.title.trim();

      if (!title) {
        return res.status(400).json({ error: 'Todo title cannot be empty.' });
      }

      changes.title = title;
    }

    if (req.body.completed !== undefined) {
      if (typeof req.body.completed !== 'boolean') {
        return res.status(400).json({ error: 'Completed must be true or false.' });
      }

      changes.completed = req.body.completed;
    }

    if (Object.keys(changes).length === 0) {
      return res.status(400).json({ error: 'Send title, completed, or both to update a todo.' });
    }

    changes.updatedAt = new Date();

    const [updatedTodo] = await db.update(todos).set(changes).where(eq(todos.id, id)).returning();

    if (!updatedTodo) {
      return res.status(404).json({ error: 'Todo not found.' });
    }

    res.json(updatedTodo);
  } catch (error) {
    next(error);
  }
});

// DELETE /api/todos/:id
// Deletes one todo by id.
app.delete('/api/todos/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);

    if (!Number.isInteger(id)) {
      return res.status(400).json({ error: 'Todo id must be a number.' });
    }

    const [deletedTodo] = await db.delete(todos).where(eq(todos.id, id)).returning();

    if (!deletedTodo) {
      return res.status(404).json({ error: 'Todo not found.' });
    }

    res.json({ message: 'Todo deleted successfully.', todo: deletedTodo });
  } catch (error) {
    next(error);
  }
});

// Central error handler. Any route can call next(error), and Express sends one clean response.
app.use((error, req, res, next) => {
  console.error(error);
  res.status(500).json({ error: 'Something went wrong on the server.' });
});

// Create the table first, then start the server.
createTodosTable()
  .then(() => {
    app.listen(port, () => {
      console.log(`Server is running on http://localhost:${port}`);
    });
  })
  .catch((error) => {
    console.error('Failed to start the server:', error);
    process.exit(1);
  });
