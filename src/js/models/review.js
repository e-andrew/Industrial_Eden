const daoConnection = require('../daoConnection');
const Sequelize = require('sequelize');
const User = require('./user.js')

class Review extends Sequelize.Model {}

Review.init(
    {
        ReviewID: {
            type: Sequelize.INTEGER,
            field: 'ReviewID',
            primaryKey: true,
            allowNull: false,
        },
        topic: {
            type: Sequelize.STRING,
            field: 'topic',
            allowNull: false,
        },
        text: {
            type: Sequelize.STRING,
            field: 'text',
            allowNull: false,
        },
        AuthorID: {
            type: Sequelize.INTEGER,
            field: 'AuthorID',
            allowNull: false,
        }
    },
    {
        sequelize: daoConnection,
        tableName: 'Review'
    }
);

User.belongsToMany(Review, {
    through: 'Review',
    timestamps: false,
    foreignKey: 'AuthorID'
});

module.exports = Review