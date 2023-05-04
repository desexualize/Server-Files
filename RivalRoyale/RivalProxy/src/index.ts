import express, { Application, Request, Response } from 'express';

const cors = require('cors');
const app: express.Application = express();
const PORT = process.env.PORT || 5050;

// Middleware
app.use(cors({ origin: 'http://localhost:30120', methods: ['GET', 'POST', 'PUT', 'DELETE'] }));
app.use(express.json({ limit: '128mb' }));
app.use(express.static('stream'));
app.use(express.urlencoded({ extended: false }));

// Routes
app.use('/recording', require('./routes/Recording'));

// Start server
app.listen(PORT, () => console.log(`Server started at ${PORT}`));
