var express = require('express');
var bodyParser = require('body-parser');
const fs = require('fs');
var app = express()
 
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
 
// parse application/json
app.use(bodyParser.json())

// we'll load up node's built in file system helper library here
// (we'll be using this later to serve our JSON files
const dataPath = './data/users.json';
app.get('/',function (req, res)  {

    res.json({temperature:90,humidity:89.0,gas:78});
  });



// configure our express instance with some body-parser settings
// including handling JSON data
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }));

// this is where we'll handle our various routes from

// finally, launch our server on port 3000.
app.listen(3000, () => {
  console.log("Server running on port 3000");
 });