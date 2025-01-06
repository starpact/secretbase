{ config, ... }:

let
  pkgs = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/6df24922a1400241dae323af55f30e4318a6ca65.tar.gz";
      sha256 = "sha256:06anh1d5jndycxcwn6dw0zznfgsznwxxblzmwf7f3p7b0pf70jbn";
    })
    { };
  pkgs-stable = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/d29ab98cd4a70a387b8ceea3e930b3340d41ac5a.tar.gz";
      sha256 = "sha256:0v41ccwg751qfsryjmbnijq3324kdkmw9cnywxzzd5jjcv032kdy";
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
    in
    {
      ".config/alacritty/alacritty.toml".source = "${base}/alacritty.toml";
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
    nerd-fonts.iosevka-term
    nerd-fonts.martian-mono
    nerd-fonts.recursive-mono
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
