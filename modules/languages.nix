{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # General
    codespell
    gdb
    gnumake
    lldb
    nodePackages.prettier

    # Bash
    nodePackages.bash-language-server

    # C/C++
    clang-tools
    cmake
    gcc
    llvmPackages_latest.clang-manpages
    llvmPackages_latest.llvm-manpages

    # Go
    gopls
    golangci-lint
    gotools
    delve

    # HTML/CSS/JSON/ESLint
    nodePackages.vscode-langservers-extracted

    # Lua
    sumneko-lua-language-server
    stylua

    # Java
    jdk
    gradle
    jdt-language-server
    google-java-format

    # Nix
    rnix-lsp
    nixpkgs-fmt

    # Python
    nodePackages.pyright
    black
    python310Packages.flake8

    # JavaScript/TypeScript
    deno
    nodejs
    nodePackages.typescript-language-server

    # SQL
    pgformatter

    # Rust
    rustup
    rust-analyzer
    cargo-deny
    cargo-expand
    cargo-udeps

    # TOML
    taplo

    # YAML
    nodePackages.yaml-language-server
  ];
}
