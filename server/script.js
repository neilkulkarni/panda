// server.js

// BASE SETUP
// =============================================================================

// call the packages we need
var express    = require('express');        // call express
var app        = express();                 // define our app using express
var bodyParser = require('body-parser');
var fs = require("fs");

var mysql = require("mysql");
var myDBF = 'schema.sql';

var sqlFile = fs.readFileSync('schema.sql').toString();


var conn = mysql.createConnection({ //you need to run a sqlserver with a database called user
    host     : 'sql9.freemysqlhosting.net',
    user     : 'sql9165914',
    password : 'qA5Y91n4CE', //use your own password
    database : 'sql9165914'
});

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());



var port = process.env.PORT || 8081;        // set our port
var qs = require('querystring');

// ROUTES FOR OUR API
// =============================================================================
var router = express.Router();              // get an instance of the express Router


// route create a user (accessed at POST http://localhost:8081/users)
router.post('/user', function(request, response) {
	var q = request.body; 
	var user = {
		name: q.name, 
        email: q.email,
        password: q.password,
        bio: q.bio,
        picture: q.picture
	} 
	conn.query('SELECT * FROM user', function(err, result) {
        var error = 0;
        for (var i = 0; i < result.length; i++) {
            if (result[i].email == q.email.toLowerCase()) {
                console.log('User exists.');

                var code = { code: 400 };	
                response.send(code); 

                error = 1;
                break;
            }
        }

        if(error == 0) {
            conn.query('INSERT INTO user SET ?', user, function(err, result) {
                console.log('Added user');

                var code = { code: 200 };
                response.send(code);
                
                console.log(user);
            });
        }
    });
});



router.put('/user', function(request, response) {
    var q = request.body;
    var id = q.id;
    var bio = q.bio;
    var picture = q.picture;
    
    console.log(q);
    
    conn.query('SELECT * FROM user', function(err, result) {
        var error = 1;
        for (var i = 0; i < result.length; i++) {
            if (result[i].id == q.id) {
                console.log('User exists.');

                conn.query('UPDATE user SET bio=?, picture=? WHERE id=?', [bio, picture, id], function(err, result) {
                    var code = { code: 200 };	
                    response.send(code); 
                });
                
                error = 0;
                break;
            }
        }
        
        if (error == 1) {    
                var code = { code: 400 };	
                response.send(code); 
        }
    });
});
      

// route get all users (accessed at GET http://localhost:8081/users)
router.get('/users', function(request, response) {        
	var userList = [];
    conn.query('SELECT * FROM user', function(err, result) {
        for (var i = 0; i < result.length; i++) {
            var tempUser = { 
                id: result[i].id, 
                name: result[i].name, 
                email: result[i].email, 
                bio: result[i].bio,
                picture: result[i].picture
            };
        
            userList.push(tempUser);
        }
        
        response.json({ userList });
    });
});

// route get a user (accessed at GET http://localhost:8081/user/{id})
router.get('/user/:id', function(request, response) {
    var userID = request.params.id;
    var user;
    conn.query('SELECT * FROM user WHERE id=?', [userID], function(err, result) {
        user = {
            id: result[0].id, 
            name: result[0].name, 
            email: result[0].email, 
            bio: result[0].bio,
            picture: result[0].picture
        };
        
        response.json({ user });
    });
});

router.get('/login', function(request, response) {
    var email = request.query.email;
    var password = request.query.password;
    var user;
    conn.query('SELECT * FROM user', function(err, result) {
        for (var i = 0; i < result.length; i++) {
            if (result[i].email == email && result[i].password == password) {
                user = { 
                    id: result[i].id, 
                    name: result[i].name, 
                    email: result[i].email, 
                    password: result[i].password,
                    bio: result[i].bio,
                    picture: result[i].picture
                };

                break;
            }
        }
        
        response.json({ user });
    });
});

// REGISTER OUR ROUTES -------------------------------
// all of our routes will be not be prefixed
app.use('', router);

// START THE SERVER
// =============================================================================
app.listen(port);
