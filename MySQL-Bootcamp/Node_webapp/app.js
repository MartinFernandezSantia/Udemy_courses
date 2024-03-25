var { faker } = require('@faker-js/faker');
var mysql = require('mysql2')

// Connect with database previously created in mysql terminal accessed by typing this command: mysql -u root -p
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Jumper789',
    database: 'join_us' 
});

// SELECTING DATA
// var q = 'SELECT * FROM users ';
// connection.query(q, function (error, results, fields) {
//     if (error) throw error;
//     console.log(results);
// });

// var q1 = 'SELECT COUNT(*) AS total FROM users ';
// connection.query(q1, function (error, results, fields) {
//     if (error) throw error;
//     console.log(results[0].total);
// });
//////////////////////////////////////////////////////////////

// INSERTING DATA
// var q = 'INSERT INTO users (email) VALUES ("rusty_the_dog@gmail.com")';
// connection.query(q, function (error, results, fields) {
//     if (error) throw error;
//     console.log(results);
// });


// var person = {
//     email: faker.internet.email(),
//     created_at: faker.date.past()
// };
// connection.query('INSERT INTO users SET ?', person, function(err, result) {
//     if (err) throw err;
//     console.log(result);
// });
//////////////////////////////////////////////////////////////////////////////////

// BULK INSERT
// var data = [];
// for(var i = 0; i < 500; i++){
//     data.push([
//         faker.internet.email(),
//         faker.date.past()
//     ]);
// }

// var q = 'INSERT INTO users (email, created_at) VALUES ?';

// connection.query(q, [data], function(err, result) {
//     console.log(err);
//     console.log(result);
// });

var express = require('express');
var bodyParser = require("body-parser");
var app = express();

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({extended: true}));

app.listen(8080, function () {
    console.log('App listening on port 8080!');
});


app.get("/", function(req, res){
    q = "SELECT COUNT(*) as count FROM users"
    connection.query(q, function (error, results, fields) {
        if (error) throw error;
        var count = results[0].count
        res.render("home", {count: count});
    });
});

app.get('/register', function(req,res){
    res.redirect("/");
});

app.post('/register', function(req,res){
    var person = {email: req.body.email};
    connection.query('INSERT INTO users SET ?', person, function(err, result) {
        console.log(err);
        console.log(result);
        res.redirect("/");
    });
});   


