$(function(){

    /*Split = Backbone.Model.extend({
        defaults: {
            id = 0,
            name = 'Chest',
            position = 0
        },
        initialize: function(){
            
        }
    })

    Weights = Backbone.Model.extend({
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
            rep = 0,
            position = 0
        },
        initialize: function(){

        }

    })*/

    Program = Backbone.Model.extend({

        urlRoot: '/api/programs/3',
        // Default attributes for program.
        /*defaults: {
            "id": 0,
            "user_id": 0,
            "name": "Summer 2012 workout program",
            "privacy": 2
        },*/
        //validation
        initialize: function() {
            this.fetch();
        },

        // Remove from localStorage and delete view
        clear: function() {
          this.destroy();
        }

    });

    //Top level UI
    ProgramView = Backbone.View.extend({
        el: $("#program"),
        template: _.template($("#program_view").html()),
        
        initialize: function(){
            //this.render();
            this.model.bind("change", this.render, this);
        },
        render: function(){
            $(this.el).html(this.template(this.model.toJSON()));
        }
    });

    ButtonView = Backbone.View.extend({
        el: $("body"),
        template: _.template($("#button_view").html()),
        initialize: function(){
            this.render();
        },
        render: function(){
            $(this.el).append(this.template());
        }
    })

    var program = new Program();
    var program_view = new ProgramView({model: program});

    //Make the content stretch to fit 
    $("#content").height($("#nav_left").height()+80);

    //Check if owner
    var button_view = new ButtonView();

    //scrolling of the button container
    var top = $('#button_container').position().top;
    $(window).scroll(function (event) {
        var y = $(this).scrollTop();
      
        if (y >= top - 10) 
          $('#button_container').addClass('fixed');
        else
          $('#button_container').removeClass('fixed');
    });

    //hover for button container
    $("#content").mouseout(function(){
      $("#button_container").addClass('hidden');
    }).mouseover(function(){
       $("#button_container").removeClass('hidden');
    });

    $("#button_container").mouseout(function(){
      $("#button_container").addClass('hidden');
    }).mouseover(function(){
       $("#button_container").removeClass('hidden');
    });
});
