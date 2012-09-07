# GET home page.
exports.index = (req, res) ->
    res.render('index')


# Programs
exports.program = (req, res) ->
    id = req.params.id
    res.render 'programs', { title: 'Express', layout: 'layout', program: id}

# My program
exports.me_program = (req, res) ->
    if req.user?
        user = req.user
        id = 0
        if user.programs.length > 0
            id = user.programs[0].id
        res.render 'programs', { title: 'Express', layout: 'layout', program: id}
    else
        res.redirect '/'


