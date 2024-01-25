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
      harpoon2
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
      (pkgs.vimUtils.buildVimPlugin {
        name = "";
        src = pkgs.fetchFromGitHub {
          owner = "mcchrish";
          repo = "zenbones.nvim";
          rev = "072b21d16cc1d5ae5701455fadaa47b1e8a61780";
          hash = "sha256-XMIUjlADWyNadGgt6QGfRNGhq7SYizDG9QpGHIj3yQI=";
        };
      })
    ];
  };
}
