# .dotfiles

A new attempt to organize my dotfiles and settings. The goal is to keep my home directory as clean and decluttered as possible.  
Therefore i oriented the organisation of my config files around the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).

To deploy and update my dotfiles i use `stow` as my tool of choice. I can run `stow --restow .` in my dotfiles directory and done. Easy as that.

## Installation

Make sure to install Homebrew first:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Remote Installation
```bash
curl -fsSL https://github.com/trucke/.dotfiles/raw/main/install-remote.sh | bash
```

#### Manual Installation

```bash
git clone https://github.com/trucke/.dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles
brew bundle --file Brewfile --no-lock
stow --restow .
```

To configure some basic macOS privacy & security settings (powered by [privacy is sexy](https://privacy.sexy)), run:
```bash
./macos/setup.sh
```

Or run:
```bash
git clone https://github.com/trucke/.dotfiles $HOME/.dotfiles && ./$HOME/.dotfiles/install
```
