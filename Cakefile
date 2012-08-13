{exec, spawn} = require 'child_process'
path = require 'path'

option '-w', '--watch', 'watch changes from project and build'

dir = 
    gen: 
        client: 'client/gen'
        server: 'server/gen'
    assets:
        src: 'client/src/assets/'
        gen: 'client/gen/assets/'
    scripts:
        src: 'client/src/scripts/'
        gen: 'client/gen/scripts/'
    stylesheets:
        name: 'stylesheets'
        src: 'client/src/assets/stylesheets'
        gen: 'client/gen/assets/stylesheets'
    lib:
        src: 'client/src/assets/lib/'
        gen: 'client/gen/assets/lib/'
    api:
        src: 'server/src/api/'
        gen: 'server/gen/api/'
    views:
        src: 'server/src/views/'
        gen: 'server/gen/views/'
    server:
        src: 'server/src/'
        gen: 'server/gen/'

task 'build', 'build project from source', (options) ->

    exec "rm -rf '#{dir.gen.server}'"
    console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.red}DELETE#{colors.reset}" + " #{dir.server.gen}"

    # exec "./node_modules/.bin/coffee -co '#{path.dirname dir.server.gen}' '#{path.dirname dir.server.src}'", (err, stdout, stderr) ->
    #     throw err if err
    #     console.log stdout + stderr
    # console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.yellow}COMPILE#{colors.reset}" + " #{dir.server.gen}"

    exec "./node_modules/.bin/coffee -co '#{path.dirname dir.api.gen}' '#{path.dirname dir.api.src}'", (err, stdout, stderr) ->
        throw err if err
        # console.log stdout + stderr
    console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.yellow}COMPILE#{colors.reset}" + " #{dir.server.gen}"

    exec "mkdir -p '#{dir.views.gen}'" #create views directory
    exec "rsync -av '#{dir.views.src}' '#{dir.views.gen}'"
    console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.cyan}CREATE#{colors.reset}" + " #{dir.views.gen}"


    exec "rm -rf '#{dir.gen.client}'" #clear gen folder
    console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.red}DELETE#{colors.reset}" + " #{dir.gen.client}"
    exec "mkdir -p '#{dir.assets.gen}'" #create assets directory
    exec "rsync -av --exclude='#{dir.stylesheets.name}' '#{dir.assets.src}' '#{dir.assets.gen}'" #copy assets (excluding stylesheets)
    console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.cyan}CREATE#{colors.reset}" + " #{dir.assets.gen}"
    # exec "mkdir -p '#{dir.scripts.gen}'" #create scripts directory
    exec "cp -r '#{dir.lib.src}' '#{dir.lib.gen}'"
    console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.magenta}COPY#{colors.reset}" + " #{dir.lib.gen}"
    exec "./node_modules/.bin/coffee -co '#{path.dirname dir.scripts.gen}' '#{path.dirname dir.scripts.src}'", (err, stdout, stderr) ->
        throw err if err
        # console.log stdout + stderr
    console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.yellow}COMPILE#{colors.reset}" + " #{dir.scripts.gen}"
    exec "mkdir -p '#{dir.stylesheets.gen}'"
    exec "./node_modules/.bin/stylus -o '#{dir.stylesheets.gen}' '#{dir.stylesheets.src}' --use ./node_modules/nib/lib/nib.js", (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
    console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.yellow}COMPILE#{colors.reset}" + " #{dir.stylesheets.gen}"


task 'run', 'run the app', ->
    process = spawn 'node', ['server/gen/app.js']
    process.stdout.setEncoding('utf8')
    process.stdout.on 'data', (data) ->
        console.log data
    process.stderr.setEncoding('utf8')
    process.stderr.on 'data', (data) ->
        console.log data

task 'migrate', 'update database', ->
    process = spawn 'node', ['server/gen/api/migration.js']
    process.stdout.setEncoding('utf8')
    process.stdout.on 'data', (data) ->
        console.log data
    process.stderr.setEncoding('utf8')
    process.stderr.on 'data', (data) ->
        console.log data

#TODO
# WATCH
# build library
# build folder structure

# #task 'run', 'Run the server', (options) ->
#   process = spawn 'node', ['server/compiled/scripts/server.js']

colors =
    black     : '\x1B[0;30m'
    red       : '\x1B[0;31m'
    green     : '\x1B[0;32m'
    yellow    : '\x1B[0;33m'
    blue      : '\x1B[0;34m'
    magenta   : '\x1B[0;35m'
    cyan      : '\x1B[0;36m'
    grey      : '\x1B[0;90m'
    bold: 
      bold        : '\x1B[0;1m'
      black       : '\x1B[0;1;30m'
      red         : '\x1B[0;1;31m'
      green       : '\x1B[0;1;32m'
      yellow      : '\x1B[0;1;33m'
      blue        : '\x1B[0;1;34m'
      magenta     : '\x1B[0;1;35m'
      cyan        : '\x1B[0;1;36m'
      white       : '\x1B[0;1;37m'
    reset       : '\x1B[0m'

