class App.Weight extends Backbone.Model

    defaults:
        sets: []
        comment: ''

    initialize: ->
        @sets = new App.Sets @get('sets')