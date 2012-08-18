# GET home page.
exports.index = (req, res) ->
    res.render('index', { title: 'Express' })


# Programs
exports.programs = (req, res) ->
    id = req.params.id;
    res.render('programs', { title: 'Express', layout: 'layout' })

