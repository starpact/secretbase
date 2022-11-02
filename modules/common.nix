{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    cargo-nextest
    clang-tools
    cmake
    delve
    deno
    du-dust
    fd
    gdb
    gnumake
    golangci-lint
    gotools
    kubectl
    neofetch
    (nerdfonts.override { fonts = [ "Iosevka" "VictorMono" "JetBrainsMono" ]; })
    nodejs
    onefetch
    ripgrep
    rustup
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
