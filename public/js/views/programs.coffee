$ ->

    class Set extends Backbone.Model
        initialize: ->

    class Sets extends Backbone.Collection
        model:Set
    
    class Weight extends Backbone.Model
        initialize: ->
            @sets = new Sets @get('sets')

    class Weights extends Backbone.Collection
        model: Weight

    class Split extends Backbone.Model
        initialize: ->
            @weights = new Weights @get('weights')

    class Splits extends Backbone.Collection
        model: Split

    class Program extends Backbone.Model
        urlRoot: '/api/programs/3'
        splits: new Splits

        initialize: ->
            @fetch()
        parse: (res) ->
            @splits = new Splits res.splits
            res.splits = @splits #Duplicated?
            return res

        # Remove from localStorage and delete view
        clear: ->
          @destroy()

    class SetView extends Backbone.View
        template_first: _.template($("#set_view_first").html())
        template: _.template($("#set_view").html())

        initialize: ->
            _.bindAll @     #_.bindAll(this, "render");
            @model.bind 'change', @render
            @render()

        render: ->
            if @model.get('posiiton') is 1
                @setElement(@template_first(@model.toJSON()))
            else
                @setElement(@template(@model.toJSON()))
            return @

    class WeightView extends Backbone.View
        template: _.template($("#weight_view").html())

        initialize: ->
            _.bindAll @
            @model.bind 'change', @render
            @render()

        render: ->
            @setElement(@template(@model.toJSON()))
            @update()
            return @

        update: ->
            @model.sets.each (set) =>
                set_view = new SetView model: set
                if set.get('position') is 1
                    $(@el).find(".workout_exercise").after(set_view.render().el)
                else
                    $(@el).find(".table_break").before(set_view.render().el)

    class SplitView extends Backbone.View
        template: _.template($("#split_view").html())

        initialize: ->
            _.bindAll @

        render: ->
            @setElement(@template(@model.toJSON()))
            @update()
            return @

        update: ->
            @model.weights.each (weight) =>
                weight_view = new WeightView model: weight
                $(@el).find(".workout_table").append(weight_view.render().el)

    class ProgramView extends Backbone.View
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
                split_view = new SplitView model: split
                $(@el).find('#split_holder').append(split_view.render().el)

        edit: ->
            $(@el).addClass('editing')
            @input.focus()

    #Top level UI
    class AppView extends Backbone.View
        el: $ '#content_holder'
        vent: _.extend({}, Backbone.Events)

        initialize: ->
            _.bindAll @
            program_view = new ProgramView model: new Program, vent: @vent
            button_view = new ButtonView vent: @vent
            $(@el).prepend(program_view.el)
            $("body").append(button_view.render().el)

        render: ->
            return @

    class ButtonView extends Backbone.View
        template: _.template($("#button_view").html())

        initialize: (opt)->
            _.bindAll @
            @vent = opt.vent
            @render()

        render: ->
            @setElement(@template())
            return @

        events: 'click #program_edit': 'edit'

        edit: ->
            @vent.trigger 'program_edit'
            

    app = new AppView

    #Make the content stretch to fit 
    $("#content").height($("#nav_left").height()+80)

    button_container = $("#button_container")

    #scrolling of the button container
    top = button_container.position().top

    $(window).scroll (event) ->
        y = $(this).scrollTop()
        if y >= top - 10
            button_container.addClass('fixed')
        else
            button_container.removeClass('fixed')


    hide_button_container = ->
        button_container.addClass('hidden')

    show_button_container = ->
        button_container.removeClass('hidden')

    #hover for button container
    $("#content").mouseout(hide_button_container).mouseover(show_button_container)
    button_container.mouseout(hide_button_container).mouseover(show_button_container)

