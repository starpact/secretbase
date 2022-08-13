{ config, pkgs, ... }:

{
  home.username = "yanhj";
  home.homeDirectory = "/Users/yanhj";

  home.stateVersion = "22.05";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    buf
    cmake
    clang-tools
    fd
    golangci-lint
    inetutils
    mysql80
    (nerdfonts.override { fonts = [ "Iosevka" "VictorMono" "JetBrainsMono" ]; })
    nodejs
    onefetch
    redis
    ripgrep
    rustup
    wget
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
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../.tmux.conf;
  };
  programs.z-lua.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
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
      bindkey -e
      eval "$(starship init zsh)"
      stty -ixon
    '';
  };
}
