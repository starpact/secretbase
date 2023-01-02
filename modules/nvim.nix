{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      comment-nvim
      cmp-nvim-lsp
      cmp-buffer
      cmp-nvim-lsp-signature-help
      cmp-path
      cmp_luasnip
      editorconfig-nvim
      everforest
      fidget-nvim
      friendly-snippets
      fzf-lua
      gitsigns-nvim
      leap-nvim
      lualine-nvim
      luasnip
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-jdtls
      nvim-lint
      nvim-lspconfig
      nvim-surround
      nvim-tree-lua
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      nvim-ts-autotag
      toggleterm-nvim
      vim-test
    ];
  };
}
