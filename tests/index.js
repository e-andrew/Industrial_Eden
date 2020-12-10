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
        console.log(toTable(usersList, "nickname", "email", "password"))
    })


Review.findAll({
     attributes: ["topic", "text", "AuthorID"]
})
    .then(reviewsList => {
    console.log(chalk.green(`
Reviews List`));
    console.log(toTable(reviewsList, "topic", "text", "AuthorID"))
})    

Review.findAll({
        attributes: ["topic", "text", "AuthorID"],
        include: [{
            model: User,
            attributes: ["nickname", "email"]
        }]
    })
    .then( reviews => {
        console.log(chalk.green(`
Review Authors List`));
        console.log(toTable(reviews,"topic", "text", "AuthorID", 'User.nickname', 'User.email'))})
