{exec, spawn} = require 'child_process'
path = require 'path'

option '-w', '--watch', 'watch changes from project and build'

dir = 
    gen: 'client/gen'
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

task 'build', 'build project from source', (options) ->
    exec "rm -rf '#{dir.gen}'" #clear gen folder
    console.log "  #{colors.grey}#{(new Date).toLocaleTimeString()} - " + "#{colors.bold.red}DELETE#{colors.reset}" + " #{dir.gen}"
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

