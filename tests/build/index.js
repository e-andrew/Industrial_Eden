const dbConfig = require('../../src/js/dbConfig');
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2');

const sqlScript = fs.readFileSync(path.join(__dirname, '../../src/sql/ddl.sql')).toString();

const connection = mysql.connect({
    host: dbConfig.host,
    user: dbConfig.username,
    password: dbConfig.password,
    database: dbConfig.database,
    multipleStatements: true
});

connection.query(sqlScript, function (error) {
    if (error) throw error;
});

process.exit(0);