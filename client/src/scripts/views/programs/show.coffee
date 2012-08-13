class App.ProgramView extends Backbone.View
    template: _.template($("#program_view").html())

    events:
        'click .new_split_submit': 'newSplitCreate'
        'keypress .new_split_name': 'newProgramOnEnter'

    initialize: (opt)->
        _.bindAll @

        @model.bind "change", @render
        
        # event aggregator
        @vent = opt.vent
        @vent.bind 'program_edit', @edit

        # @splits = new App.Splits
        @model.splits.bind 'add', @splitAdd
        @model.splits.bind 'reset', @splitReset

        @render()

    render: ->
        @setElement(@template(@model.toJSON()))
# Assuming we recreate the view eveyrtime
        @splitReset()
        @

    splitAdd: (split) ->
        split_view = new App.SplitView model: split, vent: @vent
        $(@el).find('#split_holder').append(split_view.render().el)

    splitReset: ->
        if @model.splits.length > 0
            $(@el).find('#split_holder').empty()
            @model.splits.each @splitAdd

    newSplitCreate: ->
        @model.splits.create name: @split_name.val()
        @split_name.val('')
        @vent.trigger('program_edit')

    newProgramOnEnter: (e)->
        if e.keyCode != 13 
            return
        else
            @newSplitCreate()

    edit: ->
        # caching dom elements
        @program_name ?= @.$('.program_name')
        @program_name.addClass('edit')
        @input ?= @program_name.find('input')
        # @input.focus()
        @.$('.new_split').addClass('edit')
        @split_name ?= @.$('.new_split_name')


