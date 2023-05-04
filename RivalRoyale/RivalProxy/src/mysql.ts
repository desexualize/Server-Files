const mysql = require('mysql');

// Connect to database
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'rival_royale',
});

connection.connect();
module.exports = connection;
