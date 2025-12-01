#!/usr/bin/env python3

import os

for source, target in [
    (".editorconfig", "~/.editorconfig"),
    (".yamllint.yaml", "~/.config/yamllint/config"),
    (".zshenv", "~/.zshenv"),
    (".zshrc", "~/.zshrc"),
    ("alacritty.toml", "~/.config/alacritty/alacritty.toml"),
    ("nvim", "~/.config/nvim"),
    ("tmux", "~/.config/tmux"),
]:
    source = os.path.abspath(source)
    target = os.path.expanduser(target)
    if os.path.exists(target):
        os.remove(target)
    os.symlink(source, target)
