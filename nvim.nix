{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins;[
      comment-nvim
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      dressing-nvim
      fidget-nvim
      formatter-nvim
      gitsigns-nvim
      gruvbox-material
      lualine-nvim
      luasnip
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-lint
      nvim-lspconfig
      nvim-surround
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-tree-lua
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      nvim-ts-autotag
      nvim-web-devicons
      packer-nvim
      plenary-nvim
      popup-nvim
      project-nvim
      toggleterm-nvim
      vim-test
    ];
    extraPackages = with pkgs; [
      black
      codespell
      gopls
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
  };
}
