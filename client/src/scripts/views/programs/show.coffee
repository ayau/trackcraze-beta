class App.ProgramView extends Backbone.View
        template: _.template($("#program_view").html())

        initialize: (opt)->
            _.bindAll @
            @model.bind "change", @render
            opt.vent.bind 'program_edit', @edit
            @render()

        render: ->
            @el.innerHTML = @template(@model.toJSON())
            @update()
            return @

        update: ->
            @model.splits.each (split) =>
                split_view = new App.SplitView model: split
                $(@el).find('#split_holder').append(split_view.render().el)

        edit: ->
            $(@el).addClass('editing')
            @input.focus()
