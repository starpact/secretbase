{ pkgs, ... }:

{
  home.username = "hongjie.yan";
  home.homeDirectory = "/Users/hongjie.yan";

  imports = [
    ../modules/macos-home.nix
    ../modules/common.nix
  ];

  home.packages = with pkgs; [
    awscli2
    git
    kubectl
    kubernetes-helm
    lab
    ssm-session-manager-plugin
  ];

  programs.bash = {
    initExtra = ''
      eval $(/opt/homebrew/bin/brew shellenv)

      if type brew &>/dev/null
      then
        HOMEBREW_PREFIX="$(brew --prefix)"
        if [[ -r "''${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
        then
          source "$\{HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
        else
          for COMPLETION in "''${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
          do
            [[ -r "''${COMPLETION}" ]] && source "''${COMPLETION}"
          done
        fi
      fi

      source ~/.work
    '';
    shellAliases = {
      hs = "home-manager switch --flake .#macos-work";
    };
  };
}
