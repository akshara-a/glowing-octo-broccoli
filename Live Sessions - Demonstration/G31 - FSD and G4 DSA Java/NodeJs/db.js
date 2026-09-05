import 'dotenv/config';
import { neon } from '@neondatabase/serverless';
import { drizzle } from 'drizzle-orm/neon-http';
import { pgTable, serial, text, boolean, timestamp } from 'drizzle-orm/pg-core';

// The schema tells Drizzle ORM how the todos table looks in PostgreSQL.
// Drizzle uses this object when we write insert, select, update, and delete queries.
export const todos = pgTable('todos', {
  id: serial('id').primaryKey(),
  title: text('title').notNull(),
  completed: boolean('completed').notNull().default(false),
  createdAt: timestamp('created_at').notNull().defaultNow(),
  updatedAt: timestamp('updated_at').notNull().defaultNow(),
});

if (!process.env.DATABASE_URL) {
  throw new Error('DATABASE_URL is missing. Add your NeonDB connection string to a .env file.');
}

// Neon gives us a serverless PostgreSQL connection using the DATABASE_URL string.
// Drizzle wraps that connection and gives us ORM methods instead of hand-written SQL.
export const sql = neon(process.env.DATABASE_URL);
export const db = drizzle(sql);

// This keeps the demo simple for a live session: the table is created automatically
// when the server starts. In production projects, use migrations instead.
export async function createTodosTable() {
  await sql`
    CREATE TABLE IF NOT EXISTS todos (
      id SERIAL PRIMARY KEY,
      title TEXT NOT NULL,
      completed BOOLEAN NOT NULL DEFAULT false,
      created_at TIMESTAMP NOT NULL DEFAULT NOW(),
      updated_at TIMESTAMP NOT NULL DEFAULT NOW()
    )
  `;
}
