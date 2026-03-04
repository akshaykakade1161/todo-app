import express from 'express';
import { json } from 'body-parser';
import todoRouter from './routes/todos';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(json());
app.use('/api', todoRouter);

app.listen(PORT, () => {
  console.log(`Backend running on http://localhost:${PORT}`);
});