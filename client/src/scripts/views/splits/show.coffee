class App.SplitView extends Backbone.View
    template: _.template($("#split_view").html())

    initialize: ->
        _.bindAll @

    render: ->
        @setElement(@template(@model.toJSON()))
        @update()
        return @

    update: ->
        @model.weights.each (weight) =>
            weight_view = new App.WeightView model: weight
            $(@el).find(".workout_table").append(weight_view.render().el)