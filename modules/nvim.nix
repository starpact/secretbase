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
      dressing-nvim
      editorconfig-nvim
      fidget-nvim
      friendly-snippets
      gitsigns-nvim
      gruvbox-material
      leap-nvim
      lspkind-nvim
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
      nvim-web-devicons
      project-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      toggleterm-nvim
      vim-test
    ];
  };
}
