{ config, pkgs, ... }:

{
  home.username = "yanhj";
  home.homeDirectory = "/Users/yanhj";

  home.stateVersion = "22.05";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    buf
    cmake
    clang-tools_14
    fd
    golangci-lint
    inetutils
    kubectl
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
  programs.tealdeer.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../tmux/.tmux.conf;
  };
  programs.zoxide.enable = true;
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
      KUBECONFIG = "$HOME/workspace/misc/test-admin.conf";
    };
    initExtra = ''
      export PATH=$HOME./cargo/bin:$HOME/go/bin:$PATH
      bindkey -e
      bindkey "^U" backward-kill-line
      backward-kill-whole-word () {
          local WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>:,'\""
          zle -f kill
          zle backward-kill-word
      }
      zle -N backward-kill-whole-word
      bindkey "^W" backward-kill-whole-word
      export WORDCHARS=""
      eval "$(starship init zsh)"
      stty -ixon
    '';
  };
}
