#!/usr/bin/env python3

import os

link_files = [
    (".clang-format", "~/.clang-format"),
    (".clangd", "~/.clangd"),
    (".editorconfig", "~/.editorconfig"),
    (".yamllint.yaml", "~/.config/yamllint/config"),
    (".zshenv", "~/.zshenv"),
    (".zshrc", "~/.zshrc"),
    ("alacritty.toml", "~/.config/alacritty/alacritty.toml"),
    ("nvim", "~/.config/nvim"),
    ("tmux", "~/.config/tmux"),
    ("utils/urldecode.py", "~/bin/urldecode.py"),
    ("utils/urlencode.py", "~/bin/urlencode.py"),
]

if __name__ == "__main__":
    for source, target in link_files:
        source = os.path.abspath(source)
        target = os.path.expanduser(target)
        if os.path.exists(target):
            print(f"skip {target} as it already exists")
            continue
        os.symlink(source, target)
        print(f"linked {target} -> {source}")
