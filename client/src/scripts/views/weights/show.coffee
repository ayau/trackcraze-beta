class App.WeightView extends Backbone.View
    template: _.template($("#weight_view").html())

    initialize: (opt)->
        _.bindAll @

        # event aggregator
        @vent = opt.vent
        @vent.bind 'program_edit', @edit

        @model.sets.bind 'add', @setAdd
        @model.sets.bind 'reset', @setReset

        @render()

    render: ->
        @setElement(@template(@model.toJSON()))
# Assuming we recreate the view eveyrtime
        @setReset()
        return @

    setAdd: (set) ->
        set_view = new App.SetView model: set, vent: @vent
        if set.get('position') is 1
                $(@el).find(".workout_exercise").after(set_view.render().el)
            else
                $(@el).find(".table_break").before(set_view.render().el)

    setReset: ->
        if @model.sets.length > 0
            $(@el).find('.workout_set').remove()
            @model.sets.each @setAdd

    edit: ->
        @exercise_name ?= @.$('.workout_exercise')
        @exercise_name.addClass('edit')
        @input ?= @.$('.exercise_name').find('input')

        @comment ?= @.$('.workout_comment')
        @comment.addClass('edit')