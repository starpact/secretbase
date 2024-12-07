{ config, ... }:

let
  pkgs = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/55d15ad12a74eb7d4646254e13638ad0c4128776.tar.gz";
      sha256 = "sha256:16lsqai9kv1kkz6xrzgpxrns0b5fynx2l57p8nhhi2krhl5awprk";
    })
    { };
  pkgs-stable = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/b681065d0919f7eb5309a93cea2cfa84dec9aa88.tar.gz";
      sha256 = "sha256:1sd5hq0jw3g9la4w4q63rnrzd6nihi3kqpszldb0n8ws523pbbks";
    })
    { config = { allowUnfree = true; }; };
in
{
  home.stateVersion = "24.11";

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
  in
  [
    bash-language-server
    biome
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
    jq
    lazygit
    lld
    llvmPackages.libllvm
    llvmPackages.lldb
    lsof
    lua-language-server
    lz4
    maven
    moreutils
    nerd-fonts.caskaydia-cove
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.martian-mono
    nerd-fonts.recursive-mono
    nerd-fonts.zed-mono
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
        lg = "lazygit";
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
        nvim-autopairs
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
            rev = "f454cac9d03ccaf20008f4793f05b159f5547e78";
            sha256 = "sha256-0bFqoTq4d49/REDu6Rnmvms3kDIyEl0N57CpxYp0ImU=";
          };
        })
      ];
    };
    starship.enable = true;
    zoxide.enable = true;
  };
}
