config  = require '../config'
nano    = require('nano')(config.db.endpoint)
db      = nano.use config.db.name

###
    PUT request
        requires _id and _rev
        returns rev in header (needs to update in model)
    POST request
        returns id and rev
    GET request
        returns _id and _rev
###

###
User
{
    type       : "user"
    id         : (id for couchdb)
    rev        : (rev for couchdb)
    fb_id      : (facebook id)
    first_name : (first name)
    last_name  : (last name)
    gender     : (male/female/undisclosed)
    programs   : [{
                    id   : (facebook_id)
                    name : (program name)
                  }]
}


Program
{
    type         : "program"
    id           : (id from couchdb)
    rev          : (rev for couchdb)
    created_at   : (2012-07-10 10:24:03)
    main_program : true
    name         : (name of program)
    privacy      : (privacy)
    user_id      : (owner)
    splits : [
        {
            id        : (unused but required by backbone)
            name      : (name of split)
            position  : (position)
            weights   : [
                {
                    id        : (unused)
                    name      : (Exercise name)
                    position  : (position)
                    comment   : (comment on exercise)
                    sets      : [
                        {
                            id        : (unused)
                            set       : (number of sets)
                            weight    : (weight in lbs)
                            lbkg      : (what client prefers to display as)
                            rep       : (number of reps)
                            position  : (position)
                        }
                    ]
                }
            ]
        }
    ]
}
###

# handles log in with email/password, facebook
exports.login = (fb, callback) ->
    id = fb.id
    db.view 'users', 'facebook', {key: id}, (err, body) ->
        if !err
            console.log body
            if body.rows.length is 0
                user = 
                    fb_id       : id
                    first_name  : fb.first_name
                    last_name   : fb.last_name
                    gender      : if fb.gender is 'male' or fb.gender is'female' then fb.gender else 'undisclosed'
                return create_user user, callback
            else
                user = body.rows[0].value
                user.id = user._id
                user.rev = user._rev
                delete user._id
                delete user._rev
                return callback null, user
        else
            return callback err, null

# only supports fb log in
create_user = (user, callback) ->
    if user? && user.fb_id?
        user.type = 'user'  # ensures type is user 
        user.programs = []      
        db.insert user, (err, header, body) ->
            if !err
                console.log 'USER CREATED'
                console.log header
                if header.ok is true
                    user.id = header.id
                    user.rev = header.rev
                    return callback null, user
            else
                return callback err, null
    else
        return callback 'error: invalid parameters for user', null

#-------------------------ME-------------------------#
# (Authentication required)

# GET /me
exports.get_me = (req, res) ->
    # returns an authenticated user
    # res.send req.user # might be stale
    id = req.user.id
    db.get id, {}, (err, body) ->
        if !err
            console.log 'GET ME'
            user = body
            user.id = user._id
            user.rev = user._rev
            delete user._id
            delete user._rev
            res.send user
        else
            res.send err

# GET /me/programs
exports.get_me_programs = (req, res) ->
    me = req.user.id
    # returns an authenticated user's programs
    db.view 'programs', 'list', {key: me}, (err, body) ->
        if !err && body.rows?
            console.log body
            # console.log body.rows[0].value
            # program = body.rows[0].value
            programs = []
            for r in body.rows
                program = r.value
                program['id'] = program['_id']
                program['rev'] = program['_rev']
                delete program['_id']
                delete program['_rev']
                programs.push program
            res.send programs
        else
            res.send err

# GET /me/programs/:id
exports.get_me_program = (req, res) ->
    me = req.user.id
    id = req.params.id
    db.get id, {}, (err, body) ->
        if !err
            console.log 'GET PROGRAM'
            program = body
            if program.user_id is me
                program.id = program._id
                program.rev = program._rev
                delete program._id
                delete program._rev
                res.send programs
            else
                res.send 403 # forbidden
        else
            res.send err

# POST /me/programs
exports.create_me_programs = (req, res) ->
    # req body can have garbage fields (need to validate)
    # creates a program and add to the user's collection of programs
    me = req.user.id
    program = req.body
    program.type = 'program'
    program.user_id = me
    program.created_at = new Date().getTime()
    db.insert program, (err, header, body) ->
        if !err
            # console.log body
            console.log 'POST PROGRAM'
            console.log header
            program.id = header.id
            program.rev = header.rev
            db.atomic 'users', 'add_program', me,
            {id: program.id, name: program.name}, (err, response) ->
                if !err
                    console.log 'ADDED TO USER'
                    res.send program
                    console.log program
                else
                    res.send err
        else
            res.send err

# PUT /me/programs/:id
# edits a single program
exports.edit_program = (req, res) ->
    console.log 'PUT PROGRAM'
    me = req.user.id
    program = req.body
    db.insert program, (err, header, body) ->
        if !err
            # console.log body
            console.log header
            program.id = header.id
            program.rev = header.rev
            res.send program
        else
            res.send err

# DELETE /me/programs/:id
exports.delete_program = (req, res) ->
    console.log 'DELETING PROGRAM'
    me = req.user.id
    id = req.params.id

    db.atomic 'users', 'remove_program', me,
    {id: id}, (err, response) ->
        if !err
            console.log response
            console.log 'removed from user'
            db.destroy id, req.headers['if-match'], (err, body) ->
                if !err
                    console.log body
                    res.send body
                else
                    res.send err
        else
            res.send err

    
#-----------------------PUBLIC-----------------------#

# GET /programs
# exports.get_programs = (req, res) ->
    # return all programs
    # return res.send(programs);

# GET /programs/:id
exports.get_program = (req, res) ->
    # returns a single program

# GET /users
# exports.get_users = (req, res) ->
    # retrieves all users

# GET /users/:id
# exports.get_user = (req, res) ->
    # retrieving a user

# GET /dummy/me
exports.dummy_me = (req, res) ->
    user = 
        "fb_id": "519585436"
        "first_name": "Alex"
        "last_name": "Yau"
        "gender": "male"
        "type": "user"
        "programs": [{
                "id": 123
                "name": "test 1"
            },{
                "id": 234
                "name": "test 2"
                }]
        "id": "355acca351433cfc7ffd885a310002e1"
        "rev": "1-cf990fed71f8d86203f2c0163e7dbe9a"
    res.send user

# GET /dummy/programs
exports.dummy_programs = (req, res) ->
    res.send programs

program = ->
    return { 
    "created_at" : "2012-07-10 10:24:03",
    "id" : 3,
    "main_program" : true,
    "name" : "Summer 2012 workout program",
    "privacy" : 2,
    "user_id" : 3,
    "splits" : [
        {
            "id": 4,
            "name": "Chest",
            "position": 1,
            "weights": [
                {
                    "id": 5,
                    "name": "Incline bench press",
                    "position": 1,
                    "comment": "Can definitely increase weight next time",
                    "sets": [
                        {
                            "id": 6,
                            "set": 2,
                            "weight": 150,
                            "lbkg": 'lbs',
                            "rep": 3,
                            "position": 1
                        },
                        {
                            "id": 7,
                            "set": 1,
                            "weight": 160,
                            "lbkg": 'kg',
                            "rep": 3,
                            "position": 2
                        }
                    ]
                },
                {
                    "id": 8,
                    "name": "Flat bench press",
                    "position": 2,
                    "comment": "",
                    "sets": [
                        {
                            "id": 9,
                            "set": 3,
                            "weight": 175,
                            "lbkg": 'lbs',
                            "rep": 3,
                            "position": 1
                        }
                    ]
                },
                {
                    "id": 10,
                    "name": "Barbell row",
                    "position": 3,
                    "comment": "",
                    "sets": [
                        {
                            "id": 11,
                            "set": 3,
                            "weight": 180,
                            "lbkg": 'lbs',
                            "rep": 5,
                            "position": 1
                        }
                    ]
                },
                {
                    "id": 12,
                    "name": "Weighted pull ups",
                    "position": 4,
                    "comment": "",
                    "sets": [
                        {
                            "id": 13,
                            "set": 2,
                            "weight": 60,
                            "lbkg": 'lbs',
                            "rep": 8,
                            "position": 1
                        },
                        {
                            "id": 14,
                            "set": 1,
                            "weight": 45,
                            "lbkg": 'lbs',
                            "rep": 7,
                            "position": 2
                        }
                    ]
                }
            ]
        },
        {
            "id": 15,
            "name": "Shoulder",
            "position": 2,
            "weights": [
                {
                    "id": 16,
                    "name": "Seated Shoulder Press",
                    "position": 1,
                    "comment": "",
                    "sets": [
                        {
                            "id": 17,
                            "set": 3,
                            "weight": 105,
                            "lbkg": 'lbs',
                            "rep": 6,
                            "position": 1
                        }
                    ]
                },
                {
                    "id": 18,
                    "name": "Dumbbell Press",
                    "position": 2,
                    "comment": "",
                    "sets": [
                        {
                            "id": 19,
                            "set": 3,
                            "weight": 45,
                            "lbkg": 'lbs',
                            "rep": 6,
                            "position": 1
                        }
                    ]
                },
                {
                    "id": 20,
                    "name": "Lateral raises",
                    "position": 3,
                    "comment": "Hurt my wrist during this exercise",
                    "sets": [
                        {
                            "id": 21,
                            "set": 2,
                            "weight": 25,
                            "lbkg": 'lbs',
                            "rep": 6,
                            "position": 1
                        },
                        {
                            "id": 22,
                            "set": 1,
                            "weight": 10,
                            "lbkg": 'lbs',
                            "rep": 5,
                            "position": 2
                        }
                    ]
                },
                {
                    "id": 23,
                    "name": "Barbell front raise",
                    "position": 4,
                    "comment": "",
                    "sets": [
                        {
                            "id": 24,
                            "set": 2,
                            "weight": 50,
                            "lbkg": 'lbs',
                            "rep": 6,
                            "position": 1
                        }
                    ]
                }
            ]
        }
    ]}

program1 = new program()
program2 = new program()
program2.id = 2
program2.name = 'Test Program'
programs = 
    [
        program1,
        program2
    ];
