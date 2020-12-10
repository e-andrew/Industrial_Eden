const User = require("../src/js/models/user")
const Review = require("../src/js/models/review")
const Table = require("cli-table3")
const _ = require("lodash-node")
const chalk = require("chalk")

const userMapper = (...fields) => fields.join(' | ')
const reviewMapper = review => `#${review.topic} | ${review.creationdate}`

const toTable =  (data, ...fields) => {
    let res = new Table( { head: fields.map( f => _.last(f.split("."))) } )
    data.forEach(item => {
        let d = []
        fields.forEach( field => {
            d.push( _.get(item, field) || " ")
        })
        res.push(d) 
    })
    return res.toString()
}


User.findAll({
    attributes: ["nickname", "email", "password"]
}).then(usersList => {
        console.log(chalk.green(`
Users list`));
        // console.log( usersList.map(user => userMapper(user.id, user.email, user.nickname)).join("\n"));
        console.log(toTable(usersList, "nickname", "email", "password"))
    })


Review.findAll({
     attributes: ["topic", "text"]
})
    .then(reviewsList => {
    console.log(chalk.green(`
Reviews List`));
    // console.log(projectsList.map(projectMapper).join("\n"))
    console.log(toTable(reviewsList, "topic", "text"))
})    

// models.Review.findAll({
//         include: [{
//             model: models.User,
//             through: {
//                 attributes: ['author_id']
//             }
//         }]
//     })
//     .then( reviews => {
//         console.log(chalk.green(`
// Review Authors List`));
// //         console.log(projects.map( project => `${project.name} (#${project.id})
// // ${project.users.map(user => userMapper(user.id, user.name, user.project_user.dataValues.role)).join("\n")}
// // `).join("\n"))
    
//         console.log(reviews.map( review => `Review: ${review.topic} (#${review.creationdate})
// ${toTable(review.users,"id","name", "project_user.dataValues.role")}
// `).join("\n"))

//     })