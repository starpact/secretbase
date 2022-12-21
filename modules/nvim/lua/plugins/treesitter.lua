require("nvim-treesitter.configs").setup({
  autotag = { enable = true },
  context_commentstring = { enable = true },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<S-Up>",
      node_incremental = "<S-Up>",
      node_decremental = "<S-Down>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader><leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader><leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.outer",
        ["]b"] = "@block.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]A"] = "@parameter.outer",
        ["]B"] = "@block.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.outer",
        ["[b"] = "@block.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[A"] = "@parameter.outer",
        ["[B"] = "@block.outer",
      },
    },
  },
})
