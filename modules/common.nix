{ pkgs, config, ... }:

{
  fonts.fontconfig.enable = true;

  home.file =
    let
      base = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/secretbase";
      os = if pkgs.stdenv.isLinux then "linux" else "macos";
    in
    {
      ".config/alacritty/alacritty.yml".source = "${base}/modules/alacritty/alacritty_${os}.yml";
      ".config/alacritty/alacritty.toml".source = "${base}/modules/alacritty/alacritty_${os}.toml";
      ".config/nvim".source = "${base}/modules/nvim";
      ".config/tmux".source = "${base}/modules/tmux";
      ".config/yamllint/config".source = "${base}/.yamllint.yaml";
      ".editorconfig".source = "${base}/.editorconfig";
    };

  home.packages = with pkgs; [
    awscli2
    clickhouse
    dig
    dua
    duckdb
    eza
    fd
    ffmpeg
    gh
    gitoxide
    graphviz
    grpcurl
    htop
    hyperfine
    inetutils
    jq
    kubectl
    kubernetes-helm
    lab
    lsof
    lz4
    moreutils
    mysql80
    neofetch
    openssl
    pkg-config
    postgresql
    ripgrep
    sqlite
    tealdeer
    tmux
    tokei
    typst
    unzip
    uv
    wget
    yq-go

    (nerdfonts.override { fonts = [ "FantasqueSansMono" "IosevkaTerm" "VictorMono" ]; })

    (rustPlatform.buildRustPackage rec {
      pname = "wfh";
      version = "b92df5cced6ba08ff719c97d66d3994bb8a6e5b9";
      src = fetchFromGitHub {
        owner = "starpact";
        repo = "walkfromhere";
        rev = version;
        hash = "sha256-xiZtbgs4X632k54sjcweyk5DkOiMa3ypBdBIBju3RlE=";
      };
      cargoHash = "sha256-GNk6qzcfa5/eBCqKUwnD/OA1X4H9QyVmd9Y+1WyvR+g=";
    })
  ];

  programs = {
    bash = {
      enable = true;
      sessionVariables = {
        PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH";
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
      config.theme = "base16-256";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      historyWidgetOptions = [ "--reverse" ];
    };
    starship.enable = true;
    zoxide.enable = true;
  };
}
