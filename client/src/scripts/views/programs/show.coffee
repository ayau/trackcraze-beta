class App.ProgramView extends Backbone.View
    template: _.template($("#program_view").html())

    events:
        'click .new_split_submit': 'newSplitCreate'
        'keypress .new_split_name': 'newProgramOnEnter'
        'click .save_program': 'saveProgram'

    initialize: (opt)->
        _.bindAll @

        # @model.bind "change", @render  #This removes events when it rerenders. Tried to solve with delegateEvents but didn't work.
        # temporary solution
        
        # event aggregator
        @vent = opt.vent
        @vent.bind 'program_edit', @edit
        @vent.bind 'program_delete', @delete

        # @splits = new App.Splits
        @model.splits.bind 'add', @splitAdd
        @model.splits.bind 'reset', @splitReset

        @render()

    render: ->
        @setElement(@template(@model.toJSON()))
# Assuming we recreate the view eveyrtime
        @splitReset()
        @delegateEvents()
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

    saveProgram: ->
        console.log 'saving'
        @model.set _rev: @model.get 'rev'
        @model.set _id: @model.get 'id'
        @model.save {}, 
            success: (model, res) =>
                @model.set rev: res.rev
            error: ->
                console.log 'error saving'

    delete: ->
        # @model.set id: @model.get('_id')  # for destroying purposes
        @model.destroy
            headers: 
                'If-Match': @model.get('rev')
            success: (model, res) ->
                console.log res
            error: ->
                console.log 'error'

    close: ->
        @remove()
        @unbind()
        @vent.unbind()
        @model.splits.unbind()






