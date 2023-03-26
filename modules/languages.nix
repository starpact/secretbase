{ pkgs, config, ... }:

{
  home.file.".editorconfig".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/.editorconfig";
  home.file.".config/yamllint/config".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/.yamllint.yaml";

  home.packages = with pkgs; [
    # General
    bazel_5
    codespell
    gnumake
    lldb
    nodePackages.prettier

    # Bash
    nodePackages.bash-language-server
    shfmt
    shellcheck

    # C/C++
    clang-tools
    cmake
    cppcheck
    llvmPackages_latest.clang-manpages
    llvmPackages_latest.llvm-manpages

    # Cue
    cue

    # Go
    go
    gopls
    golangci-lint
    gotools
    delve

    # HTML/CSS/JSON/ESLint
    nodePackages.vscode-langservers-extracted

    # Java
    jdk17
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
    lua-language-server
    stylua

    # Nix
    nil
    nixpkgs-fmt

    # Protobuf
    protobuf
    buf
    buf-language-server

    # Python
    python3
    nodePackages.pyright
    black
    python310Packages.flake8
    ruff

    # Rust
    rustup
    rust-analyzer
    cargo-deny
    cargo-expand
    cargo-nextest
    cargo-udeps

    # SQL
    nodePackages.sql-formatter

    # Terraform
    terraform
    terraform-ls

    # TOML
    taplo

    # Wasm
    wasmtime
    wabt

    # YAML
    nodePackages.yaml-language-server
    yamllint

    # Zig
    zig
    zls
  ] ++ (
    if stdenv.isLinux
    then [ gcc gdb ]
    else [ ]
  );
}
