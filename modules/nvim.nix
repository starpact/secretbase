{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      comment-nvim
      diffview-nvim
      fzf-lua
      gitsigns-nvim
      leap-nvim
      lush-nvim
      markdown-preview-nvim
      none-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-lint
      nvim-lspconfig
      nvim-snippy
      nvim-surround
      nvim-tree-lua
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      vim-test
      zenbones-nvim
      (pkgs.vimUtils.buildVimPlugin {
        name = "";
        src = pkgs.fetchFromGitHub {
          owner = "ThePrimeagen";
          repo = "harpoon";
          rev = "2cd4e03372f7ee5692c8caa220f479ea07970f17";
          hash = "sha256-MUIGRoaFcCqqFatfnFJpnEOUmSYJgV2+teU/NXj6kgY=";
        };
      })
    ];
  };
}
