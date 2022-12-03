{ pkgs, config, ... }:

{
  fonts.fontconfig.enable = true;

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/nvim";
    ".config/helix".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/helix";
    ".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/tmux/tmux.conf";
  };

  home.packages = with pkgs; [
    du-dust
    fd
    gh
    graphviz
    helix
    neofetch
    (nerdfonts.override {
      fonts = [
        "FantasqueSansMono"
        "Inconsolata"
        "Iosevka"
        "JetBrainsMono"
        "VictorMono"
      ];
    })
    onefetch
    ripgrep
    sqlite
    tmux
    unzip
    wget
    wrangler
    yq
  ];

  programs = {
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    exa.enable = true;
    fzf = {
      enable = true;
      historyWidgetOptions = [ "--reverse" ];
    };
    go.enable = true;
    htop.enable = true;
    jq.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    tealdeer.enable = true;
    zoxide.enable = true;
  };
}
