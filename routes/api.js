//API


//api/programs/:id
exports.get_program = function(req, res){
	return res.send(data);
};

    data = { 
        "created_at" : "2012-07-10 10:24:03",
        "id" : 3,
        "main_program" : true,
        "name" : "Summer 2012 workout program",
        "privacy" : 2,
        "user_id" : 3,
        "splits" : [
            {
                "id": 0,
                "name": "Chest",
                "position": 1,
                "weights": [
                    {
                        "id": 0,
                        "name": "Incline bench press",
                        "position": 1,
                        "comment": "Can definitely increase weight next time",
                        "sets": [
                            {
                                "id": 0,
                                "set": 2,
                                "weight": 150,
                                "lbkg": 'lbs',
                                "rep": 3,
                                "position": 1
                            },
                            {
                                "id": 0,
                                "set": 1,
                                "weight": 160,
                                "lbkg": 'lbs',
                                "rep": 3,
                                "position": 2
                            }
                        ]
                    },
                    {
                        "id": 0,
                        "name": "Flat bench press",
                        "position": 2,
                        "comment": "",
                        "sets": [
                            {
                                "id": 0,
                                "set": 3,
                                "weight": 175,
                                "lbkg": 'lbs',
                                "rep": 3,
                                "position": 1
                            }
                        ]
                    },
                    {
                        "id": 0,
                        "name": "Barbell row",
                        "position": 3,
                        "comment": "",
                        "sets": [
                            {
                                "id": 0,
                                "set": 3,
                                "weight": 180,
                                "lbkg": 'lbs',
                                "rep": 5,
                                "position": 1
                            }
                        ]
                    },
                    {
                        "id": 0,
                        "name": "Weighted pull ups",
                        "position": 4,
                        "comment": "",
                        "sets": [
                            {
                                "id": 0,
                                "set": 2,
                                "weight": 60,
                                "lbkg": 'lbs',
                                "rep": 8,
                                "position": 1
                            },
                            {
                                "id": 0,
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
                "id": 0,
                "name": "Shoulder",
                "position": 2,
                "weights": [
                    {
                        "id": 0,
                        "name": "Seated Shoulder Press",
                        "position": 1,
                        "comment": "",
                        "sets": [
                            {
                                "id": 0,
                                "set": 3,
                                "weight": 105,
                                "lbkg": 'lbs',
                                "rep": 6,
                                "position": 1
                            }
                        ]
                    },
                    {
                        "id": 0,
                        "name": "Dumbbell Press",
                        "position": 2,
                        "comment": "",
                        "sets": [
                            {
                                "id": 0,
                                "set": 3,
                                "weight": 45,
                                "lbkg": 'lbs',
                                "rep": 6,
                                "position": 1
                            }
                        ]
                    },
                    {
                        "id": 0,
                        "name": "Lateral raises",
                        "position": 3,
                        "comment": "Hurt my wrist during this exercise",
                        "sets": [
                            {
                                "id": 0,
                                "set": 2,
                                "weight": 25,
                                "lbkg": 'lbs',
                                "rep": 6,
                                "position": 1
                            },
                            {
                                "id": 0,
                                "set": 1,
                                "weight": 10,
                                "lbkg": 'lbs',
                                "rep": 5,
                                "position": 2
                            }
                        ]
                    },
                    {
                        "id": 0,
                        "name": "Barbell front raise",
                        "position": 4,
                        "comment": "",
                        "sets": [
                            {
                                "id": 0,
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