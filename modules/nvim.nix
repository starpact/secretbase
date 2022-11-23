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
      cmp-nvim-lua
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
      nvim-navic
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        tree-sitter-bash
        tree-sitter-c
        tree-sitter-cmake
        tree-sitter-comment
        tree-sitter-css
        tree-sitter-dockerfile
        tree-sitter-go
        tree-sitter-gomod
        tree-sitter-html
        tree-sitter-javascript
        tree-sitter-java
        tree-sitter-json
        tree-sitter-lua
        tree-sitter-make
        tree-sitter-markdown
        tree-sitter-markdown-inline
        tree-sitter-nix
        tree-sitter-python
        tree-sitter-regex
        tree-sitter-rust
        tree-sitter-sql
        tree-sitter-toml
        tree-sitter-typescript
        tree-sitter-tsx
        tree-sitter-yaml
      ]))
      nvim-tree-lua
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
