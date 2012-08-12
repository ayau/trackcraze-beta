class App.SplitView extends Backbone.View
    template: _.template($("#split_view").html())

    events:
        'click .new_exercise_submit': 'newExerciseCreate'
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

        @model.weights.bind 'add', @weightAdd
        @model.weights.bind 'reset', @weightReset

    render: ->
        @setElement(@template(@model.toJSON()))
# Assuming we recreate the view eveyrtime
        @weightReset()
        return @

    weightAdd: (weight) ->
        weight_view = new App.WeightView model: weight, vent: @vent
        $(@el).find('.workout_table').append(weight_view.render().el)

    weightReset: ->
        if @model.weights.length > 0
            $(@el).find('.workout_table').empty()
            @model.weights.each @weightAdd

    edit: ->
        @split_name ?= @.$('.split_name')
        @split_name.addClass('edit')
        @input ?= @.$('.split_name').find('input')

        @new_exercise ?= @.$('.new_exercise')
        @new_exercise.addClass('edit')

        @new_exercise_name ?= @new_exercise.find('.exercise_name')
        @new_weight ?= @.$('.new_set_weight')
        @new_lbkg ?= @.$('.new_set_lbkg')
        @new_rep ?= @.$('.new_set_rep')
        @new_set ?= @.$('.new_set_set')

    newExerciseCreate: ->
        weight = @model.weights.create name: @new_exercise_name.val()
        weight.sets.create weight: @new_weight.val(), lbkg: @new_lbkg.val(), rep: @new_rep.val(), set: @new_set.val()
        @new_exercise_name.val('')
        @new_weight.val('')
        @new_rep.val('')
        @new_set.val('')
        @vent.trigger('program_edit')

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
