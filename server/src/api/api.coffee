config  = require '../config'
nano    = require('nano')(config.db.endpoint)
db      = nano.use config.db.name

# db: 
#     create: [Function: create_db],
#     get: [Function: get_db],
#     destroy: [Function: destroy_db],
#     list: [Function: list_dbs],
#     use: [Function: document_module],
#     scope: [Function: document_module],
#     compact: [Function: compact_db],
#     replicate: [Function: replicate_db],
#     changes: [Function: changes_db] },
# use: [Function: document_module],
# scope: [Function: document_module],
# request: [Function: relax],
# config: { url: 'http://localhost:5984' },
# relax: [Function: relax],
# dinosaur: [Function: relax] }


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
        if !err
            console.log body
            console.log body.rows[0].value
            res.send(body.rows[0].value)

# POST /me/programs
exports.create_me_programs = create_me_programs = (req, res) ->
    # creates a program and add to the user's collection of programs
    db.insert req.body, (err, header, body) ->
        if !err
            res.send(header)
            # console.log body
            console.log '!!!!!!!!!!!!!!!!!'
            console.log header

# PUT /me/programs/:id
exports.edit_program = (req, res) ->
    # edits a single program
    console.log 'PUT REQUEST'
    create_me_programs(req, res)


# GET /programs
exports.get_programs = (req, res) ->
    # return all programs
    # return res.send(programs);

# GET /programs/:id
exports.get_program = (req, res) ->
    # returns a single program

# DELETE /programs/:id
exports.delete_program = (req, res) ->
    # deletes a single program




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
