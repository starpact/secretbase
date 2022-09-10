{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./nvim.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    cmake
    clang-tools
    fd
    gdb
    golangci-lint
    kubectl
    llvm_14
    mysql80
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
