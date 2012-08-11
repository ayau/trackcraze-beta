//API


exports.get_all_programs = function (req, res){
    return res.send(programs);
}

// exports.get_program = function(req, res){
// 	return res.send(program1);
// };

// exports.post_program = function(req, res){
//     return res.send(program1);
// };

// exports.put_program = function(req, res){
//     return res.send(program1);
// };

// exports.delete_program = function(req, res){
//     return res.send(program1);
// };

program = function(){
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
    ]
};
}

program1 = new program()
program2 = new program()
program2.id = 2
program2.name = 'Test Program'
programs = 
    [
        program1,
        program2
    ];