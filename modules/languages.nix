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

    # Java
    jdk
    gradle
    gradle-completion
    jdt-language-server
    google-java-format

    # JavaScript/TypeScript
    nodejs
    deno
    nodePackages.typescript-language-server

    # Lua
    sumneko-lua-language-server
    stylua

    # Nix
    rnix-lsp
    nixpkgs-fmt

    # Protobuf
    protobuf
    buf

    # Python
    python310Packages.virtualenv
    nodePackages.pyright
    black
    python310Packages.flake8

    # Rust
    rustup
    rust-analyzer
    cargo-deny
    cargo-expand
    cargo-udeps

    # SQL
    pgformatter

    # TOML
    taplo

    # Wasm
    wasmtime

    # YAML
    nodePackages.yaml-language-server
  ];
}
