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
      ".config/nvim".source = "${base}/modules/nvim";
      ".config/tmux".source = "${base}/modules/tmux";
      ".config/yamllint/config".source = "${base}/.yamllint.yaml";
      ".editorconfig".source = "${base}/.editorconfig";
      ".newsboat/config".source = "${base}/modules/newsboat/config";
      ".newsboat/urls".source = "${base}/modules/newsboat/urls";
    };

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" "FantasqueSansMono" "Terminus" ]; })
    awscli2
    clickhouse
    dig
    du-dust
    duckdb
    erdtree
    eza
    fd
    ffmpeg
    gh
    graphviz
    grpcurl
    htop
    hyperfine
    inetutils
    jq
    kubectl
    kubernetes-helm
    lab
    lazygit
    lsof
    moreutils
    mysql80
    neofetch
    newsboat
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
