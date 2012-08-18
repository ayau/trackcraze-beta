class App.Program extends Backbone.Model
    urlRoot: '/api/me/programs'
    # urlRoot: '/api/programs/3'
    # splits: new App.Splits

    initialize: ->
        # console.log @
        @splits = @nestCollection('splits', new App.Splits @get('splits'))
        # @splits = new App.Splits @get('splits')
        # @fetch()
    # parse: (res) ->
    #     @splits = new Splits res.splits
    #     res.splits = @splits #Duplicated?
    #     return res
