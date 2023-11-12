{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp-snippy
      comment-nvim
      diffview-nvim
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
      vim-test
      zenbones-nvim

      (pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "";
        src = pkgs.fetchFromGitHub {
          owner = "ibhagwan";
          repo = "fzf-lua";
          rev = "e1046726cf0cedf15ae0ff40537a421b79968c3e";
          hash = "sha256-A6Q6MRZGzLwVT65/woMIEI1FQ6J7iMWf9OMosGn2BXo=";
        };
      })
    ];
  };
}
