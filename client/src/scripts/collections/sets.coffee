class App.Sets extends Backbone.Collection
    url: '/api/programs'
    model: App.Set

    destroy: ->
        @each (model) ->
            model.destroy()