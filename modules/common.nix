{ pkgs, config, ... }:

{
  fonts.fontconfig.enable = true;

  home.file =
    let
      base = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/secretbase";
      os = if pkgs.stdenv.isLinux then "linux" else "macos";
    in
    {
      ".config/alacritty/alacritty.toml".source = "${base}/modules/alacritty/alacritty_${os}.toml";
      ".config/wezterm".source = "${base}/modules/wezterm";
      ".config/nvim".source = "${base}/modules/nvim";
      ".config/tmux".source = "${base}/modules/tmux";
      ".config/yamllint/config".source = "${base}/.yamllint.yaml";
      ".editorconfig".source = "${base}/.editorconfig";
    };

  home.packages = with pkgs; [
    buf
    buf-language-server
    cargo-deny
    cargo-expand
    cargo-generate
    cargo-udeps
    checkstyle
    clang-tools
    clickhouse
    cmake
    codespell
    cppcheck
    delve
    dig
    dua
    duckdb
    eza
    fastfetch
    fd
    ffmpeg
    gh
    gitoxide
    gnumake
    go
    golangci-lint
    google-java-format
    gopls
    gotools
    gradle
    gradle-completion
    graphviz
    grpcurl
    htop
    hyperfine
    inetutils
    jdk
    jdt-language-server
    jq
    lld
    llvmPackages.libllvm
    llvmPackages.lldb
    lsof
    lua-language-server
    lz4
    maven
    mold
    moreutils
    mysql80
    nil
    nixpkgs-fmt
    nodePackages.bash-language-server
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.sql-formatter
    nodePackages.vscode-langservers-extracted
    nodejs
    openssl
    pkg-config
    postgresql
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    pyright
    python3
    python311Packages.flake8
    ripgrep
    ruff
    rustup
    shellcheck
    shfmt
    sqlite
    stylua
    taplo
    tealdeer
    terraform
    terraform-ls
    tmux
    tokei
    typescript
    typst
    unzip
    uv
    wget
    yamllint
    yq-go
    zig
    zls
    zstd

    (nerdfonts.override {
      fonts = [
        "InconsolataGo"
        "IosevkaTerm"
        "Recursive"
      ];
    })
  ] ++ lib.optionals stdenv.isLinux [
    cgdb
    gcc
    gdb
  ];

  programs = {
    bash = {
      enable = true;
      sessionVariables = {
        PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH:$HOME/.npm-global/bin";
        FZF_DEFAULT_OPTS = "--color=light";
      };
      shellAliases = {
        ls = "eza";
        l = "ls -ahl";
        cat = "bat";
        gp = "git pull";
        gs = "git status";
        ta = "tmux a";
      };
    };
    bat = {
      enable = true;
      config.theme = "ansi";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      historyWidgetOptions = [ "--reverse" ];
    };
    home-manager.enable = true;
    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        conform-nvim
        diffview-nvim
        fzf-lua
        gitsigns-nvim
        lush-nvim
        markdown-preview-nvim
        nvim-autopairs
        nvim-jdtls
        nvim-lint
        nvim-lspconfig
        nvim-snippy
        nvim-surround
        nvim-tree-lua
        nvim-treesitter-textobjects
        nvim-treesitter.withAllGrammars
        vim-test
        zenbones-nvim
      ];
    };
    starship.enable = true;
    zoxide.enable = true;
  };
}
