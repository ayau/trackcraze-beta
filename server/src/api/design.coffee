module.exports =
    users:
        _id: '_design/users'

        views:
            facebook:
                map: (doc) ->
                    if doc.type == 'user'
                        emit doc.fb_id, doc
        updates:
            add_program: (doc, req) ->
                if doc.type == 'user'
                    body = JSON.parse req.body
                    id = body.id ? ''
                    name = body.name ? ''
                    programs = doc.programs
                    if !programs?
                        programs = []
                    programs.push {id: id, name: name}
                    return [doc, 'success']
                else
                    return [doc, 'error']
            remove_program: (doc, req) ->
                if doc.type == 'user'
                    body = JSON.parse req.body
                    id = body.id
                    programs = doc.programs
                    if !programs?
                        return [doc, 'program does not exist']
                    if !id?
                        return [doc, 'id is null']

                    for i of programs
                        if programs[i].id == id
                            programs.splice(i, 1)
                            return [doc, 'success']
                    return [doc, 'no program found']
                else
                    return [doc, 'error']
    programs:
        _id: '_design/programs'

        # validate_doc_update: ->

        views:
            list:
                map: (doc) ->
                    if doc.type == 'program'
                        emit doc.user_id, doc
                # reduce:
