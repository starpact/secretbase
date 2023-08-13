{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # General
    codespell
    gnumake
    nodePackages.prettier

    # Ansible
    ansible
    ansible-lint

    # Bash
    nodePackages.bash-language-server
    shfmt
    shellcheck

    # C/C++
    clang-tools_16
    cmake
    cppcheck
    llvmPackages_16.libllvm
    llvmPackages_16.llvm-manpages
    llvmPackages_16.lldb
    llvmPackages_16.lldb-manpages

    # Cue
    cue

    # Go
    go
    gopls
    golangci-lint
    gotools
    go-mockery
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
    cargo-audit
    cargo-deny
    cargo-expand
    cargo-generate
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
    yamllint

    # Zig
    zig
    zls
  ] ++ (
    if stdenv.isLinux
    then [ gcc gdb cgdb ]
    else [ ]
  );
}
