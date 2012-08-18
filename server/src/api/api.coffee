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

exports.get_test_programs = (req, res) ->
    res.send programs

# GET /
exports.login = (req, res) ->
    # handles log in with email/password, facebook


# GET /users
exports.get_users = (req, res) ->
    # retrieves all users

# GET /users/:id
exports.get_user = (req, res) ->
    # retrieving a user

# POST /users
exports.create_user = (req, res) ->
    # creating a user


# GET /me
exports.get_me = (req, res) ->
    # returns an authenticated user

# GET /me/programs
exports.get_me_programs = (req, res) ->
    # returns an authenticated user's programs
    db.view 'programs', 'list', (err, body) ->
        if !err && body.rows.length > 0
            console.log body
            # console.log body.rows[0].value
            # program = body.rows[0].value
            programs = []
            for r in body.rows
                program = r.value
                program['id'] = program['_id']
                program['rev'] = program['_rev']
                programs.push program
            res.send programs
        else
            res.send(err)

# POST /me/programs
exports.create_me_programs = create_me_programs = (req, res) ->
    # creates a program and add to the user's collection of programs
    db.insert req.body, (err, header, body) ->
        if !err
            # console.log body
            console.log 'POST PROGRAM'
            console.log header
            res.send(header)

# PUT /me/programs/:id
# edits a single program
exports.edit_program = (req, res) ->
    console.log 'PUT PROGRAM'
    create_me_programs(req, res)

exports.delete_program = (req, res) ->
    console.log 'DELETING PROGRAM'
    db.destroy req.params.id, req.headers['if-match'], (err, body) ->
        if !err
            console.log body
            res.send body
        else
            console.log err


# GET /programs
exports.get_programs = (req, res) ->
    # return all programs
    # return res.send(programs);

# GET /programs/:id
exports.get_program = (req, res) ->
    # returns a single program





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
