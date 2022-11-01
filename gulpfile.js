import os from 'os'
import path from 'path'

import gulp from 'gulp'
import shell from 'gulp-shell'
import watch from 'gulp-watch'
import replace from 'gulp-replace'
import { deleteAsync } from 'del'

const repoPath = 'rxrc/tmuxrc'
const homePath = os.homedir()

const pluginPath = `${homePath}/.config/tmux/plugins/tmuxrc`

const tpm = (task) => {
  return `${homePath}/.config/tmux/plugins/tpm/bin/${task} &>/dev/null`
}

const tpmUpdate = [tpm('install_plugins'), tpm('install_plugins')]

gulp.task('default', watch)

gulp.task('nodev', () => {
  deleteAsync(pluginPath, {
    force: true,
  })
  return gulp.src('.').pipe(shell(tpmUpdate))
})

gulp.task('dev', () => {
  deleteAsync(pluginPath, {
    force: true,
  })
  gulp.src('*.tmux').pipe(gulp.dest(pluginPath))
  gulp.src('plugin/**/*.conf').pipe(gulp.dest(`${pluginPath}/plugin`))
  gulp
    .src('plugins.conf')
    .pipe(replace(repoPath, pluginPath))
    .pipe(gulp.dest(pluginPath))
  return gulp.src('.').pipe(
    shell(tpmUpdate, {
      ignoreErrors: true,
    })
  )
})

gulp.task(
  'watch',
  gulp.series('dev', () => {
    return watch(['./*.tmux', './*.conf', './plugin/**/*.conf'], (file) => {
      if (file.event === 'unlink') {
        return deleteAsync(file.path, {
          force: true,
        })
      }
    })
      .pipe(replace(repoPath, pluginPath))
      .pipe(gulp.dest(pluginPath))
      .pipe(shell([tpmUpdate]))
  })
)
