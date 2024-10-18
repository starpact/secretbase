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
      ".config/nvim".source = "${base}/modules/nvim";
      ".config/tmux".source = "${base}/modules/tmux";
      ".config/yamllint/config".source = "${base}/.yamllint.yaml";
      ".editorconfig".source = "${base}/.editorconfig";
    };

  home.packages = with pkgs; [
    stable.mysql80
    stable.postgresql
    stable.terraform

    bash-language-server
    biome
    buf-language-server
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
    gnumake
    go_1_23
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
    moreutils
    nil
    nixpkgs-fmt
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.sql-formatter
    nodejs
    pkg-config
    poetry
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    pyright
    python3
    ripgrep
    ruff
    rustup
    shellcheck
    shfmt
    sqlite
    stylua
    taplo
    tealdeer
    tmux
    tokei
    typescript
    typst
    unzip
    uv
    vscode-langservers-extracted
    wget
    yamllint
    zig
    zls
    zstd

    (nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "IosevkaTerm"
        "Recursive"
      ];
    })
  ] ++ lib.optionals stdenv.isLinux [
    cgdb
    gcc
    gdb
  ];

  home.sessionVariables = {
    PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH:$HOME/.npm-global/bin";
    FZF_DEFAULT_OPTS = "--color=light";
  };

  programs = {
    bash = {
      enable = true;
      shellAliases = {
        ls = "eza";
        l = "ls -hl";
        la = "ls -ahl";
        cat = "bat";
        gp = "git pull";
        gs = "git status";
        ta = "tmux a";
        urlencode = ''python -c "import sys; from urllib.parse import quote; print(quote(sys.argv[1]))"'';
        urldecode = ''python -c "import sys; from urllib.parse import unquote; print(unquote(sys.argv[1]))"'';
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
