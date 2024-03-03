{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      comment-nvim
      conform-nvim
      diffview-nvim
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
      telescope-nvim
      telescope-fzf-native-nvim
      vim-test
      zenbones-nvim
    ];
  };
}
