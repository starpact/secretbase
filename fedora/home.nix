{ pkgs, ... }:

{
  home.stateVersion = "22.05";
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  imports = [
    ../dconf.nix
  ];

  home.packages = with pkgs; [
    clang_14
    liburing
    nix-bash-completions
    wl-clipboard
    wqy_microhei
    wqy_zenhei
    xclip
  ];

  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
      };
      shellAliases = {
        vim = "nvim";
        ls = "exa";
        l = "ls -al";
        cat = "bat";
        lg = "lazygit";
        update = ''
          sudo dnf upgrade
          flatpak update
          home-manager switch --flake ~/workspace/dotfiles#fedora
        '';
      };
      initExtra = ''
        export PATH=$HOME/.cargo/bin:$HOME/go/bin:$PATH
        export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
        stty -ixon
      '';
    };
  };
}
