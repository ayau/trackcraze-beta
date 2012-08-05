class App.Split extends Backbone.Model
    initialize: ->
        @weights = new App.Weights @get('weights')