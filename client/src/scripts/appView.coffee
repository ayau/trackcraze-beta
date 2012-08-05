# Top level UI, application wrapper
class App.AppView extends Backbone.View
    el: $('body')

    initialize: ->
        _.bindAll @

        @programs = new App.Programs
        @programs.bind "reset", (collection, res) =>
            contentView = new App.ContentView program: collection.get(3)
            collection.each (program, i) ->
                programListView = new App.ProgramListView model: program, selected: i == 0, isMain: i == 1
                $('#new_program').before(programListView.render().el)

        # avoid this. Put it in view
        $("#new_program").live "click", ->
            if !$(this).hasClass 'selected'
                $(this).addClass 'selected'
                $(this).animate { height: '150px'},
                    duration: 400,
                    specialEasing:
                        top: 'easeOutBounce'
                    complete: ->
                        $(this).find("#new_program_name").fadeIn()
                        $("#new_program_submit").fadeIn()

        #Make the content stretch to fit 
        $("#content").height($("#nav_left").height()+80)

    render: ->
        return @

class App.ProgramListView extends Backbone.View
    template: _.template($("#nav_view").html())

    initialize: ->
        _.bindAll @
        @render()

    render: ->
        @setElement(@template({program: @model.toJSON(), selected: @options.selected, isMain: @options.isMain}))
        # @update()
        return @


#Content level UI
class App.ContentView extends Backbone.View
    el: $ '#content_holder'
    vent: _.extend({}, Backbone.Events) #event aggregator

    initialize: (options)->
        _.bindAll @

        program_view = new App.ProgramView model: @options.program, vent: @vent #not the order but the id of the program
        $(@el).prepend(program_view.el)

        # ButtonView
        @buttonView = new App.ButtonView vent: @vent

        @button_container = $(@buttonView.render().el)
        $("body").append(@button_container)

        @button_top = @button_container.position().top
        
        # should refactor. ButtonView shouldn't know about window
        $(window).scroll (event) => 
            y = $(window).scrollTop()
            if y >= @button_top - 10
                @button_container.addClass('fixed')
            else
                @button_container.removeClass('fixed')

        #hover for button container
        $("#content").mouseout(@hide_button_container).mouseover(@show_button_container)
        @button_container.mouseout(@hide_button_container).mouseover(@show_button_container)

    render: ->
        return @

    hide_button_container: ->
        @button_container.addClass('hidden')

    show_button_container: ->
        @button_container.removeClass('hidden')


class App.ButtonView extends Backbone.View
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


