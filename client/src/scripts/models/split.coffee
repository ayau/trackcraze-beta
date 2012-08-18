class App.Split extends Backbone.Model
    
    initialize: ->
        @weights = @nestCollection('weights', new App.Weights @get('weights'))

    validate: (attr) ->
        name = attr.name.trim()
        if name.split(' ').join('').length == 0
            return 'Split name must not be empty'

    # sync: (method, model)