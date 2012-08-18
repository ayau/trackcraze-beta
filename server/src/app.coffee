config  = require './config'
express = require 'express'
routes  = require './routes'
api     = require './api/api'

app = module.exports = express.createServer()

# Configuration

app.configure ->
    app.set('views', __dirname + '/views')
    app.set('view engine', 'jade')
    app.set('view options', {layout: false})
    app.use(express.bodyParser())
    app.use(express.methodOverride())
    app.use(app.router)
    app.use(express.static(__dirname + '/../../client/gen/'))

app.configure 'development', ->
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))



app.configure 'production', ->
    app.use(express.errorHandler())

 # Routes
app.get '/', routes.index
app.get '/programs/:id', routes.programs

# api

app.get '/api/me/programs', api.get_me_programs
app.post '/api/me/programs', api.create_me_programs
app.put '/api/me/programs/:id', api.edit_program
app.delete '/api/me/programs/:id', api.delete_program


port = process.env.PORT || 3000
app.listen port, ->
    console.log 'Express server listening on port %d in %s mode', app.address().port, app.settings.env