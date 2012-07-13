$(function(){

    Program = Backbone.Model.extend({

        // Default attributes for program.
        /*defaults: {
            "id": 0,
            "user_id": 0,
            "name": "Summer 2012 workout program",
            "privacy": 2
        },*/

        //validation
        initialize: function() {
        },

        // Remove from localStorage and delete view
        clear: function() {
          this.destroy();
        }

    });

    /*Split = Backbone.Model.extend({
        defaults: {
            id = 0,
            name = 'Chest',
            position = 0
        },
        initialize: function(){
            
        }
    })

    Workout = Backbone.Model.extend({
        defaults: {
            id = 0,
            name = 'Bench Press',
            exercise_id = 0,
            position = 0
        },
        initialize: function(){
            
        }
    })

    Set = Backbone.Model.extend({
        defaults: {
            id = 0,
            set = 0,
            weight = 0,
            lbkg = 'lbs'
            res = 0,
            position = 0
        },
        initialize: function(){

        }

    })*/

    //Top level UI
    ProgramView = Backbone.View.extend({
        el: $("#program"),
        template: _.template($("#program_view").html()),
        
        initialize: function(){
            this.render();
            //this.model.bind("change", this.render, this);
        },
        render: function(){
            $(this.el).html(this.template(this.model.toJSON()));
        }
    });

    data = { "created_at" : "2012-07-10 10:24:03",
    "id" : 3,
    "main_program" : true,
    "name" : "Summer 2012 workout program",
    "privacy" : 2,
    "user_id" : 3,
    "splits" : [
        {
            "id": 0,
            "name": "Chest",
            "position": 1
        },
        {
            "id": 0,
            "name": "Shoulder",
            "position": 2
        }]
    };

    var program = new Program(data);
    var program_view = new ProgramView({model: program});
});
