class App.SplitView extends Backbone.View
    template: _.template($("#split_view").html())

    initialize: (opt)->
        _.bindAll @

        # event aggregator
        opt.vent.bind 'program_edit', @edit

    render: ->
        @setElement(@template(@model.toJSON()))
        @update()
        return @

    update: ->
        @model.weights.each (weight) =>
            weight_view = new App.WeightView model: weight
            $(@el).find(".workout_table").append(weight_view.render().el)

    edit: ->
        @split_name ?= @.$('.split_name')
        @split_name.addClass('edit')
        @input ?= @.$('.split_name').find('input')