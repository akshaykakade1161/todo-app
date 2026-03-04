import React, { useState, useEffect } from 'react';
import axios from '../services/api';
import TodoItem from './TodoItem';

interface Todo {
  id: string;
  text: string;
  completed: boolean;
}

const TodoList: React.FC = () => {
  const [todos, setTodos] = useState<Todo[]>([]);
  const [newText, setNewText] = useState('');

  const fetchTodos = async () => {
    const { data } = await axios.get('/api/todos');
    setTodos(data);
  };

  useEffect(() => {
    fetchTodos();
  }, []);

  const addTodo = async () => {
    if (!newText.trim()) return;
    await axios.post('/api/todos', { text: newText });
    setNewText('');
    fetchTodos();
  };

  const toggleTodo = async (id: string) => {
    const todo = todos.find((t) => t.id === id);
    if (!todo) return;
    await axios.patch(`/api/todos/${id}`, { completed: !todo.completed });
    fetchTodos();
  };

  const deleteTodo = async (id: string) => {
    await axios.delete(`/api/todos/${id}`);
    fetchTodos();
  };

  return (
    <div>
      <div style={{ display: 'flex', marginBottom: 16 }}>
        <input
          type="text"
          value={newText}
          onChange={(e) => setNewText(e.target.value)}
          style={{ flexGrow: 1, marginRight: 8 }}
        />
        <button onClick={addTodo}>Add</button>
      </div>
      <ul style={{ listStyle: 'none', padding: 0 }}>
        {todos.map((todo) => (
          <TodoItem
            key={todo.id}
            todo={todo}
            onToggle={toggleTodo}
            onDelete={deleteTodo}
          />
        ))}
      </ul>
    </div>
  );
};

export default TodoList;