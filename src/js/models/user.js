const connection = require('../connection');
const Sequilize = require('sequelize');

class User extends Sequilize.Model {}

User.init(
    {
        UserID: {
            type: Sequilize.INTEGER,
            primaryKey: true
        },
        email: {
            type: Sequilize.STRING(30),
            allowNull: false,
            unique: true
        },
        nickname: {
            type: Sequilize.STRING(20),
            allowNull: false,
            unique: true
        },
        password: {
            type: Sequilize.STRING(20),
            allowNull: false,
            unique: true
        }
    },
    {
        sequelize: connection,
        freezeTableName: true,
        modelName: 'User'
    }
);

module.exports = User