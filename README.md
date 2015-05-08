# tmux Configuration

[![Release](https://img.shields.io/github/release/rxrc/tmuxrc.svg)](https://github.com/rxrc/tmuxrc/releases)
[![MIT License](https://img.shields.io/github/license/rxrc/tmuxrc.svg)](./LICENSE.txt)

My complete tmux configuration as a tmux plugin.

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

```bash
$ curl -L https://git.io/vJAz3 | sh
```

or wget

```bash
$ wget https://git.io/vJAz3 -O - | sh
```

### Manual Install

1. Install [Tmux Plugin Manager].
2. Create `~/.tmux.conf` with

```tmux
# rxrc/tmuxrc

if-shell "test -f ~/.tmux/plugins/tmuxrc/plugins.conf" "source ~/.tmux/plugins/tmuxrc/plugins.conf"
if-shell "test ! -f ~/.tmux/plugins/tmuxrc/plugins.conf" "set -g @tpm_plugins 'tmux-plugins/tpm rxrc/tmuxrc'"
run-shell '~/.tmux/plugins/tpm/tpm'
if-shell "test -f ~/.tmuxline.conf" "source ~/.tmuxline.conf"
```

and run this to install

```bash
$ ~/.tmux/plugins/tpm/scripts/install_plugins.sh
$ ~/.tmux/plugins/tpm/scripts/update_plugin.sh
$ ~/.tmux/plugins/tpm/scripts/install_plugins.sh
$ ~/.tmux/plugins/tpm/scripts/update_plugin.sh
```

## Updating

Updating is handled via the normal [Tmux Plugin Manager]
install and update commands.

Alternatively, you can run the commands listed in the Manual Install section.

## Customization

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

```bash
$ git ls-files -z | xargs -0 sed -i 's/rxrc\/tmuxrc/username\/tmuxrc/g'
```

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
