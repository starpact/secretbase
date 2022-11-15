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
    cppcheck
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
    maven
    jdt-language-server
    checkstyle
    google-java-format

    # JavaScript/TypeScript
    nodejs
    deno
    nodePackages.typescript-language-server

    # Lua
    sumneko-lua-language-server
    stylua

    # Nix
    nil
    nixpkgs-fmt

    # Protobuf
    protobuf
    buf-language-server
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

    # Terraform
    terraform
    terraform-ls

    # TOML
    taplo

    # Wasm
    wasmtime

    # YAML
    nodePackages.yaml-language-server
    yamllint
  ];
}
