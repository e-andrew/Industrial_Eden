const connection = require('../connection');
const Sequilize = require('sequelize');

const User = require('./user.js');

class Review extends Sequilize.Model {}

Review.init(
    {
        topic: {
            type: Sequilize.STRING(45),
            allowNull: false
        },
        text: {
            type: Sequilize.STRING(1000),
            allowNull: false
        },
        author_id: {
            type: Sequilize.INTEGER,
            allowNull: false,
            references: {
                model: User,
                key: 'UserID'
            }
        }
    },
    {
        sequelize: connection,
        freezeTableName: true,
        modelName: 'Review'
    }
);

User.hasMany(Review, {
    foreignKey: 'author_id'
});

Review.belongsTo(User);

module.exports = Review