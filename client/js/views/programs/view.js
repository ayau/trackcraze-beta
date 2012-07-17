$(function(){

    /*Weights = Backbone.Model.extend({
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

    Split = Backbone.Model.extend({

        initialize: function(){
            //console.log(this.model);
        }
    })

    Splits = Backbone.Collection.extend({
        model: Split/*,
        initialize: function(splits){
            this.each(function(splits){
                //var split_view = splits;
                //$("#program").append(split_view.render().el);
                alert("two");
            })
        }*/

    })

    Program = Backbone.Model.extend({

        urlRoot: '/api/programs/3',
        splits: new Splits(),

        initialize: function() {
            this.fetch();
        },
        parse: function(res){
            var splitsJSON = res.splits;
            this.splits = new Splits(splitsJSON);
            res.splits = this.splits;   //duplicated
            return res; 
        },

        // Remove from localStorage and delete view
        clear: function() {
          this.destroy();
        }

    });

    SplitView = Backbone.View.extend({

        template: _.template($("#split_view").html()),

        initialize: function(){
            _.bindAll(this, "render");
            this.model.bind("change", this.render, this);
            this.render();
        },
        render: function(){
            this.setElement(this.template(this.model.toJSON()));
            return this;
        }
    })

    ProgramView = Backbone.View.extend({
        template: _.template($("#program_view").html()),
        initialize: function(){
            _.bindAll(this, "render");
            //this.model.splits.bind('add', this.addSplit, this);
            //this.model.splits.bind('reset', this.addAll, this);
            this.model.bind("change", this.render, this);
            this.render();
        },
        render: function(){
            this.el.innerHTML = this.template(this.model.toJSON());
            //$("#content_holder").append(this.el);
            //$(this.el).append(this.el);
            this.update();
            debugger;
            return this;
        },
        update: function(){
            var el = this.el;
            this.model.splits.each(function(split){
                split_view = new SplitView({model: split});
                $(el).find('#split_holder').append(split_view.render().el);
            })
        }
        /*,
        addSplit: function(split){
            alert("LOL");
            var split_view = new SplitView({model: split});
            this.$("#program").append(split_view.render().el);
        },
        addAll: function(){
            alert("LOL");
        }*/
    });

    //Top level UI
    AppView = Backbone.View.extend({
        el: $("#content_holder"),
        initialize: function(){
            _.bindAll(this, "render");
            var program_view = new ProgramView({model: new Program()});
            $(this.el).prepend(program_view.el);
        },
        render: function(){
            return this;
        }
    })

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

    var app = new AppView();

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
