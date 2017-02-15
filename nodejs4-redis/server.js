
console.log('NodeJS 4.x and Redis Example');

var redis = require('redis');
var client = redis.createClient(6379, "redis");

// Connect
client.on('connect', function() {
  console.log('Connected to Redis');
});

// Handle errors
client.on("error", function (err) {
  console.log(err);
});

// Key/value
client.set('project', 'DevTools');
client.get('project', function(err, reply) {
  console.log("Getting value for key 'project': " + reply);
});

// Hashes
client.hmset('frameworks', {
  'javascript': 'AngularJS',
  'css': 'Bootstrap',
  'php': 'Laravel'
});
client.hgetall("frameworks", function (err, obj) {
  console.log("Getting hash 'frameworks'");
  console.dir(obj);
});

// Lists
client.rpush(['js-frameworks', 'angularjs', 'react', 'ionic']);
client.lrange('js-frameworks', 0, -1, function(err, reply) {
  console.log("Getting list 'js-frameworks'");
  console.log(reply);
});

// Sets
client.sadd(['languages', 'javascript', 'php', 'ruby', 'go', 'swift', 'go']);
client.smembers('languages', function(err, reply) {
  console.log("Getting set 'languages'");
  console.log(reply);
});

// Check existence
client.exists('project', function(err, reply) {
  if (reply === 1) {
    console.log("Key 'project' exists");
  }
});

// Increment / Decrement
client.set('count', 10, function() {
  console.log("'count' initialized to 10")
  client.incr('count', function(err, reply) {
    console.log("'count' incremented, new value is " + reply)
  });
});

// Clean up
client.del('project');
client.del('frameworks');
client.del('js-frameworks');
client.del('languages');
client.del('count');

