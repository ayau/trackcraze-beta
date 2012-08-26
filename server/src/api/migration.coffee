config  = require '../config'
nano    = require('nano')(config.db.endpoint)
design  = require './design'
db_name = config.db.name
db      = nano.use db_name

# create the database if it does not exist
nano.db.list (err, databases) ->
    if err
        return console.log 'ERROR :: nano.db.list - %s', JSON.stringify(err)

    if databases.indexOf(db_name) < 0
        nano.db.create db_name, (err, body, headers) ->
            if err
                console.log 'ERROR :: %s', JSON.stringify(err)
            else
                updateDesign()
    else
        updateDesign()

# updates all the design docs
updateDesign = ->
    for name, doc of design
        if !(update_design doc) && !(update_design doc) #tries twice
            console.log 'ERROR :: %s failed to update', doc._id

# helper function to update a design doc
update_design = (doc) ->
    db.get doc._id, (err, body) ->
        if !err
            doc._rev = body._rev
        doc = trimHelper(doc)
        db.insert doc, (err, body, header) ->
            if !err
                console.log '%s successfully updated', doc._id 
                return true
            else
                console.log err
                return false

# helper to convert mapreduce functions to string and remove \n and \t
trimHelper = (doc) ->
    for name, mapreduce of doc.views
        map = mapreduce.map #doc[name].map
        reduce = mapreduce.reduce #doc[name].reduce
        if map?
            doc.views[name].map = trim map
        if reduce?
            doc.views[name].reduce = trim reduce

    for name, update of doc.updates
        doc.updates[name] = trim update

    return doc

trim = (string) ->
    string.toString().replace /(\r\n|\n|\r)/gm, ''
