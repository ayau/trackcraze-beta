class App.SplitView extends Backbone.View
    template: _.template($("#split_view").html())

    events:
        'focus .new_set_weight': 'removeWeightPlaceholder'
        'blur .new_set_weight': 'addWeightPlaceholder'
        'focus .new_set_rep': 'removeRepPlaceholder'
        'blur .new_set_rep': 'addRepPlaceholder'
        'focus .new_set_set': 'removeSetPlaceholder'
        'blur .new_set_set': 'addSetPlaceholder'

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

    removeWeightPlaceholder: ->
        @weightPlaceholder ?= @.$('.new_set_weight').attr('placeholder')
        @.$('.new_set_weight').attr('placeholder', '')

    addWeightPlaceholder: ->
        @.$('.new_set_weight').attr('placeholder', @weightPlaceholder)

    removeRepPlaceholder: ->
        @repPlaceholder ?= @.$('.new_set_rep').attr('placeholder')
        @.$('.new_set_rep').attr('placeholder', '')

    addRepPlaceholder: ->
        @.$('.new_set_rep').attr('placeholder', @repPlaceholder)

    removeSetPlaceholder: ->
        @setPlaceholder ?= @.$('.new_set_set').attr('placeholder')
        @.$('.new_set_set').attr('placeholder', '')

    addSetPlaceholder: ->
        @.$('.new_set_set').attr('placeholder', @setPlaceholder)
