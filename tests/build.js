const db = require('../config/db');
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2');
const chalk = require('chalk');

const sql_script = fs.readFileSync(path.join(__dirname, '../src/sql/ddl.sql')).toString();

const connection_to_db = mysql.connect({
    host: db.host,
    user: db.username,
    password: db.password,
    database: db.database,
    multipleStatements: true,
});

connection_to_db.query(sql_script, (err, res) => {console.log(err, res);
  connection_to_db.end();})


process.exit(0);