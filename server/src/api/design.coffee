module.exports =
    users:
        _id: '_design/users'

        views:
            facebook:
                map: (doc) ->
                    if doc.type == 'user'
                        emit doc.fb_id, doc
    programs:
        _id: '_design/programs'

        # validate_doc_update: ->

        views:
            list:
                map: (doc) ->
                    emit doc._id, doc
                # reduce:
