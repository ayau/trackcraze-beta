class App.ProgramView extends Backbone.View
    template: _.template($("#program_view").html())

    initialize: (opt)->
        _.bindAll @

        @model.bind "change", @render
        
        # event aggregator
        @vent = opt.vent
        @vent.bind 'program_edit', @edit

        @render()

    render: ->
        @el.innerHTML = @template(@model.toJSON())
        @update()
        return @

    update: ->
        @model.splits.each (split) =>
            split_view = new App.SplitView model: split, vent: @vent
            $(@el).find('#split_holder').append(split_view.render().el)

    edit: ->
        # caching dom elements
        @program_name ?= @.$('.program_name')
        @program_name.addClass('edit')
        @input ?= @program_name.find('input')
        @input.focus()
