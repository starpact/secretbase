{ pkgs, ... }:

{
  programs.bash = {
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
    };
    initExtra = ''
      export PATH=$HOME./cargo/bin:$HOME/go/bin:$PATH
      stty -ixon
    '';
  };
}
