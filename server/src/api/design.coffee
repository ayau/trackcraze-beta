module.exports =
    programs:
        _id: '_design/programs'

        # validate_doc_update: ->

        views:
            list:
                map: (doc) ->
                    emit doc._id, doc
                # reduce:
