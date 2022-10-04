{ pkgs, ... }:

{
  home.stateVersion = "22.05";
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  imports = [
    ../modules/dconf.nix
    ../modules/git.nix
  ];

  home.packages = with pkgs; [
    clang_14
    liburing
    lldb
    llvmPackages_latest.clang-manpages
    llvmPackages_latest.llvm-manpages
    openssl
    wl-clipboard
    wqy_microhei
    wqy_zenhei
    xclip
  ];

  programs = {
    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
        PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH";
      };
      shellAliases = {
        ls = "exa";
        l = "ls -al";
        cat = "bat";
        lg = "lazygit";
        hs = "home-manager switch --flake ~/workspace/dotfiles#fedora-laptop";
        update = ''
          sudo dnf upgrade
          flatpak update
          hs
        '';
      };
    };
    home-manager.enable = true;
  };
}
