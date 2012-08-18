class App.Weights extends Backbone.Collection
    url: '/api/programs'
    model: App.Weight

    destroy: ->
        @each (model) ->
            model.sets.destroy()
            model.destroy()