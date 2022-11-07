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
      leap-nvim
      lualine-nvim
      luasnip
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-lint
      nvim-lspconfig
      nvim-surround
      nvim-navic
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-tree-lua
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
      nvim-ts-autotag
      nvim-web-devicons
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
