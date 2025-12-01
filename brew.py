#!/usr/bin/env python3

import socket
import subprocess

formula_packages = [
    "awscli",
    "bash-language-server",
    "bat",
    "biome",
    "buf",
    "checkstyle",
    "cmake",
    "codespell",
    "colima",
    "cppcheck",
    "delve",
    "direnv",
    "docker",
    "dua-cli",
    "eslint",
    "eza",
    "fastfetch",
    "fd",
    "fzf",
    "gh",
    "go",
    "golangci-lint",
    "google-java-format",
    "gopls",
    "graphviz",
    "htop",
    "hyperfine",
    "jq",
    "lld",
    "llvm",
    "lua-language-server",
    "lz4",
    "make",
    "ninja",
    "node",
    "openjdk",
    "pkg-config",
    "poetry",
    "postgresql",
    "prettier",
    "protobuf",
    "python3",
    "ripgrep",
    "ruff",
    "rustup",
    "shellcheck",
    "shfmt",
    "starship",
    "stylua",
    "taplo",
    "tealdeer",
    "tmux",
    "tokei",
    "typescript",
    "typescript-language-server",
    "typst",
    "uv",
    "wget",
    "yamllint",
    "zstd",
]

if socket.gethostname() == "yhjs-MacBook-Pro.local":
    formula_packages += ["platformio"]

cask_packages = [
    "alacritty",
    "doll",
    "manico",
    "obsidian",
    "rectangle",
    "scroll-reverser",
    "snipaste",
    "telegram-desktop",
    "visual-studio-code",
]

if __name__ == "__main__":
    subprocess.run(["brew", "install", "--formula"] + formula_packages, check=True)
    subprocess.run(["brew", "install", "--cask"] + cask_packages, check=True)
