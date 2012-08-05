class App.Weight extends Backbone.Model
    initialize: ->
        @sets = new App.Sets @get('sets')