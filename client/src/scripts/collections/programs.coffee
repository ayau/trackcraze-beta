class App.Programs extends Backbone.Collection
    url: '/api/me/programs'
    model: App.Program

    initialize: ->
        @fetch()