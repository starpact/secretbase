{ pkgs, config, ... }:

{
  fonts.fontconfig.enable = true;

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/nvim";
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/tmux";
    ".newsboat/config".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/newsboat/config";
    ".newsboat/urls".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/newsboat/urls";
  };

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    bat
    delta
    du-dust
    duckdb
    erdtree
    exa
    fd
    gh
    graphviz
    htop
    hyperfine
    jq
    lazygit
    lf
    lsof
    neofetch
    newsboat
    ripgrep
    scc
    sqlite
    tealdeer
    tmux
    unzip
    wget
    yq-go
  ];

  programs = {
    bash = {
      enable = true;
      sessionVariables = {
        PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH";
      };
      shellAliases = {
        ls = "exa";
        l = "ls -al";
        cat = "bat";
        lg = "lazygit";
        gp = "git pull";
        gs = "git status";
        ta = "tmux a";
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      historyWidgetOptions = [ "--reverse" ];
    };
    starship.enable = true;
    zoxide.enable = true;
  };
}
