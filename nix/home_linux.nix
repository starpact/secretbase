{ config, pkgs, ... }:

{
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  home.stateVersion = "22.05";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    cmake
    clang_14
    clang-tools_14
    fd
    gdb
    golangci-lint
    lldb_14
    llvm_14
    mysql80
    (nerdfonts.override { fonts = [ "Iosevka" "VictorMono" "JetBrainsMono" ]; })
    nodejs
    onefetch
    postgresql
    redis
    ripgrep
    rustup
    vlc
    wget
    wqy_microhei
    wqy_zenhei
  ];

  programs.home-manager.enable = true;
  programs.bat.enable = true;
  programs.exa.enable = true;
  programs.go.enable = true;
  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.lazygit.enable = true;
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
  programs.starship.enable = true;
  programs.tealdeer.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../tmux/.tmux.conf;
  };
  programs.zoxide.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      ls = "exa";
      l = "ls -al";
      cat = "bat";
      lg = "lazygit";
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
    initExtra = ''
      export PATH=$HOME./cargo/bin:$HOME/go/bin:$PATH
      export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
      stty -ixon
    '';
  };
}
