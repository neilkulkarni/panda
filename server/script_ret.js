
// retrieve all users from the database
var mysql = require("mysql");

var conn = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : 'Richmond5223',
    database : 'user',
});

conn.connect();

conn.query('select * from user', function(err, result) {
	if(err) {
		console.error(err);
		return;
	}
	console.log(result);
});