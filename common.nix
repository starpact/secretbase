{ pkgs, config, ... }:

{
  home.stateVersion = "24.05";

  fonts.fontconfig.enable = true;

  home.file =
    let
      base = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/secretbase";
      os = if pkgs.stdenv.isLinux then "linux" else "macos";
    in
    {
      ".config/alacritty/alacritty.toml".source = "${base}/alacritty/alacritty_${os}.toml";
      ".config/nvim".source = "${base}/nvim";
      ".config/tmux".source = "${base}/tmux";
      ".config/yamllint/config".source = "${base}/.yamllint.yaml";
      ".editorconfig".source = "${base}/.editorconfig";
    };

  home.packages = with pkgs;
    let
      urlencode = (writeScriptBin "urlencode" ''
        #!${python3}/bin/python
        import sys
        from urllib.parse import quote
        print(quote(sys.argv[1]))
      '');

      urldecode = (writeScriptBin "urldecode" ''
        #!${python3}/bin/python
        import sys
        from urllib.parse import unquote
        print(unquote(sys.argv[1]))
      '');

      nerdfonts-selected = nerdfonts.override {
        fonts = [
          "CascadiaCode"
          "IosevkaTerm"
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
      eza
      fastfetch
      fd
      ffmpeg
      gh
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
      urldecode
      urlencode
      uv
      vscode-langservers-extracted
      wget
      yamllint
      zig
      zls
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
