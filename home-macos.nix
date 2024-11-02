{ config, ... }:

let
  fetchNixpkgs = commit: import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/${commit}.tar.gz") {
    config = {
      allowUnfree = true;
    };
  };
  pkgs = fetchNixpkgs "807e9154dcb16384b1b765ebe9cd2bba2ac287fd";
  pkgs-stable = fetchNixpkgs "080166c15633801df010977d9d7474b4a6c549d7";
in
{
  home.username = "hongjie.yan";
  home.homeDirectory = "/Users/hongjie.yan";

  imports = [
    (import ./common.nix { inherit pkgs config; })
  ];

  home.packages = with pkgs-stable; [
    awscli2
    colima
    docker
    findutils
    gnutar
    lab
    ssm-session-manager-plugin
    terraform
  ];

  home.sessionVariables = {
    XDG_DATA_DIRS = "$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS";
    LANG = "en_US.UTF-8";
  };

  programs = {
    home-manager.enable = true;
    bash = {
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
        hs = "home-manager switch -f ./home-macos.nix";
      };
    };
  };
}
