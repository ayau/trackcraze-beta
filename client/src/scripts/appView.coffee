# Top level UI, application wrapper
class App.AppView extends Backbone.View
    el: $('body')

    events: 
        'click #new_program'        : 'newProgramShow'
        'click #new_program_submit' : 'newProgramCreate'

    initialize: ->
        _.bindAll @

        # collection of programs from a user
        @programs = new App.Programs
        @programs.bind 'reset', @programReset
        @programs.bind 'add', @programAdd

        # cached dom elements
        @new_program        = $('#new_program')
        @new_program_name   = $('#new_program_name')
        @new_program_submit = $('#new_program_submit')

        # State variables
        @createDisabled = false # prevent multiple duplicate program creation

    render: -> @

    programAdd: (program)->
        # console.log @programs
        programListView = new App.ProgramListView model: program, selected: program.id == 3, isMain: program.id == 2
        @new_program.before(programListView.render().el)

    programReset: ->
        App.contentView = new App.ContentView program: @programs.get(3)
        @programs.each @programAdd

    newProgramShow: ->
        if !@new_program.hasClass 'selected'
            @new_program.addClass 'selected'
            @new_program.animate { height: '150px'},
                duration: 400,
                specialEasing:
                    top: 'easeOutBounce'
                complete: =>
                    @new_program_name.fadeIn()
                    @new_program_submit.fadeIn()

    newProgramCreate: ->
        if !@createDisabled
            @createDisabled = true
            name = @new_program_name.val()
            name = name.trim();
            if name.split(' ').join('').length > 0
                console.log @programs.create name: @new_program_name.val()
                duration = 10
            else
                duration = 400

            @new_program_name.val ''
            @new_program_name.hide()
            @new_program_submit.hide()
            @new_program.animate {height: '61px'},
                duration: duration,
                specialEasing:
                    top: 'easeOutBounce'
                complete: =>
                    @new_program.removeClass 'selected'
                    @createDisabled = false

#Content level UI
class App.ContentView extends Backbone.View
    el: $ '#content_holder'
    vent: _.extend({}, Backbone.Events) #event aggregator

    initialize: (options)->
        _.bindAll @

        if @options.program?
            @program_view = new App.ProgramView model: @options.program, vent: @vent #not the order but the id of the program

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

        @render()

    render: ->
        # refreshes the content but not the button view
        if @program_view? then $(@el).html(@program_view.el)
#Make the content stretch to fit 
        $("#content").height $("#nav_left").height() + 80
        @

    updateProgram: (program) ->
# TODO save list of programviews created so we don't create multiple views of the same thing
        @program_view = new App.ProgramView model: program, vent: @vent
        @render()

    hide_button_container: ->
        @button_container.addClass('hidden')

    show_button_container: ->
        @button_container.removeClass('hidden')


class App.ButtonView extends Backbone.View
    template: _.template($("#button_view").html())
    events: 'click .edit': 'edit'

    initialize: (opt)->
        _.bindAll @
        @vent = opt.vent
        @render()

    render: ->
        @setElement(@template())
        @

    edit: ->
        @vent.trigger 'program_edit'


