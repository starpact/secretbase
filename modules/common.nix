{ pkgs, config, ... }:

{
  fonts.fontconfig.enable = true;

  home.file =
    let
      base = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/secretbase";
      os = if pkgs.stdenv.isLinux then "linux" else "mac";
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
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; })
    awscli2
    dig
    du-dust
    duckdb
    erdtree
    fd
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
    lf
    lsof
    moreutils
    mysql80
    neofetch
    newsboat
    openssl
    pkg-config
    postgresql
    ripgrep
    scc
    sqlite
    tealdeer
    tmux
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
      };
      shellAliases = {
        ls = "lsd";
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
      config.theme = "Nord";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      historyWidgetOptions = [ "--reverse" ];
    };
    lsd = {
      enable = true;
      settings.icons.when = "never";
    };
    nix-index.enable = true;
    starship.enable = true;
    zoxide.enable = true;
  };
}
