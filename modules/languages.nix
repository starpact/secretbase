{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # General
    codespell
    gnumake
    nodePackages.prettier

    # Bash
    # nodePackages.bash-language-server
    shfmt
    shellcheck

    # C/C++
    clang-tools
    cmake
    cppcheck
    llvmPackages.libllvm
    llvmPackages.lldb
    lld
    mold

    # Go
    go
    gopls
    golangci-lint
    gotools
    delve

    # HTML/CSS/JSON/ESLint
    nodePackages.vscode-langservers-extracted
    nodePackages.eslint

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
    nodePackages.typescript-language-server

    # Lua
    lua-language-server
    stylua

    # Nix
    nil
    nixpkgs-fmt

    # Protobuf
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    buf
    buf-language-server

    # Python
    python3
    pyright
    python311Packages.flake8
    ruff

    # Rust
    rustup
    cargo-deny
    cargo-expand
    cargo-generate
    cargo-udeps

    # SQL
    nodePackages.sql-formatter

    # Terraform
    terraform
    terraform-ls

    # TOML
    taplo

    # YAML
    yamllint
  ] ++ lib.optionals stdenv.isLinux [
    cgdb
    gcc
    gdb
  ];
}
