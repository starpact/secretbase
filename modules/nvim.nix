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
      harpoon
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
    ];
  };
}
