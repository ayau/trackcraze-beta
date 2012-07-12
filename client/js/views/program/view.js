//var jade = require("jade");

var ProgramView = Backbone.View.extend({
        initialize: function(){
            this.render();
        },
        render: function(){
            var template = _.template( $("#program_view").html(), {} );
            // Load the compiled HTML into the Backbone "el"
            $(this.el).html(template);
        }
    });
    
    var program_view = new ProgramView({ el: $("#program") });