module.exports = (grunt) ->
  {suppe} = require 'grunt-suppe/suppe'

  bower = 'bower_components'

  opts =
    app_compiled_output_path: 'var/app.js'
    src_dir: 'app'
    closure_libs: []
    deps_prefix: '../../'

  suppe grunt, opts
