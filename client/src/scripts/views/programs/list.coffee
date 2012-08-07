class App.ProgramListView extends Backbone.View
    template: _.template($("#nav_view").html())

    initialize: ->
        _.bindAll @
        # console.log @
        @render()

    events:
        'click': 'showProgram'

    render: ->
        @setElement(@template({program: @model.toJSON(), selected: @options.selected, isMain: @options.isMain}))
        # @update()
        return @

    showProgram: ->
        # Better way of doing this = trigger an event to toggle all List
        $(@el).parent().find('li').not('#new_program').removeClass 'selected'
        $(@el).addClass 'selected'
        App.contentView.updateProgram @model