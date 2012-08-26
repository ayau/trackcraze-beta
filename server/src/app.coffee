config    = require './config'
express   = require 'express'
routes    = require './routes'
api       = require './api/api'
everyauth = require 'everyauth'

app = module.exports = express.createServer()

sessions = {} # in memory/temporary store. use connect-couchdb later for persistent session store

everyauth.facebook
    .appId(config.facebook.id)
    .appSecret(config.facebook.secret)
    .handleAuthCallbackError( (req, res) ->
    # If a user denies your app, Facebook will redirect the user to
    # /auth/facebook/callback?error_reason=user_denied&error=access_denied&error_description=The+user+denied+your+request.
    # This configurable route handler defines how you want to respond to
    # that.
    # If you do not configure this, everyauth renders a default fallback
    # view notifying the user that their authentication failed and why.
    ).findOrCreateUser( (session, accessToken, accessTokExtra, fbUserMetadata) ->
        # should check if sesison contains the info first

        userPromise = @Promise()
        api.login fbUserMetadata, (err, user) ->
            return userPromise.fail 'error!?' if err || !user?
            userPromise.fulfill user
            sessions[user.id] = user
            console.log user
        return userPromise
    ).redirectPath('/');

everyauth.everymodule.findUserById (req, userId, callback) ->
    callback null, sessions[userId]

# Configuration

app.configure ->
    app.set('views', __dirname + '/views')
    app.set('view engine', 'jade')
    app.set('view options', {layout: false})
    app.use(express.bodyParser())
    app.use(express.methodOverride())
    app.use express.cookieParser()
    app.use(express.static(__dirname + '/../../client/gen/'))
    app.use express.session({secret: '3Eg9dD13gDleq'})
    app.use everyauth.middleware()
    app.use(app.router)

app.configure 'development', ->
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

app.configure 'production', ->
    app.use(express.errorHandler())

authenticate = (req, res, next) ->
    if !req.user?
        res.send 401 # Unauthorized
    else
        next()


 # Routes
app.get '/', routes.index
app.get '/programs/:id', routes.programs

# api
app.get '/api/dummy/me', api.dummy_me
app.get '/api/dummy/programs', api.dummy_programs

app.get '/api/me', authenticate, api.get_me
app.get '/api/me/programs', api.get_me_programs
app.post '/api/me/programs', api.create_me_programs
app.put '/api/me/programs/:id', api.edit_program
app.delete '/api/me/programs/:id', api.delete_program

app.get '/api/test/programs', api.get_test_programs


port = process.env.PORT || 3000
app.listen port, ->
    console.log 'Express server listening on port %d in %s mode', app.address().port, app.settings.env
