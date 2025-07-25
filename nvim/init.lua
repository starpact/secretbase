vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.clipboard = "unnamedplus"
vim.o.fileencoding = "UTF-8"
vim.o.foldenable = false
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.ignorecase = true
vim.o.jumpoptions = "stack"
vim.o.number = true
vim.o.scrolloff = 3
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkoff0"

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ higroup = "Search", timeout = 200 }) end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev) vim.wo.wrap = ev.file == "" or vim.endswith(ev.file, ".md") end,
})

vim.g.mapleader = " "

vim.keymap.set({ "i", "s" }, "jk", "<esc>")

vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

vim.keymap.set({ "n", "x" }, "<c-u>", "10k")
vim.keymap.set({ "n", "x" }, "<c-d>", "10j")

vim.keymap.set("i", "<c-b>", "<left>")
vim.keymap.set("i", "<c-f>", "<right>")
vim.keymap.set("i", "<c-a>", "<c-o>^")
vim.keymap.set("i", "<c-e>", "<end>")
vim.keymap.set("i", "<c-k>", "<c-o>D")
vim.keymap.set("i", "<a-b>", "<c-left>")
vim.keymap.set("i", "<a-f>", "<esc>ea")
vim.keymap.set("i", "<a-d>", "<c-o>de")

vim.keymap.set("n", "<a-s-left>", "<cmd>vertical resize -5<cr>")
vim.keymap.set("n", "<a-s-down>", "<cmd>resize +5<cr>")
vim.keymap.set("n", "<a-s-up>", "<cmd>resize -5<cr>")
vim.keymap.set("n", "<a-s-right>", "<cmd>vertical resize +5<cr>")

vim.keymap.set("i", "<c-space>", "<nop>")

vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

vim.keymap.set("n", "<leader>x", "<cmd>tabclose<cr>")

-- Copy location.
vim.keymap.set(
  "n",
  "cp",
  function() vim.fn.setreg("+", vim.api.nvim_buf_get_name(0) .. ":" .. vim.api.nvim_win_get_cursor(0)[1]) end
)

-- Highlight cursor word without moving to next occurrence.
vim.keymap.set("n", "<leader>h", function()
  local cursorword = vim.fn.expand("<cword>")
  vim.fn.setreg("/", string.format([[\<%s\>]], cursorword))
  vim.cmd("set hlsearch")
end)

-- Set pwd to project root.
vim.keymap.set("n", "<leader>w", function()
  local path = vim.fs.find({
    "build.zig",
    "Cargo.toml",
    "go.mod",
    "gradlew",
    "Makefile",
    "mvnw",
    "package.json",
    "requirements.txt",
    ".git",
  }, {
    path = vim.api.nvim_buf_get_name(0),
    upward = true,
  })[1]
  if path then vim.api.nvim_set_current_dir(vim.fs.dirname(path)) end
end)

-- Toggle diagnostic virtual text.
local diagnostic_config = {
  virtual_text = false,
  signs = {
    text = { "", "", "", "" },
  },
  float = {
    source = true,
  },
  severity_sort = true,
}
vim.diagnostic.config(diagnostic_config)
vim.keymap.set("n", "<a-D>", function()
  diagnostic_config.virtual_text = not diagnostic_config.virtual_text
  vim.diagnostic.config(diagnostic_config)
end)

-- statusline
do
  local function get_filepath(bufname)
    local path = bufname
    -- Shorten jdt url.
    if vim.startswith(path, "jdt") then path = path:sub(16, path:find("?") - 1) end

    -- File in current directory.
    local cwd = vim.fn.getcwd()
    if vim.startswith(path, cwd .. "/") then return vim.fs.basename(cwd) .. path:sub(#cwd + 1) end

    -- Shorten nix path.
    local nix_store = "/nix/store/"
    if vim.startswith(path, nix_store) then return "NIX/" .. path:sub(45) end

    -- Shorten home path.
    local home = vim.fs.normalize("~")
    if vim.startswith(path, home) then return "~" .. path:sub(#home + 1) end

    return path
  end

  local function get_git_status()
    local dict = vim.b.gitsigns_status_dict
    if not dict then return "" end
    return dict.head
      .. (dict.added and dict.added > 0 and " +" .. dict.added or "")
      .. (dict.changed and dict.changed > 0 and " ~" .. dict.changed or "")
      .. (dict.removed and dict.removed > 0 and " -" .. dict.removed or "")
  end

  local colormap = {
    [vim.diagnostic.severity.ERROR] = "%#StatusLineError#",
    [vim.diagnostic.severity.WARN] = "%#StatusLineWarn#",
    [vim.diagnostic.severity.INFO] = "%#StatusLineInfo#",
    [vim.diagnostic.severity.HINT] = "%#StatusLineHint#",
  }

  local function get_diagnostics(bufnr, active)
    local mode = vim.api.nvim_get_mode().mode
    if mode == "i" or mode == "ic" or mode == "s" then return "" end

    local cnts = {}
    for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
      cnts[diagnostic.severity] = (cnts[diagnostic.severity] or 0) + 1
    end
    if next(cnts) == nil then return "" end

    local diagnostics = ""
    for _, severity in ipairs({
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    }) do
      if cnts[severity] then diagnostics = diagnostics .. " " .. colormap[severity] .. cnts[severity] end
    end
    if diagnostics == "" then return "" end

    return diagnostics .. (active == 1 and "%#StatusLine#" or "%#StatusLineNC#")
  end

  _G.StatusLine = function(bufnr, active)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if vim.fs.basename(bufname) == "NvimTree_1" then return "" end

    local left = get_filepath(bufname) .. " %m%r" .. get_diagnostics(bufnr, active)
    local right = (active == 1 and get_git_status() or "") .. "%8.(%l,%c%)"
    return left .. "%=" .. right
  end

  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    callback = function(opt) vim.opt_local.statusline = string.format("%%!v:lua.StatusLine(%d, 1)", opt.buf) end,
  })
  vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    callback = function(opt) vim.opt_local.statusline = string.format("%%!v:lua.StatusLine(%d, 0)", opt.buf) end,
  })
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then error("Error cloning lazy.nvim:\n" .. out) end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  {
    "jake-stewart/multicursor.nvim",
    event = "VeryLazy",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      vim.keymap.set({ "n", "v" }, "<down>", function() mc.lineAddCursor(1) end)
      vim.keymap.set({ "n", "v" }, "<up>", function() mc.lineAddCursor(-1) end)
      vim.keymap.set({ "n", "v" }, "<s-down>", function() mc.lineSkipCursor(1) end)
      vim.keymap.set({ "n", "v" }, "<s-up>", function() mc.lineSkipCursor(-1) end)
      vim.keymap.set({ "n", "v" }, "<a-n>", function() mc.matchAddCursor(1) end)
      vim.keymap.set({ "n", "v" }, "<a-N>", function() mc.matchAddCursor(-1) end)
      vim.keymap.set({ "n", "v" }, "<a-s>", function() mc.matchSkipCursor(1) end)
      vim.keymap.set({ "n", "v" }, "<a-S>", function() mc.matchSkipCursor(-1) end)
      vim.keymap.set({ "n", "v" }, "<a-L>", mc.matchAllAddCursors)
      vim.keymap.set("n", "<a-A>", mc.alignCursors)
      vim.keymap.set("v", "m", mc.matchCursors)

      vim.keymap.set("n", "<esc>", function()
        if mc.hasCursors() then mc.clearCursors() end
        vim.cmd("nohlsearch")
        vim.cmd("echo")
      end)
    end,
  },

  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local bg = "light"
      vim.o.background = bg
      local lush = require("lush")
      local palette = require("zenbones.palette")[bg]
      local specs = lush
        .extends({
          require("zenbones.specs").generate(palette, bg, {
            transparent_background = true,
            italic_comments = false,
          }),
        })
        .with(function()
          return {
            ---@diagnostic disable: undefined-global
            Function({ fg = palette.leaf }),
            Type({ fg = palette.wood }),
            Number({ fg = palette.water }),
            Constant({ fg = palette.water }),
            String({ fg = palette.water }),
            Special({ fg = palette.blossom }),
            ---@diagnostic enable: undefined-global
          }
        end)
      lush(specs)

      vim.api.nvim_set_hl(0, "@constant", { link = "Identifier" })
      vim.api.nvim_set_hl(0, "@module", { link = "Identifier" })
      vim.api.nvim_set_hl(0, "@function.macro", { link = "Function" })
      vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })
      vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
      vim.api.nvim_set_hl(0, "@keyword.exception", { link = "Function" })
      vim.api.nvim_set_hl(0, "Boolean", { link = "Constant" })

      vim.api.nvim_set_hl(0, "StatusLineNC", { fg = specs.FloatBorder.fg.hex, bg = specs.StatusLine.bg.hex })
      vim.api.nvim_set_hl(0, "StatusLineError", { fg = specs.DiagnosticError.fg.hex, bg = specs.StatusLine.bg.hex })
      vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = specs.DiagnosticWarn.fg.hex, bg = specs.StatusLine.bg.hex })
      vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = specs.DiagnosticInfo.fg.hex, bg = specs.StatusLine.bg.hex })
      vim.api.nvim_set_hl(0, "StatusLineHint", { fg = specs.DiagnosticHint.fg.hex, bg = specs.StatusLine.bg.hex })

      vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticUnderlineWarn" })
      vim.api.nvim_set_hl(0, "DiagnosticDeprecated", { link = "DiagnosticUnderlineWarn" })

      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end

      vim.api.nvim_set_hl(0, "LspReferenceTarget", {})
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = "true",
        highlight = {
          enable = true,
          disable = { "xml" },
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<a-o>",
            node_incremental = "<a-o>",
            node_decremental = "<a-i>",
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
              ["<a-right>"] = "@parameter.inner",
            },
            swap_previous = {
              ["<a-left>"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },

  { "nvim-treesitter/nvim-treesitter-textobjects" },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "<leader>gh", gitsigns.preview_hunk, opts)
        vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, opts)
        vim.keymap.set("n", "[g", function() gitsigns.nav_hunk("prev") end, opts)
        vim.keymap.set("n", "]g", function() gitsigns.nav_hunk("next") end, opts)
      end,
    },
  },

  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("diffview").setup({ use_icons = false })
      vim.cmd("cnoreabbrev D DiffviewOpen")
      vim.keymap.set("n", "<leader>gf", function() vim.cmd.DiffviewFileHistory("%") end)
      vim.keymap.set("n", "<leader>gF", vim.cmd.DiffviewFileHistory)
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          css = { "biome" },
          java = { "google-java-format" },
          javascript = { "biome" },
          javascriptreact = { "biome" },
          lua = { "stylua" },
          nix = { "nixpkgs_fmt" },
          proto = { "buf" },
          python = { "ruff_format" },
          sh = { "shfmt" },
          terraform = { "terraform_fmt" },
          typescript = { "biome" },
          typescriptreact = { "biome" },
          yaml = { "prettier" },
        },
        notify_on_error = false,
      })

      local fts_manual_format = { "proto", "sh" }

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          if vim.tbl_contains(fts_manual_format, vim.bo.filetype) then return end
          conform.format({ lsp_format = "fallback", timeout_ms = 2000 })
        end,
      })

      vim.api.nvim_create_user_command("Format", function() conform.format({ async = true }) end, {})
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        go = { "golangcilint" },
        java = { "checkstyle" },
        proto = { "buf_lint" },
        python = { "ruff" },
        yaml = { "yamllint" },
      }

      ---@diagnostic disable-next-line
      lint.linters.checkstyle.args = {
        "-c",
        function()
          for _, path in ipairs({ "checkstyle.xml", "scripts/google_style_check.xml" }) do
            if vim.fn.filereadable(path) == 1 then return path end
          end
          return "google_checks.xml"
        end,
      }

      lint.linters.codespell.stdin = false
      lint.linters.codespell.args = { "-L", "crate,flate,inout,lits,NotIn,ot,ser,statics,te,wit" }

      lint.linters.golangcilint.args = {
        "run",
        "--output.json.path=stdout",
        "--issues-exit-code=0",
        "--show-stats=false",
      }

      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          lint.try_lint()
          lint.try_lint("codespell")
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = false
      local fzf = require("fzf-lua")
      local default_config = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "gd", fzf.lsp_definitions, opts)
          vim.keymap.set("n", "gD", fzf.lsp_declarations, opts)
          vim.keymap.set("n", "gy", fzf.lsp_typedefs, opts)
          vim.keymap.set("n", "grr", fzf.lsp_references, opts)
          vim.keymap.set("n", "gri", fzf.lsp_implementations, opts)
          vim.keymap.set("n", "gra", fzf.lsp_code_actions, opts)
          vim.keymap.set("n", "gO", fzf.lsp_document_symbols, opts)

          if client.config.name == "gopls" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                local params = vim.lsp.util.make_range_params(0, "utf-8")
                params.context = { only = { "source.organizeImports" } } ---@diagnostic disable-line
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
                for _, res in pairs(result or {}) do
                  for _, r in pairs(res.result or {}) do
                    if r.edit then vim.lsp.util.apply_workspace_edit(r.edit, "utf-8") end
                  end
                end
              end,
            })
          end
        end,
      }

      local function extend_default(config)
        if next(config) == nil then return default_config end
        return vim.tbl_deep_extend("force", default_config, config)
      end

      for server, config in pairs({
        ["bashls"] = {},
        ["buf_ls"] = {},
        -- ["clangd"] = {},
        ["cssls"] = {},
        ["eslint"] = {},
        ["gopls"] = {},
        ["html"] = {},
        ["jsonls"] = {},
        ["lua_ls"] = {
          settings = {
            Lua = {
              workspace = {
                library = {
                  vim.fn.expand("$VIMRUNTIME/lua"),
                },
              },
            },
          },
        },
        ["nil_ls"] = {},
        ["pyright"] = {},
        ["rust_analyzer"] = {
          settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
              },
            },
          },
        },
        ["taplo"] = {},
        ["ts_ls"] = {},
      }) do
        vim.lsp.config(server, extend_default(config))
        vim.lsp.enable(server)
      end
    end,
  },

  {
    "dcampos/nvim-snippy",
    event = "InsertEnter",
    config = function()
      vim.opt.completeopt = { "menu" }
      vim.opt.shortmess:append("c")

      local function has_words_before()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local function feedkey(key)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
      end

      vim.keymap.set({ "i", "s" }, "<tab>", function() feedkey(has_words_before() and "<c-x><c-o>" or "<tab>") end)
      local snippy = require("snippy")
      vim.keymap.set({ "i", "s" }, "<c-l>", function()
        if snippy.can_expand_or_advance() then snippy.expand_or_advance() end
      end)
      vim.keymap.set({ "i", "s" }, "<c-h>", function()
        if snippy.can_jump(-1) then
          snippy.previous()
        else
          feedkey("<c-h>")
        end
      end)
    end,
  },

  {
    "vim-test/vim-test",
    event = "VeryLazy",
    config = function()
      vim.g["test#custom_strategies"] = {
        tmux_pane = function(cmd)
          local function send_command() vim.system({ "tmux", "send-key", "-t", ".2", cmd .. "\n" }) end
          vim.system({ "tmux", "list-panes" }, nil, function(ret)
            if ret.stdout:find("\n") == ret.stdout:len() then
              vim.system({ "tmux", "split-window" }, nil, send_command)
            else
              send_command()
            end
          end)
        end,
      }

      vim.g["test#strategy"] = "tmux_pane"

      vim.g["test#go#runner"] = "gotest"
      vim.g["test#go#gotest#options"] = "-v --count=1"

      vim.g["test#rust#runner"] = "cargotest"
      vim.g["test#rust#cargotest#options"] = "-- --nocapture --include-ignored"

      vim.g["test#python#runner"] = "pyunit"

      vim.keymap.set("n", "<leader>tn", vim.cmd.TestNearest)
      vim.keymap.set("n", "<leader>tf", vim.cmd.TestFile)
      vim.keymap.set("n", "<leader>tl", vim.cmd.TestLast)
      vim.keymap.set("n", "<leader>tv", vim.cmd.TestVisit)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    config = function()
      require("nvim-tree").setup({
        respect_buf_cwd = true,
        update_cwd = true,
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            git_placement = "after",
            show = {
              file = false,
              folder = false,
            },
          },
        },
        view = {
          width = {
            max = 60,
          },
        },
      })
      vim.keymap.set("n", "<leader>e", function() require("nvim-tree.api").tree.open({ find_file = true }) end)
      vim.keymap.set("n", "<c-n>", require("nvim-tree.api").tree.toggle)
    end,
  },
  {
    "ibhagwan/fzf-lua",
    config = function()
      local fzf = require("fzf-lua")

      local default_winopts = {
        height = 0.3,
        width = 1,
        row = 1,
        border = "border-top",
        title_flags = false,
        preview = {
          delay = 0,
          horizontal = "right:50%",
        },
      }

      vim.keymap.set("n", "<leader>f", fzf.files)
      vim.keymap.set("n", "<leader>o", fzf.oldfiles)
      vim.keymap.set("n", "<leader>b", fzf.buffers)
      vim.keymap.set("n", "<leader>/", function() fzf.live_grep({ cwd = vim.fn.expand("%:p:h") }) end)
      vim.keymap.set("v", "<leader>/", function() fzf.grep_visual({ cwd = vim.fn.expand("%:p:h") }) end)
      vim.keymap.set("n", "<leader>?", fzf.live_grep)
      vim.keymap.set("v", "<leader>?", fzf.grep_visual)
      vim.keymap.set("n", "<leader>d", fzf.diagnostics_workspace)
      vim.keymap.set("n", "<leader>gs", fzf.git_status)
      vim.keymap.set("n", "<leader>gc", fzf.git_bcommits)
      vim.keymap.set("n", "<leader>l", fzf.builtin)

      fzf.register_ui_select()
      fzf.setup({
        winopts = default_winopts,
        fzf_opts = {
          ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
          ["--no-separator"] = "",
        },
        builtin = {
          winopts = default_winopts,
        },
        files = {
          cwd_prompt = false,
          winopts = { preview = { hidden = true } },
        },
        oldfiles = {
          winopts = { preview = { hidden = true } },
        },
        grep = {
          rg_glob = true,
          winopts = { fullscreen = true },
        },
        lsp = {
          includeDeclaration = false,
          symbols = { symbol_style = 3 },
          winopts = { fullscreen = true },
        },
        keymap = {
          fzf = {
            ["ctrl-n"] = "down",
            ["ctrl-p"] = "up",
            ["ctrl-j"] = "next-history",
            ["ctrl-k"] = "previous-history",
          },
        },
      })
    end,
  },
})
