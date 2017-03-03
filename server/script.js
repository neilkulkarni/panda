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
    password : '', //use your own password
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
router.post("/requestAccount", function (req, res) {
  /* var body = '';
    req.on('data', function(chunk) {
      body += chunk;
    });
    req.on('end', function() {
      var data = qs.parse(body);
      // now you can access `data.email` and `data.password`
      res.writeHead(200);
      res.end(JSON.stringify(data));
      console.log(data);
      var name ='';
      var email = '';
      var password = '';
      var loc = 0;
      console.log(data.name);
      for(var i = 0; i < data.length; i++) {

      		if(data.substring(i, i+ 1) == '"') {
      			while(data.charAt == '"') {
      				i++;
      				if(loc == 0) {
      					name += data.charAt(i);
      				}
      				if(loc == 1) {
      					email += data.charAt(i);
      				}
      				if(loc == 2) {
      					password += data.charAt(i);
      				}
      				
      			}
      			loc++;
      		}
      }
}); */
    }); 

router.get('/users', function(req, res) {        res.json({ userList });
});

 var user = {
                        name: 'bob', 
                        password: '123',
                        email: 'd@some.com'
                    };
               conn.query('insert into user set ?', user, function(err, result) {
                        //confirm user;
                        return;
                    });

var userList = [];
conn.query('select * from user', function(err, result) {
for (var i = 0; i < result.length; i++) {
        var tempUser = { name: result[i].name , email: result[i].email, password: result[i].password };
        userList[i] = tempUser;
}
});




if(1) { //creating a new account
    conn.query('select * from user', function(err, result) {
        if(err) {
            console.error(err);
            return;
        }
        for (var i = 0; i < result.length; i++) {
            if(result[i].name.localeCompare('natha') == 0) {
                if(result[i].password.localeCompare('123') == 0) {
                	if(err) {
            			console.error(err);
            			return;
        			}
                   
                    break;
                }
            }
        }
    });
}
if(1) { //logging
    conn.query('select * from user', function(err, result) {
        if(err) {
            console.error(err);
            return;
        }
        for (var i = 0; i < result.length; i++) {
            if((result[i].name).localeCompare(('natha').toLowerCase)) {
                if(result[i].password.localeCompare('123') == 0) {
                    //confirm that it is a user
                }
            }
        }
    });
}


// more routes for our API will happen here

// REGISTER OUR ROUTES -------------------------------
// all of our routes will be prefixed with /api
app.use('/panda', router);

// START THE SERVER
// =============================================================================
app.listen(port);
