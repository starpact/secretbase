{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      black
      codespell
      gopls
      nixpkgs-fmt
      nodePackages.bash-language-server
      nodePackages.pyright
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      python310Packages.flake8
      rnix-lsp
      sumneko-lua-language-server
      taplo
    ];
  };
}