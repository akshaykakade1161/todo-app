import React from 'react';
import TodoList from './components/TodoList';

const App: React.FC = () => {
  return (
    <div style={{ maxWidth: 600, margin: '0 auto', padding: 20 }}>
      <h1>Todo App</h1>
      <TodoList />
    </div>
  );
};

export default App;