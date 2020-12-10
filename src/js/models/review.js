const connection = require('../connection');
const Sequilize = require('sequelize');

const User = require('./user.js');

class Review extends Sequilize.Model {}

Review.init(
    {
        ReviewID: {
            type: Sequilize.INTEGER,
            primaryKey: true
        },
        topic: {
            type: Sequilize.STRING(45),
            allowNull: false
        },
        text: {
            type: Sequilize.STRING(1000),
            allowNull: false
        },
        AuthorID: {
            type: Sequilize.INTEGER,
            allowNull: false,
        }
    },
    {
        sequelize: connection,
        freezeTableName: true,
        modelName: 'Review'
    }
);

User.hasMany(Review);

Review.belongsTo(User, {
    foreignKey: 'AuthorID'
});

module.exports = Review