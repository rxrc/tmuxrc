'use strict'

gulp = require('gulp')
del = require('del')
path = require('path')
homePath = require('home-path')()
$ = require('gulp-load-plugins')()

repoPath = 'rxrc/tmuxrc'

pluginPath = "#{homePath}/.tmux/plugins/tmuxrc"

tpm = (task) ->
  "#{homePath}/.tmux/plugins/tpm/scripts/#{task}.sh &>/dev/null"

tpmUpdate = [
    tpm('install_plugins')
    tpm('install_plugins')
  ].join('; ')

gulp.task 'default', ['watch']

gulp.task 'dev', ['clean', 'install'],
  $.shell.task([tpmUpdate])

gulp.task 'nodev', ['clean'],
  $.shell.task([tpmUpdate])

gulp.task 'clean', ->
  del(pluginPath, {force: true})

gulp.task 'install', ->
  gulp.src('*.tmux')
  .pipe gulp.dest(pluginPath)

  gulp.src('plugin/**/*.conf')
  .pipe gulp.dest("#{pluginPath}/plugin")

  gulp.src('plugins.conf')
  .pipe $.replace(repoPath, pluginPath)
  .pipe gulp.dest(pluginPath)

gulp.task 'watch', ['install'], ->
  $.watch ['./*.tmux', './*.conf', './plugin/**/*.conf'], (file) ->
    if file.event is 'unlink'
      del(file.path, {force: true})
  .pipe $.replace(repoPath, pluginPath)
  .pipe gulp.dest(pluginPath)
  .pipe $.shell([tpmUpdate])
