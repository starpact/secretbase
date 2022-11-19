{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    du-dust
    fd
    graphviz
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
    unzip
    wget
    wrangler
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
