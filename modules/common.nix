{ pkgs, config, ... }:

{
  fonts.fontconfig.enable = true;

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/nvim";
    ".config/helix".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/helix";
    ".newsboat/config".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/newsboat/config";
    ".newsboat/urls".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/newsboat/urls";
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/tmux";
  };

  home.packages = with pkgs; [
    bat
    du-dust
    exa
    fd
    gh
    graphviz
    helix
    htop
    jq
    lazygit
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
    newsboat
    onefetch
    ripgrep
    sqlite
    tealdeer
    tmux
    unzip
    wget
    wrangler
    yq
  ];

  programs = {
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
