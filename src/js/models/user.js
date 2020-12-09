const daoConnection = require('../daoConnection');
const Sequelize = require('sequelize');

class User extends Sequelize.Model {}

User.init(
    {
        UserID: {
            type: Sequelize.INTEGER,
            field: 'UserID',
            primaryKey: true,
            allowNull: false,
        },
        email: {
            type: Sequelize.STRING,
            field: 'email',
            allowNull: false,
            unique: true,
        },
        nickname: {
            type: Sequelize.STRING,
            field: 'nickname',
            allowNull: false,
            unique: true,
        },
        password: {
            type: Sequelize.STRING,
            field: 'password',
            allowNull: false,
        },
        confirmation: {
            type: Sequelize.BOOLEAN,
            field: 'confirmation',
            allowNull: false,
        },
        activationKey: {
            type: Sequelize.STRING,
            field: 'activationKey',
            allowNull: false,
            unique: true,
        }
    },
    {
        sequelize: daoConnection,
        modelName: 'user'
    }
);

module.exports = User