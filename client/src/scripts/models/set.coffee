class App.Set extends Backbone.Model

    defaults:
        position: 1

    initialize: ->

    validate: (attr) ->
        if isNaN(parseInt attr.weight) || parseInt(attr.weight) < 1
            return 'weight needs to be a number greater than 0'
        if isNaN(parseInt attr.rep) || parseInt(attr.rep) < 1
            return 'reps needs to be a number greater than 0'
        if isNaN(parseInt attr.set) || parseInt(attr.set) < 1
            return 'sets needs to be a number greater than 0'