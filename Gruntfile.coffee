module.exports = (grunt) ->
  {suppe} = require 'grunt-suppe/suppe'

  bower = 'bower_components'

  opts =
    app_compiled_output_path: 'var/app.js'
    src_dir: 'app'
    closure_libs: []
    deps_prefix: '../../'
    overridden_config:
      bump:
        options:
          bump: true
          files: ['package.json', 'bower.json']
          commitFiles: ['-a']
          commit: true
          tagName: '%VERSION%'
          tagMessage: 'Release %VERSION%'
          commitMessage: '%VERSION%'
          pushTo: 'origin'

  suppe grunt, opts

  grunt.loadNpmTasks 'grunt-bump'
