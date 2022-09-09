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
      nodePackages.eslint
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
      python310Packages.flake8
      rnix-lsp
      rust-analyzer
      sumneko-lua-language-server
      taplo
    ];
  };
}
