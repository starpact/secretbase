{ config, ... }:

let
  pkgs = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/76612b17c0ce71689921ca12d9ffdc9c23ce40b2.tar.gz";
      sha256 = "sha256:03pmy2dv212mmxgcvwxinf3xy6m6zzr8ri71pda1lqggmll2na12";
    })
    { };
  pkgs-stable = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/83fb6c028368e465cd19bb127b86f971a5e41ebc.tar.gz";
      sha256 = "sha256:07fzmjwqfd2m8lf4k17rkmc1vcqxvz3ir2hh22b7h22qn4gg8gdg";
    })
    { config = { allowUnfree = true; }; };
in
{
  home.stateVersion = "24.05";

  imports =
    if pkgs.stdenv.isDarwin then [ (import ./macos.nix { inherit pkgs-stable; }) ]
    else [ ];

  fonts.fontconfig.enable = true;

  home.file =
    let
      base = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/secretbase";
      os = if pkgs.stdenv.isDarwin then "macos" else "linux";
    in
    {
      ".config/alacritty/alacritty.toml".source = "${base}/alacritty/alacritty_${os}.toml";
      ".config/nvim".source = "${base}/nvim";
      ".config/tmux".source = "${base}/tmux";
      ".config/yamllint/config".source = "${base}/.yamllint.yaml";
      ".editorconfig".source = "${base}/.editorconfig";
    };

  home.packages = with pkgs; let
    urlencode = writeScriptBin "urlencode" ''
      #!${python3}/bin/python
      import sys
      from urllib.parse import quote
      print(quote(sys.argv[1]))
    '';

    urldecode = writeScriptBin "urldecode" ''
      #!${python3}/bin/python
      import sys
      from urllib.parse import unquote
      print(unquote(sys.argv[1]))
    '';

    nerdfonts-selected = nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "FantasqueSansMono"
        "Recursive"
      ];
    };
  in
  [
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
    eslint
    eza
    fastfetch
    fd
    ffmpeg
    gh
    git
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
    moreutils
    nerdfonts-selected
    nil
    nixpkgs-fmt
    nodePackages.prettier
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
    urldecode
    urlencode
    uv
    vscode-langservers-extracted
    wget
    yamllint
    zstd
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
        hs = "home-manager switch -f ./home.nix";
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

        (pkgs.vimUtils.buildVimPlugin {
          name = "multicursor-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "jake-stewart";
            repo = "multicursor.nvim";
            rev = "085fdb7433cf8775ca351f92fec8fdcd099cf630";
            sha256 = "sha256-YQW37WsCLKnMM7SuXeRTy5Vcw2Y0BnHFFx/HNCFeu0o=";
          };
        })
      ];
    };
    starship.enable = true;
    zoxide.enable = true;
  };
}
