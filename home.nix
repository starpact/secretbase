{ config, ... }:

let
  pkgs = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/799ba5bffed04ced7067a91798353d360788b30d.tar.gz";
      sha256 = "sha256:15b3bqrmr98y5yhm1jrzw23flpiqzlbrwxaiyyzgd3dwfpwy30m2";
    })
    { };
  pkgs-stable = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/030ba1976b7c0e1a67d9716b17308ccdab5b381e.tar.gz";
      sha256 = "sha256:14rpk53mia7j0hr4yaf5m3b2d4lzjx8qi2rszxjhqq00pxzzr64w";
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
    google-java-format
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
    };
    starship.enable = true;
    zoxide.enable = true;
  };
}
