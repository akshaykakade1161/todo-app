import sqlite3 from 'sqlite3';
import { Request, Response } from 'express';
import { Router } from 'express';
import { v4 as uuidv4 } from 'uuid';

const router = Router();
const db = new sqlite3.Database('todos.sqlite', sqlite3.OPEN_READWRITE | sqlite3.OPEN_CREATE);

// Create table if not exists
const createTable = `
  CREATE TABLE IF NOT EXISTS todos (
    id TEXT PRIMARY KEY,
    text TEXT NOT NULL,
    completed INTEGER NOT NULL DEFAULT 0
  );
`;

db.run(createTable);

// Get all todos
router.get('/todos', (req: Request, res: Response) => {
  db.all('SELECT * FROM todos', [], (err, rows) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.json(rows.map(r => ({ ...r, completed: !!r.completed })))
  });
});

// Create a todo
router.post('/todos', (req: Request, res: Response) => {
  const { text } = req.body;
  const id = uuidv4();
  db.run('INSERT INTO todos (id, text, completed) VALUES (?, ?, 0)', [id, text], function(err) {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.status(201).json({ id, text, completed: false });
  });
});

// Update a todo
router.patch('/todos/:id', (req: Request, res: Response) => {
  const { id } = req.params;
  const { text, completed } = req.body;
  const updates = [];
  const params = [];
  if (text !== undefined) {
    updates.push('text = ?');
    params.push(text);
  }
  if (completed !== undefined) {
    updates.push('completed = ?');
    params.push(completed ? 1 : 0);
  }
  if (updates.length === 0) {
    res.status(400).json({ error: 'No fields to update' });
    return;
  }
  params.push(id);
  const sql = `UPDATE todos SET ${updates.join(', ')} WHERE id = ?`;
  db.run(sql, params, function(err) {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    if (this.changes === 0) {
      res.status(404).json({ error: 'Todo not found' });
      return;
    }
    db.get('SELECT * FROM todos WHERE id = ?', [id], (err, row) => {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      res.json({ ...row, completed: !!row.completed });
    });
  });
});

// Delete a todo
router.delete('/todos/:id', (req: Request, res: Response) => {
  const { id } = req.params;
  db.run('DELETE FROM todos WHERE id = ?', [id], function(err) {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    if (this.changes === 0) {
      res.status(404).json({ error: 'Todo not found' });
      return;
    }
    res.status(204).send();
  });
});

export default router;
