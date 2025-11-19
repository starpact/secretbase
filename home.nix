{ pkgs, config, ... }:

{
  home.stateVersion = "25.05";

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
    basedpyright
    bash-language-server
    biome
    buf
    checkstyle
    clang-tools
    cmake
    codespell
    cppcheck
    curl
    delve
    dig
    dua
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
    graphviz
    grpcurl
    htop
    hyperfine
    jdk
    jq
    lazygit
    lld
    lldb
    lsof
    lua-language-server
    lz4
    maven
    moreutils
    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
    nerd-fonts.iosevka-term
    nerd-fonts.recursive-mono
    ninja
    nixpkgs-fmt
    nodePackages.prettier
    nodejs
    pkg-config
    poetry
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    python3
    ripgrep
    ruff
    rustup
    shellcheck
    shfmt
    sqlite-interactive
    stylua
    taplo
    tmux
    tokei
    typescript
    typescript-language-server
    typst
    unzip
    urldecode
    urlencode
    uv
    wget
    yamllint
    zig
    zip
    zls
    zstd

    pkgs.stable.awscli2
    pkgs.stable.postgresql
    pkgs.stable.tealdeer
  ];

  home.sessionVariables = {
    PATH = "$HOME/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/.npm-global/bin:$PATH";
    FZF_DEFAULT_OPTS = "--color=light";
    EDITOR = "nvim";
  };

  programs = {
    zsh = {
      enable = true;
      defaultKeymap = "emacs";
      shellAliases = {
        ls = "eza";
        l = "ls -hl";
        la = "ls -ahl";
        gp = "git pull";
        gs = "git status";
        ta = "tmux a";
        lg = "lazygit";
        vim = "nvim";
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
    starship.enable = true;
  };
}
