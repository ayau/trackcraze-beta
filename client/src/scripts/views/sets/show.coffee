class App.SetView extends Backbone.View
    template_first: _.template($("#set_view_first").html())
    template: _.template($("#set_view").html())

    initialize: ->
        _.bindAll @     #_.bindAll(this, "render");
        @model.bind 'change', @render
        @render()

    render: ->
        if @model.get('posiiton') is 1
            @setElement(@template_first(@model.toJSON()))
        else
            @setElement(@template(@model.toJSON()))
        return @