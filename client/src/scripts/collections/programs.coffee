class App.Programs extends Backbone.Collection
    url: '/api/programs'
    model: App.Program

    initialize: ->
        @fetch()