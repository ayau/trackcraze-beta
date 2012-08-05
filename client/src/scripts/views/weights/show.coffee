class App.WeightView extends Backbone.View
    template: _.template($("#weight_view").html())

    initialize: ->
        _.bindAll @
        @model.bind 'change', @render
        @render()

    render: ->
        @setElement(@template(@model.toJSON()))
        @update()
        return @

    update: ->
        @model.sets.each (set) =>
            set_view = new App.SetView model: set
            if set.get('position') is 1
                $(@el).find(".workout_exercise").after(set_view.render().el)
            else
                $(@el).find(".table_break").before(set_view.render().el)