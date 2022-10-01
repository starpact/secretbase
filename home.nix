{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./nvim.nix
    ./tmux.nix
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    cmake
    clang-tools
    delve
    deno
    du-dust
    fd
    gdb
    golangci-lint
    kubectl
    mold
    mysql80
    neofetch
    (nerdfonts.override { fonts = [ "Iosevka" "VictorMono" "JetBrainsMono" ]; })
    nodejs
    onefetch
    postgresql
    redis
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
