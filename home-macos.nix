{ config, ... }:

let
  pkgs = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/807e9154dcb16384b1b765ebe9cd2bba2ac287fd.tar.gz";
      sha256 = "sha256:1xc6bw4sa7bq34rinmbmz0rdnbr0lan5xvk53kbcjkyc8p1pfvlp";
    })
    { };
  pkgs-stable = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/080166c15633801df010977d9d7474b4a6c549d7.tar.gz";
      sha256 = "sha256:17sls93qjqr0dsh31xph33m1f1x67gs22s3cr8qv20bm8zkab9y4";
    })
    { config = { allowUnfree = true; }; };
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
