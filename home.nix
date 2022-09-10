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
    fd
    gdb
    golangci-lint
    kubectl
    llvm_14
    mysql80
    neofetch
    (nerdfonts.override { fonts = [ "Iosevka" "VictorMono" "JetBrainsMono" ]; })
    nodejs
    onefetch
    openssl_3
    postgresql
    redis
    ripgrep
    rustup
    sqlite
    unzip
    wget
  ];

  programs = {
    bat.enable = true;
    exa.enable = true;
    go.enable = true;
    htop.enable = true;
    jq.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    tealdeer.enable = true;
    zoxide.enable = true;
  };
}
