const config = require('../config/db');
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2');
const chalk = require('chalk');

const sql = fs.readFileSync(path.join(__dirname, '../src/sql/ddl.sql')).toString();


const connection = mysql.createConnection({
    host: config.host,
    user: config.username,
    password: config.password,
    database: config.database,
    multipleStatements: true
});

connection.query(sql, function (error) {
    if (error) throw error;
});

process.exit(0);