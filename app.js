/**
 * Module dependencies.
 */

    var express = require('express')
    , routes    = require('./routes/index.js')
    , api       = require('./routes/api.js');

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');
    app.set('view options', {layout: false});
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    app.use(express.static(__dirname + '/client/gen'));
});

app.configure('development', function(){
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});


app.configure('production', function(){
    app.use(express.errorHandler());
});

// Routes

app.get('/', routes.index);
app.get('/programs/:id', routes.programs);

//api
app.get('/api/programs', api.get_all_programs);
app.get('/api/programs/:id', api.get_program);
app.post('/api/programs', api.post_program);
app.put('/api/programs/:id', api.put_program);
app.delete('/api/programs/:id', api.delete_program);


var port = process.env.PORT || 3000;
app.listen(port, function(){
    console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
});
