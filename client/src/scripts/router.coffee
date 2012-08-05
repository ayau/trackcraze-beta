class App.Router extends Backbone.Router
    
    routes:
        # Define some URL routes
        '/programs': 'showProjects'

        # Default
        '*actions': 'defaultAction'

    # showProjects: ->
    #     # Call render on the module we loaded in via the dependency array
    #     # 'views/projects/list'
    #     projectListView.render()

    defaultAction: (actions) ->
    # We have no matching route, lets just log what the URL was
        console.log 'No route:', actions

    start: ->
        # start history
        Backbone.history.start()

