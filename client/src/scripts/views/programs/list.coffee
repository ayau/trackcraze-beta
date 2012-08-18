class App.ProgramListView extends Backbone.View
    template: _.template($("#nav_view").html())

    initialize: ->
        _.bindAll @
        # console.log @
        @render()

    events:
        'click': 'programSelected'

    render: ->
        @setElement(@template({program: @model.toJSON(), selected: @options.selected, isMain: @options.isMain}))
        # @update()
        return @

    # necessary to separate the event called by jquery 'click' vs method called manually by appView
    programSelected: ->
        @showProgram()

    showProgram: (edit = false) ->
        # Better way of doing this = trigger an event to toggle all List
        $(@el).parent().find('li').not('#new_program').removeClass 'selected'
        $(@el).addClass 'selected'
        if App.contentView?
            App.contentView.updateProgram @model, edit

    close: ->
        @remove()
        @unbind()