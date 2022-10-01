{ pkgs, ... }:

{
  home.stateVersion = "22.05";
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  imports = [
    ../dconf.nix
  ];

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-configtool
    ];
  };

  home.packages = with pkgs; [
    liburing
    llvmPackages_latest.clang-manpages
    llvmPackages_latest.llvm-manpages
    openssl_3
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
        XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
        PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH";
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
    };
  };
}
