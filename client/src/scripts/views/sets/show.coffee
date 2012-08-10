class App.SetView extends Backbone.View
    template_first: _.template($("#set_view_first").html())
    template: _.template($("#set_view").html())

    initialize: (opt)->
        _.bindAll @     #_.bindAll(this, "render");

        # event aggregator 
        @vent = opt.vent
        @vent.bind 'program_edit', @edit

        @model.bind 'change', @render
        @render()

    render: ->
        if @model.get('position') is 1
            @setElement(@template_first(@model.toJSON()))
        else
            @setElement(@template(@model.toJSON()))
        return @

    edit: ->
        @workout_set ?= if @model.get('position') is 1 then $(@el) else @.$('.workout_set')
        @workout_set.addClass('edit')