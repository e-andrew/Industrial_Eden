const models = require('./models');

const userMapper = (user) => {
    console.log(user.UserID + ' | ' + user.nickname + ' | ' + user.email);
};

const reviewMapper = (review) => {
    console.log('#' + review.ReviewID + ' | ' + review.topic);
};


(async () => {
    console.log('--------');
    console.log('Users list');
    console.log('--------');
    const usersList = await models.User.findAll();
    usersList.map(userMapper);


    console.log('\n--------');
    console.log('Reviews List');
    console.log('--------');
    const reviewsList = (await models.Review.findAll());
    reviewsList.map(reviewMapper);

    console.log('\n\n--------');
    console.log('Review - User');
    console.log('--------');
    // const reviews = await models.Review.findAll({
    //     include: [{
    //         model: models.User,
    //         through: {
    //             attributes: ['role']
    //         }
    //     }]
    // });
    reviews.map(project => {
        console.log('#' + review.ReviewID + ' | ' + review.topic);
        review.users.map(user => {
            console.log(user.UserID + ' | ' + user.nickname + ' | ' + user.email);
        });
    })
})();