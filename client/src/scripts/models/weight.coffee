class App.Weight extends Backbone.Model

    defaults:
        sets: []
        comment: ''

    initialize: ->
        @sets = @nestCollection('sets', new App.Sets @get('sets'))

    validate: (attr) ->
        name = attr.name.trim()
        if name.split(' ').join('').length == 0
            return 'Exercise name must not be empty'