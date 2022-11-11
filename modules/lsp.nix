{ pkgs, ... }:

{
  home.packages = with pkgs; [
    black
    codespell
    gopls
    jdt-language-server
    nixpkgs-fmt
    nodePackages.bash-language-server
    nodePackages.prettier
    nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    python310Packages.flake8
    rnix-lsp
    rust-analyzer
    sumneko-lua-language-server
    taplo
  ];
}
