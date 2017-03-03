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
    host     : 'localhost',
    user     : 'root',
    password : 'Richmond5223', //use your own password
    database : 'user'
});

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());



var port = process.env.PORT || 8080;        // set our port
var qs = require('querystring');

// ROUTES FOR OUR API
// =============================================================================
var router = express.Router();              // get an instance of the express Router

// test route to make sure everything is working (accessed at GET http://localhost:8080/api)
/*router.get('/', function(req, res) {
    res.json({ message: 'hooray! welcome to our api!' });
});*/

// manually adding one user to the database  


// test route for users (accessed at GET http://localhost:8080/api/users

router.post("/rq", function (request, res) {
        var body = '';
        request.on('data', function (data) {
            body += data;

            // Too much POST data, kill the connection!
            // 1e6 === 1 * Math.pow(10, 6) === 1 * 1000000 ~~~ 1MB
        });

        request.on('end', function () {

 
            var post = qs.unescape(body);
            var str = '' + post;
            var res = str.split("\"");                                                                              
            var user = {
                        name: (res[3].toLowerCase()), 
                        email: (res[7].toLowerCase()),
                        password: res[11]
                        
                    };
                 console.log(user);
            conn.query('select * from user', function(err, result) {
            	var error = 0;
        
        		for (var i = 0; i < result.length; i++) {


            		if(((result[i].email) + "").localeCompare((res[7].toLowerCase())) == 0) {
            			console.log('Alright found user');
            	//		res.render('Name or email found');
            			
            		error = 1;
            		break;
            			
        			}
        			  
                
                }
                
                if(error == 0) {

                conn.query('insert into user set ?', user, function(err, result) {
                      console.log('Added user');
                    //  res.render('Added user');
                  
            		 
                    });
            }
            });
     });
        res.end();
    });
         
         
      

router.get('/users', function(req, res) {        
	res.json({ userList });
});


var userList = [];
conn.query('select * from user', function(err, result) {
for (var i = 0; i < result.length; i++) {
        var tempUser = { name: result[i].name , email: result[i].email, password: result[i].password };
        userList[i] = tempUser;
}
});




// more routes for our API will happen here

// REGISTER OUR ROUTES -------------------------------
// all of our routes will be prefixed with /api
app.use('/panda', router);

// START THE SERVER
// =============================================================================
app.listen(port);
