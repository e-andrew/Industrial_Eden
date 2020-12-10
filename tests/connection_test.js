const connection = require('../src/js/connection');
const chalk = require('chalk');

(async () => {
    try {
        await connection.authenticate();
        console.log(chalk.green('Connection has been established successfully.'));
        process.exit(0);
    } catch (error) {
        console.log(chalk.red('Database connection not established!'));
        process.exit(0);
    }
})();