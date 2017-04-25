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


router.get('/most-recent-trip/:id', function(request, response) {
    var user_id = request.params.id;

    var maxID = -1;
    var trip;
    conn.query('SELECT * FROM trip WHERE user_id=? && private=0', [user_id], function(err, result) {
        
        for (var i = 0; i < result.length; i++) {
            if (result[i].id > maxID) {
                maxID = result[i].id;
            
                trip = {
                    id: result[i].id, 
                    name: result[i].name, 
                    description: result[i].description,
                    location: result[i].location,
                    private: result[i].private,
                    api: result[i].api,
                    user_id: result[i].user_id
                };
            }        
        }

        response.json({ trip });
    });
});

// route create a user (accessed at POST http://localhost:8081/users)
router.post('/trip', function(request, response) {
    var q = request.body; 
    var trip = {
        name: q.name, 
        description: q.description,
        location: q.location,
        private: q.private,
        api: q.api,
        user_id: q.user_id
    } 
    
    conn.query('INSERT INTO trip SET ?', trip, function(err, result) {
        console.log('Added trip to user ?', trip.user_id);

        var trip_id = { trip_id: result.insertId };
        response.send(trip_id);
        
        console.log(trip);
    });
});

// route get all users (accessed at GET http://localhost:8081/users)
router.get('/all-trips/:id', function(request, response) {        
    var userID = request.params.id;
    var tripList = [];
    conn.query('SELECT * FROM trip WHERE user_id=?', [userID], function(err, result) {
        for (var i = 0; i < result.length; i++) {
            var tempTrip = { 
                id: result[i].id, 
                name: result[i].name, 
                description: result[i].description,
                location: result[i].location,
                private: result[i].private,
                api: result[i].api,
                user_id: result[i].user_id
            };
        
            tripList.push(tempTrip);
        }
        
        response.json({ tripList });
    });
});

// route get all users (accessed at GET http://localhost:8081/users)
router.get('/public-trips/:id', function(request, response) {        
    var userID = request.params.id;
    var tripList = [];
    conn.query('SELECT * FROM trip WHERE user_id=? && private=0', [userID], function(err, result) {
        for (var i = 0; i < result.length; i++) {
            var tempTrip = { 
                id: result[i].id, 
                name: result[i].name, 
                description: result[i].description,
                location: result[i].location,
                private: result[i].private,
                api: result[i].api,
                user_id: result[i].user_id
            };
        
            tripList.push(tempTrip);
        }
        
        response.json({ tripList });
    });
});

// route get a user (accessed at GET http://localhost:8081/user/{id})
router.get('/trip/:id', function(request, response) {
    var tripID = request.params.id;
    var trip;
    conn.query('SELECT * FROM trip WHERE id=?', [tripID], function(err, result) {
        trip = {
            id: result[0].id, 
            name: result[0].name, 
            description: result[0].description,
            location: result[0].location,
            private: result[0].private,
            api: result[0].api,
            user_id: result[0].user_id
        };
        
        response.json({ trip });
    });
});


router.put('/trip', function(request, response) {
    var q = request.body;
    var id = q.id;
    var description = q.description;
    var location = q.location;
    var private = q.private;
    var api = q.api;
    
    console.log(q);
    
    conn.query('SELECT * FROM trip', function(err, result) {
        var error = 1;
        for (var i = 0; i < result.length; i++) {
            if (result[i].id == q.id) {
                console.log('Trip exists.');

                conn.query('UPDATE trip SET description=?, private=?, api=? WHERE id=?', 
                    [description, private, api, id], function(err, result) {
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

// route create a user (accessed at POST http://localhost:8081/users)
router.post('/event', function(request, response) {
    var q = request.body; 
    var event = {
        name: q.name, 
        order: q.order,
        description: q.description,
        picture1: q.picture1,
        picture2: q.picture2,
        picture3: q.picture3,
        picture4: q.picture4,
        latitude: q.latitude,
        longitude: q.longitude,
        date: q.date,
        api: q.api,
        trip_id: q.trip_id
    } 
    
    conn.query('INSERT INTO event SET ?', event, function(err, result) {
        console.log('Added trip to event ?', event.trip_id);

        var event_id = { event_id: result.insertId };
        response.send(event_id);
        
        console.log(event);
    });
});

// route get all users (accessed at GET http://localhost:8081/users)
router.get('/events/:id', function(request, response) {        
    var tripID = request.params.id;
    var eventList = [];
    conn.query('SELECT * FROM event WHERE trip_id=?', [tripID], function(err, result) {
        for (var i = 0; i < result.length; i++) {
            var tempEvent = { 
                id: result[i].id, 
                order: result[i].order,
                name: result[i].name, 
                description: result[i].description,
                picture1: result[i].picture1,
                picture2: result[i].picture2,
                picture3: result[i].picture3,
                picture4: result[i].picture4,
                latitude: result[i].latitude,
                longitude: result[i].longitude,
                date: result[i].date,
                api: result[i].api,
                trip_id: result[i].trip_id
            };
        
            eventList.push(tempEvent);
        }
        
        response.json({ eventList });
    });
});

// route get a user (accessed at GET http://localhost:8081/user/{id})
router.get('/event/:id', function(request, response) {
    var eventID = request.params.id;
    var event;
    conn.query('SELECT * FROM event WHERE id=?', [eventID], function(err, result) {
        event = {
            id: result[0].id, 
            order: result[0].order,
            name: result[0].name, 
            description: result[0].description,
            picture1: result[0].picture1,
            picture2: result[0].picture2,
            picture3: result[0].picture3,
            picture4: result[0].picture4,
            latitude: result[0].latitude,
            longitude: result[0].longitude,
            date: result[0].date,
            api: result[0].api,
            trip_id: result[0].trip_id
        };
        
        response.json({ event });
    });
});

router.put('/event', function(request, response) {
    var q = request.body;
    var id = q.id;
    var order = q.order;
    var description = q.description;
    var picture1 = q.picture1;
    var picture2 = q.picture2;
    var picture3 = q.picture3;
    var picture4 = q.picture4;
    var latitude = q.latitude;
    var longitude = q.longitude;
    var date = q.date;
    var api = q.api;
    
    console.log(q);
    
    conn.query('SELECT * FROM event', function(err, result) {
        var error = 1;
        for (var i = 0; i < result.length; i++) {
            if (result[i].id == q.id) {
                console.log('Event exists.');

                conn.query('UPDATE event SET description=?, picture1=?, picture2=?, picture3=?, picture4=?, latitude=?, longitude=?, date=?, api=? WHERE id=?', 
                    [description, picture1, picture2, picture3, picture4, latitude, longitude, date, api, id], function(err, result) {
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


router.get('/pictures/:id', function(request, response) {
    var eventID = request.params.id;

    conn.query('SELECT * FROM event WHERE id=?', [eventID], function(err, result) {
        var pictures = {
            picture1: result[0].picture1,
            picture2: result[0].picture2,
            picture3: result[0].picture3,
            picture4: result[0].picture4
        }

        response.send(pictures);
    });
});


router.put('/pictures', function (request, response) {
    var q = request.body;
    var id = q.id;
    var picture1 = q.picture1;
    var picture2 = q.picture2;
    var picture3 = q.picture3;
    var picture4 = q.picture4;

    conn.query('SELECT * FROM event', function(err, result) {
        var error = 1;
        for (var i = 0; i < result.length; i++) {
            if (result[i].id == q.id) {
                console.log('Event exists.');

                conn.query('UPDATE event SET picture1=?, picture2=?, picture3=?, picture4=? WHERE id=?', 
                    [picture1, picture2, picture3, picture4, id], function(err, result) {
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

router.get('/search/:email', function(request, response) {
    var email = request.params.email;

    conn.query('SELECT * FROM user', function(err, result) {
        for (var i = 0; i < result.length; i++) {
            if (result[i].email == email.toLowerCase()) {
                console.log('User exists.');

                var tempUser = { 
                    id: result[i].id, 
                    name: result[i].name, 
                    email: result[i].email, 
                    bio: result[i].bio,
                    picture: result[i].picture
                };

                response.send(tempUser); 

                break;
            }
        }
    });
});


// route create a user (accessed at POST http://localhost:8081/users)
router.post('/friend', function(request, response) {
    var q = request.body; 
    var user_id = q.user_id;
    var friend_id = q.friend_id;

    conn.query('SELECT * FROM friend where user_id=?', [user_id], function(err, result) {
        var error = 0;
        for (var i = 0; i < result.length; i++) {
            if (result[i].friend_id == friend_id) {
                error = 1;
                break;
            }
        }

        if (error == 0) {
            var friend = {
                user_id: user_id,
                friend_id: friend_id
            };

            conn.query('INSERT INTO friend SET ?', friend, function(err, result) {
                var code = { code: 201 };   
                response.send(code); 
            });
        }
        else {
            var code = { code: 400 };   
            response.send(code); 
        }
    });
});

router.get('/friends/:id', function(request, response) {
    var temp = request.params.id;
    var arrOfFriends = [];
    var counter =0;
    
    conn.query('SELECT * FROM friend', function(err, result) {
        for (var i = 0; i < result.length; i++) {
        	if (result[i].user_id == temp) {
            	arrOfFriends[counter++] = result[i].friend_id; 
            }
        }
        
        counter = 0;
        var info = [];
        conn.query('SELECT * FROM user', function(err, result) {
        	console.log(result);
        	for (var i = 0; i < result.length; i++) {
                for(var j = 0; j < arrOfFriends.length; j++ ) {
		            if (result[i].id == arrOfFriends[j]) {
		                var tempUser = { 
		                id: result[i].id, 
		                name: result[i].name, 
		                email: result[i].email, 
		                bio: result[i].bio,
		                picture: result[i].picture
		            };
                    info[counter++] = tempUser; 
                }
            }
        }

        response.json({info});
    });
});
});

router.get('/friend/:id', function(request, response) {
    var user_id = request.params.id;
    var friendList = [];

    conn.query('SELECT * FROM friend WHERE user_id=?', [user_id], function(err, result) {
        for (var i = 0; i < result.length; i++) {
            /*var ids = {
                id: result[i].friend_id;
            }*/

            friendList.push(result[i].friend_id);
        }
        
        response.json({ friendList });
    });
});


// REGISTER OUR ROUTES -------------------------------
// all of our routes will be not be prefixed
app.use('', router);

// START THE SERVER
// =============================================================================
app.listen(port);
