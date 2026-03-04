import React from 'react';
interface Props {
  todo: { id: string; text: string; completed: boolean };
  onToggle: (id: string) => void;
  onDelete: (id: string) => void;
}

const TodoItem: React.FC<Props> = ({ todo, onToggle, onDelete }) => {
  return (
    <li style={{ marginBottom: 8, display: 'flex', alignItems: 'center' }}>
      <input
        type="checkbox"
        checked={todo.completed}
        onChange={() => onToggle(todo.id)}
        style={{ marginRight: 8 }}
      />
      <span style={{ flexGrow: 1 }}>{todo.text}</span>
      <button onClick={() => onDelete(todo.id)} style={{ marginLeft: 8 }}>
        ✕
      </button>
    </li>
  );
};

export default TodoItem;