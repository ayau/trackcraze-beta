/**
 * Module dependencies.
 */

  var express = require('express')
  , routes    = require('./routes/index.js')
  , api       = require('./routes/api.js')
  , stylus    = require('stylus')
  , nib       = require('nib');

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.set('view options', {layout: false});
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(stylus.middleware({ 
    src: __dirname + '/client/stylus'
    , dest: __dirname + '/client'
    , compile: compile
    }));
  app.use(express.static(__dirname + '/client'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

function compile(str, path) {
  return stylus(str)
    .set('filename', path)
    .set('compress', true)
    .use(nib());
}

app.configure('production', function(){
  app.use(express.errorHandler());
});

// Routes

app.get('/', routes.index);
app.get('/programs/:id', routes.programs);

//api
app.get('/api/programs/:id', api.get_program);
app.post('/api/programs', api.post_program);
app.put('/api/programs/:id', api.put_program);
app.delete('/api/programs/:id', api.delete_program);


var port = process.env.PORT || 3000;
app.listen(port, function(){
  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
});
