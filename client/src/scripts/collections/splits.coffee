class App.Splits extends Backbone.Collection
    url: '/api/programs'
    model: App.Split

    destroy: ->
        @each (model) ->
            model.weights.destroy()
            model.destroy()