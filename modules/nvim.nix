{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      conform-nvim
      diffview-nvim
      fzf-lua
      gitsigns-nvim
      harpoon2
      lush-nvim
      markdown-preview-nvim
      nvim-autopairs
      nvim-jdtls
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
