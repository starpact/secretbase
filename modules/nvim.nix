{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-path
      cmp-snippy
      comment-nvim
      fidget-nvim
      fzf-lua
      gitsigns-nvim
      harpoon
      leap-nvim
      lush-nvim
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-jdtls
      nvim-lint
      nvim-lspconfig
      nvim-snippy
      nvim-surround
      nvim-tree-lua
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-ts-autotag
      nvim-ts-context-commentstring
      vim-snippets
      vim-test
    ];
  };
}
