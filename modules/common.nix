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
    jaq
    jq
    kubectl
    kubernetes-helm
    lab
    lazygit
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
    wget
    yq-go

    (nerdfonts.override {
      fonts = [
        "FantasqueSansMono"
        "iA-Writer"
        "Iosevka"
        "IosevkaTerm"
        "MartianMono"
      ];
    })

    (rustPlatform.buildRustPackage rec {
      pname = "wfh";
      version = "d89583b17813a29b710c409dd518ffe0e513bc31";
      src = fetchFromGitHub {
        owner = "starpact";
        repo = "walkfromhere";
        rev = version;
        hash = "sha256-TImR6oGiiOz3qFgQeHuX4WVWFprG6NfXw7IORXRBSf8=";
      };
      cargoHash = "sha256-oGPdffsmNM9MRezEh5lN6TU5BJVpsQSnNmiEI/+vqNA=";
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
        lg = "lazygit";
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
    nix-index.enable = true;
    starship.enable = true;
    zoxide.enable = true;
  };
}
