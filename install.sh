#!/usr/bin/env bash

pushd "${HOME}/.dotfiles"

brew bundle --file "./Brewfile" --no-lock
stow --restow .
bash "./macos/setup.sh"

popd

