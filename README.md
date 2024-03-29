# tmux Configuration

[![Github releases](https://img.shields.io/github/release/rxrc/tmuxrc.svg)](https://github.com/rxrc/tmuxrc/releases)
[![GitHub license](https://img.shields.io/github/license/rxrc/tmuxrc.svg)](./LICENSE.txt)

My complete tmux configuration as a tmux plugin.
For an empty starting config that follows the same organization,
switch to the `minimal` branch.

Note that versioned released are cut from the `minimal` branch,
and changes between those releases are documented in the
[CHANGELOG](./CHANGELOG.md).
The `master` branch represents my current tmux environment,
and is intended to remain unversioned.

## Description

This configuration system works as a meta-plugin:
all desired tmux plugins are loaded from `plugins.conf` using
[Tmux Plugin Manager].
Overall configuration then follows a normal plugin structure.

[Tmux Plugin Manager]: https://github.com/tmux-plugins/tpm

## Installation

You must be in a tmux session to install.

### Automatic Install

You can install this via the command-line with either curl

```
$ curl -L rc.evansosenko.com/tmuxrc/install.sh | sh
```

or wget

```
$ wget rc.evansosenko.com/tmuxrc/install.sh -O - | sh
```

### Manual Install

1. Install [Tmux Plugin Manager].
2. Create `~/.config/tmux/tmux.conf` with

  ```tmux
  # rxrc/tmuxrc

  if-shell "test -f $HOME/.config/tmux/plugins/tmuxrc/plugins.conf" "source $HOME/.config/tmux/plugins/tmuxrc/plugins.conf"
  if-shell "test ! -f $HOME/.config/tmux/plugins/tmuxrc/plugins.conf" "set -g @tpm_plugins 'tmux-plugins/tpm rxrc/tmuxrc'"
  run-shell '$HOME/.config/tmux/plugins/tpm/tpm'
  ```

3. Install with

  ```
  $ ~/.config/tmux/plugins/tpm/bin/install_plugins
  $ ~/.config/tmux/plugins/tpm/bin/install_plugins
  ```

## Updating

Updating is handled via the normal [Tmux Plugin Manager]
install and update commands.

Alternatively, you can run the commands listed in the Manual Install section.

## tmuxline.vim

If found, this configuration will load `~/.config/tmux/tmuxline.zsh`
which can be generated or updated using [tmuxline.vim]
by running `:TmuxlineSnapshot! ~/.config/tmux/tmuxline.conf`
from Vim inside a tmux session.

[tmuxline.vim]: https://github.com/edkolev/tmuxline.vim

## Customization

Note that any additional `.tmux` configuration files added to this plugin
must have the execute bit set to load.

You can customize this configuration or manage your own in the same way.

1. Clone or fork this.
   If you prefer a clean start, clone the `minimal` branch:
   it has the same structure and development tools but with
   a very minimal configuration.
   Tagged releases are based on that branch.
2. Replace any instance of `rxrc/tmuxrc`
   with the path to your repository's location.
   If you do not host this on GitHub,
   you may need to adjust the repository path appropriately.
3. Customize package.json.
4. Update `install.sh` on the `gh-pages` branch.
5. Update the urls for the install script in this README.

Here is an example of a command you can use to make replacements:

```
$ git ls-files -z | xargs -0 sed -i 's/rxrc\/tmuxrc/username\/tmuxrc/g'
```

## Development

You can use [Gulp] to switch to development mode
which will install the local development files to the plugin path.

First, follow the normal install steps if you haven't already.
Then, install the development dependences via [npm] with

```
$ npm install
```

While in a tmux session, enter development mode with

```
$ npm start
```

Switch out of development mode with

```
$ npm stop
```

[Gulp]: http://gulpjs.com/
[npm]: https://www.npmjs.com/

## Contributing

Please submit and comment on bug reports and feature requests.

To submit a patch:

1. Fork it (https://github.com/rxrc/tmuxrc/fork).
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Make changes.
4. Commit your changes (`git commit -am 'Add some feature'`).
5. Push to the branch (`git push origin my-new-feature`).
6. Create a new Pull Request.

## License

This tmux configuration is licensed under the MIT license.

## Warranty

This software is provided "as is" and without any express or
implied warranties, including, without limitation, the implied
warranties of merchantibility and fitness for a particular
purpose.
