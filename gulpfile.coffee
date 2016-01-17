'use strict'

gulp = require('gulp')
del = require('del')
path = require('path')
homePath = require('home-path')()
$ = require('gulp-load-plugins')()

repoPath = 'rxrc/tmuxrc'

pluginPath = "#{homePath}/.tmux/plugins/tmuxrc"

tpm = (task) ->
  "#{homePath}/.tmux/plugins/tpm/bin/#{task} &>/dev/null"

tpmUpdate = [
    tpm('install_plugins')
    tpm('install_plugins')
  ]

gulp.task 'default', ['watch']

gulp.task 'nodev', ->
  del.sync(pluginPath, {force: true})

  gulp.src('')
  .pipe $.shell(tpmUpdate)

gulp.task 'dev', ->
  del.sync(pluginPath, {force: true})

  gulp.src('*.tmux')
  .pipe gulp.dest(pluginPath)

  gulp.src('plugin/**/*.conf')
  .pipe gulp.dest("#{pluginPath}/plugin")

  gulp.src('plugins.conf')
  .pipe $.replace(repoPath, pluginPath)
  .pipe gulp.dest(pluginPath)

  gulp.src('')
  .pipe $.shell(tpmUpdate, {ignoreErrors: true})

gulp.task 'watch', ['dev'], ->
  $.watch ['./*.tmux', './*.conf', './plugin/**/*.conf'], (file) ->
    if file.event is 'unlink'
      del.sync(file.path, {force: true})
  .pipe $.replace(repoPath, pluginPath)
  .pipe gulp.dest(pluginPath)
  .pipe $.shell([tpmUpdate])
