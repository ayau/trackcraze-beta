class App.SplitView extends Backbone.View
    template: _.template($("#split_view").html())

    initialize: (opt)->
        _.bindAll @

        # event aggregator
        @vent = opt.vent
        @vent.bind 'program_edit', @edit

    render: ->
        @setElement(@template(@model.toJSON()))
        @update()
        return @

    update: ->
        @model.weights.each (weight) =>
            weight_view = new App.WeightView model: weight, vent: @vent
            $(@el).find(".workout_table").append(weight_view.render().el)

    edit: ->
        @split_name ?= @.$('.split_name')
        @split_name.addClass('edit')
        @input ?= @.$('.split_name').find('input')

        @new_exercise ?= @.$('.new_exercise')
        @new_exercise.addClass('edit')