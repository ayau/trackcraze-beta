

# Top level UI, application wrapper
    class AppView extends Backbone.View
        el: $('body')

        initialize: ->
            _.bindAll @
            nav_view = new NavView
            $('#new_program').before(nav_view.render().el)
        render: ->
            return @


    class NavView extends Backbone.View
        template: _.template($("#nav_view").html())

        initialize: ->
            _.bindAll @
            # @model.bind 'change', @render
            @render()

        render: ->
            @setElement(@template())
            # @update()
            return @
$ ->
    app = new AppView
