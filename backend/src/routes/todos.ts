import express, { Request, Response } from 'express';
import Database from 'better-sqlite3';
import { v4 as uuidv4 } from 'uuid';

const router = express.Router();
const db = new Database('todos.sqlite');

// Create table if it doesn't exist
db.prepare(`
  CREATE TABLE IF NOT EXISTS todos (
    id TEXT PRIMARY KEY,
    text TEXT NOT NULL,
    completed INTEGER NOT NULL DEFAULT 0
  );
`).run();

// Get all todos
router.get('/todos', (req: Request, res: Response) => {
  const rows = db.prepare('SELECT * FROM todos').all();
  res.json(rows);
});

// Create a new todo
router.post('/todos', (req: Request, res: Response) => {
  const { text } = req.body;
  const id = uuidv4();
  db.prepare('INSERT INTO todos (id, text, completed) VALUES (?, ?, 0)').run(id, text);
  res.status(201).json({ id, text, completed: false });
});

// Update a todo
router.patch('/todos/:id', (req: Request, res: Response) => {
  const { id } = req.params;
  const { text, completed } = req.body;
  const stmt = db.prepare('UPDATE todos SET text = COALESCE(?, text), completed = COALESCE(?, completed) WHERE id = ?');
  const info = stmt.run(text, completed, id);
  if (info.changes === 0) {
    return res.status(404).json({ error: 'Todo not found' });
  }
  const row = db.prepare('SELECT * FROM todos WHERE id = ?').get(id);
  res.json(row);
});

// Delete a todo
router.delete('/todos/:id', (req: Request, res: Response) => {
  const { id } = req.params;
  const info = db.prepare('DELETE FROM todos WHERE id = ?').run(id);
  if (info.changes === 0) {
    return res.status(404).json({ error: 'Todo not found' });
  }
  res.status(204).send();
});

export default router;