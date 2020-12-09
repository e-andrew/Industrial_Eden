const connection = require('../connection');
const Sequilize = require('sequelize');

class User extends Sequilize.Model {}

User.init(
    {
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
        modelName: 'user'
    }
);

module.exports = User