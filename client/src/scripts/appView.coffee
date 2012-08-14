# Top level UI, application wrapper
class App.AppView extends Backbone.View
    el: $('body')

    events: 
        'click #new_program'         : 'newProgramShow'
        'click #new_program_submit'  : 'newProgramCreate'
        'keypress #new_program_name' : 'newProgramOnEnter'

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
        @program_create = false # flag to see if the added program is newly created

    render: -> @

    programAdd: (program)->
        # console.log @programs
        programListView = new App.ProgramListView model: program, selected: @programs.indexOf(program) == 0, isMain: program.id == 2
        @new_program.before(programListView.render().el)
        # immediately show program if newly created
        if @program_create
            programListView.showProgram true
            @program_create = false

    programReset: ->
        App.contentView = new App.ContentView program: @programs.at(0) #get first program
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
                    @new_program_name.focus()

    newProgramCreate: ->
        if !@createDisabled
            @createDisabled = true
            name = @new_program_name.val()
            name = name.trim();
            if name.split(' ').join('').length > 0
                @program_create = true # flag to indicate newly created program
                if !App.contentView?
                    App.contentView = new App.ContentView
                @programs.create name: @new_program_name.val()
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

    newProgramOnEnter: (e) ->
        if e.keyCode != 13 
            return
        else
            @newProgramCreate()

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
            @updateButtonContainer()

        @render()

    render: ->
        # refreshes the content but not the button view
        if @program_view? then $(@el).html(@program_view.el)
#Make the content stretch to fit. Too weird. it fixes the height. ie height = 446px
 # $("#content").height $("#nav_left").height() + 80
        @updateButtonContainer()
        @

    updateProgram: (program, edit = false) ->
# TODO save list of programviews created so we don't create multiple views of the same thing
        @program_view = new App.ProgramView model: program, vent: @vent
        @render()
        if edit
            @vent.trigger 'program_edit'

    updateButtonContainer: ->
        y = $(window).scrollTop()
        if y >= @button_top - 10
            @button_container.addClass('fixed')
        else
            @button_container.removeClass('fixed')


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


