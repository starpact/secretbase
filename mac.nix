{ pkgs, ... }:

{
  home.username = "hongjie.yan";
  home.homeDirectory = "/Users/hongjie.yan";

  home.packages = with pkgs.stable; [
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
        hs = "home-manager switch --flake .#mac";
      };
    };
  };
}
