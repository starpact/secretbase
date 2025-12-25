#!/usr/bin/env python3

import socket
import subprocess

formula_packages = [
    "awscli",
    "bash",
    "bash-completion@2",
    "bat",
    "biome",
    "buf",
    "ccache",
    "cmake",
    "codespell",
    "colima",
    "cppcheck",
    "delve",
    "direnv",
    "docker",
    "docker-compose",
    "dua-cli",
    "duckdb",
    "eslint",
    "eza",
    "fastfetch",
    "fd",
    "findutils",
    "fzf",
    "gh",
    "git",
    "go",
    "golangci-lint",
    "gopls",
    "graphviz",
    "grep",
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
    "pkgconf",
    "poetry",
    "postgresql@18",
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
    "tree-sitter-cli",
    "ty",
    "typescript",
    "typescript-language-server",
    "typst",
    "uv",
    "vscode-langservers-extracted",
    "wget",
    "yamllint",
    "zstd",
]

cask_packages = [
    "alacritty",
    "doll",
    "manico",
    "rectangle",
    "scroll-reverser",
    "snipaste",
    "telegram-desktop",
    "visual-studio-code",
]

if (hostname := socket.gethostname()) == "yhjs-MacBook-Pro.local":
    formula_packages += ["platformio"]
elif hostname.startswith("IT"):
    formula_packages += [
        "checkstyle",
        "google-java-format",
        "lab",
        "openjdk",
        "terraform",
    ]
    cask_packages += ["session-manager-plugin"]


if __name__ == "__main__":
    subprocess.run(["brew", "install", "--formula"] + formula_packages, check=True)
    subprocess.run(["brew", "install", "--cask"] + cask_packages, check=True)
