vim.loader.enable()

local function setup_basic()
  -- Disable netrw.
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  vim.o.clipboard = "unnamedplus"
  vim.o.fileencoding = "UTF-8"
  vim.o.foldenable = false
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
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

  vim.api.nvim_create_autocmd("CursorMoved", { command = "echo" })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
    end,
  })
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(ev)
      vim.wo.wrap = ev.file == "" or vim.endswith(ev.file, ".md")
    end,
  })

  vim.g.mapleader = " "

  vim.keymap.set({ "i", "s" }, "jk", "<Esc>")

  vim.keymap.set("n", "<C-h>", "<C-w>h")
  vim.keymap.set("n", "<C-j>", "<C-w>j")
  vim.keymap.set("n", "<C-k>", "<C-w>k")
  vim.keymap.set("n", "<C-l>", "<C-w>l")

  vim.keymap.set({ "n", "x" }, "<C-u>", "10k")
  vim.keymap.set({ "n", "x" }, "<C-d>", "10j")

  vim.keymap.set("i", "<C-b>", "<Left>")
  vim.keymap.set("i", "<C-f>", "<Right>")
  vim.keymap.set("i", "<C-a>", "<C-o>^")
  vim.keymap.set("i", "<C-e>", "<End>")
  vim.keymap.set("i", "<C-k>", "<C-o>D")
  vim.keymap.set("i", "<A-b>", "<C-Left>")
  vim.keymap.set("i", "<A-f>", "<Esc>ea")
  vim.keymap.set("i", "<A-d>", "<C-o>de")

  vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -5<CR>")
  vim.keymap.set("n", "<A-Down>", "<cmd>resize +5<CR>")
  vim.keymap.set("n", "<A-Up>", "<cmd>resize -5<CR>")
  vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +5<CR>")

  vim.keymap.set("n", "<Esc>", function()
    vim.cmd("nohlsearch")
  end)
  vim.keymap.set("i", "<C-Space>", "<nop>")

  vim.keymap.set("x", "<", "<gv")
  vim.keymap.set("x", ">", ">gv")

  -- Copy location.
  vim.keymap.set("n", "cp", function()
    vim.fn.setreg("+", vim.api.nvim_buf_get_name(0) .. ":" .. vim.api.nvim_win_get_cursor(0)[1])
  end)

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
      ".git",
      "Cargo.toml",
      "go.mod",
      "gradlew",
      "Makefile",
      "mvnw",
      "package.json",
      "requirements.txt",
    }, {
      type = "file",
      path = vim.api.nvim_buf_get_name(0),
      upward = true,
    })[1]
    if path then vim.api.nvim_set_current_dir(vim.fs.dirname(path)) end
  end)

  -- Toggle diagnostic virtual text.
  local diagnostic_config = {
    severity_sort = true,
    float = {
      source = true,
    },
    virtual_text = false,
  }
  vim.diagnostic.config(diagnostic_config)
  vim.keymap.set("n", "<A-D>", function()
    diagnostic_config.virtual_text = not diagnostic_config.virtual_text
    vim.diagnostic.config(diagnostic_config)
  end)

  for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = "", texthl = hl })
  end

  require("nvim-surround").setup()
  require("nvim-autopairs").setup()
end

local function setup_colorscheme()
  vim.o.background = "light"
  local lush = require("lush")

  local p = require("zenbones.palette").light
  local s = lush
    .extends({
      require("zenbones.specs").generate(p, "light", {
        transparent_background = true,
        italic_comments = false,
      }),
    })
    .with(function()
      return {
        ---@diagnostic disable: undefined-global
        Function({ fg = p.leaf }),
        Type({ fg = p.wood }),
        Number({ fg = p.water }),
        Constant({ fg = p.water }),
        String({ fg = p.water }),
        Special({ fg = p.blossom }),
        ---@diagnostic enable: undefined-global
      }
    end)
  lush(s)

  vim.api.nvim_set_hl(0, "@constant", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@module", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@function.macro", { link = "Function" })
  vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })
  vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
  vim.api.nvim_set_hl(0, "Boolean", { link = "Constant" })

  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = s.FloatBorder.fg.hex, bg = s.StatusLine.bg.hex })
  vim.api.nvim_set_hl(0, "StatusLineError", { fg = s.DiagnosticError.fg.hex, bg = s.StatusLine.bg.hex })
  vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = s.DiagnosticWarn.fg.hex, bg = s.StatusLine.bg.hex })
  vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = s.DiagnosticInfo.fg.hex, bg = s.StatusLine.bg.hex })
  vim.api.nvim_set_hl(0, "StatusLineHint", { fg = s.DiagnosticHint.fg.hex, bg = s.StatusLine.bg.hex })

  vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticUnderlineWarn" })
  vim.api.nvim_set_hl(0, "DiagnosticDeprecated", { link = "DiagnosticUnderlineWarn" })

  for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end
end

local function setup_treesitter()
  require("nvim-treesitter.configs").setup({
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
        init_selection = "<A-o>",
        node_incremental = "<A-o>",
        node_decremental = "<A-i>",
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
          ["<A-a>"] = "@parameter.inner",
        },
        swap_previous = {
          ["<A-A>"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]a"] = "@parameter.inner",
          ["]b"] = "@block.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]A"] = "@parameter.inner",
          ["]B"] = "@block.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.inner",
          ["[b"] = "@block.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[A"] = "@parameter.inner",
          ["[B"] = "@block.outer",
        },
      },
    },
  })
end

local function setup_statusline()
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
    callback = function(opt)
      vim.opt_local.statusline = string.format("%%!v:lua.StatusLine(%d, 1)", opt.buf)
    end,
  })
  vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    callback = function(opt)
      vim.opt_local.statusline = string.format("%%!v:lua.StatusLine(%d, 0)", opt.buf)
    end,
  })
end

local function setup_tree()
  require("nvim-tree").setup({
    disable_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_cwd = true,
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = { hint = "", info = "", warning = "", error = "" },
    },
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
    system_open = {
      cmd = "code",
    },
  })

  vim.keymap.set("n", "<leader>e", function()
    require("nvim-tree.api").tree.open({ find_file = true })
  end)
  vim.keymap.set("n", "<C-n>", require("nvim-tree.api").tree.toggle)
end

local function setup_git()
  local gitsigns = require("gitsigns")
  gitsigns.setup({
    on_attach = function(bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set("n", "<leader>gh", gitsigns.preview_hunk, opts)
      vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, opts)
      vim.keymap.set("n", "[g", gitsigns.prev_hunk, opts)
      vim.keymap.set("n", "]g", gitsigns.next_hunk, opts)
    end,
  })

  require("diffview").setup({ use_icons = false })
  vim.cmd("cnoreabbrev D DiffviewOpen")
  vim.keymap.set("n", "<leader>gf", function()
    vim.cmd.DiffviewFileHistory("%")
  end)
  vim.keymap.set("n", "<leader>gF", vim.cmd.DiffviewFileHistory)
end

local function setup_search()
  local fzf = require("fzf-lua")

  local default_winopts = {
    height = 0.3,
    width = 1,
    row = 1,
    border = { "─", "─", "─", "", "", "", "", "" },
    hl = {
      cursorline = "visual",
    },
    preview = {
      delay = 0,
      horizontal = "right:50%",
    },
  }

  local no_preview_winopts = {
    preview = {
      hidden = "hidden",
    },
  }

  vim.keymap.set("n", "<leader>f", fzf.files)
  vim.keymap.set("n", "<leader>o", fzf.oldfiles)
  vim.keymap.set("n", "<leader>b", fzf.buffers)
  vim.keymap.set("n", "<leader>/", function()
    local cwd
    if vim.bo.filetype == "NvimTree" then
      local node = require("nvim-tree.api").tree.get_node_under_cursor()
      if node.type == "file" then
        cwd = node.parent.absolute_path
      elseif node.type == "directory" then
        cwd = node.absolute_path
      end
      vim.cmd("wincmd l") -- avoid open file action from nvim-tree buffer
    else
      cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    end
    fzf.live_grep({ cwd = cwd })
  end)
  vim.keymap.set("n", "<leader>?", fzf.live_grep)
  vim.keymap.set("n", "<leader>d", function()
    fzf.diagnostics_workspace({ severity_only = "error" })
  end)
  vim.keymap.set("n", "<leader>D", fzf.diagnostics_workspace)
  vim.keymap.set("n", "<leader>gs", fzf.git_status)
  vim.keymap.set("n", "<leader>gc", fzf.git_bcommits)
  vim.keymap.set("n", "<leader>l", fzf.builtin)

  fzf.register_ui_select()
  fzf.setup({
    winopts = default_winopts,
    defaults = {
      git_icons = false,
    },
    fzf_opts = {
      ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
      ["--no-separator"] = "",
    },
    builtin = {
      winopts = default_winopts,
    },
    files = {
      cwd_prompt = false,
      winopts = no_preview_winopts,
    },
    oldfiles = {
      winopts = no_preview_winopts,
    },
    buffers = {
      winopts = no_preview_winopts,
    },
    grep = {
      rg_glob = true,
    },
    lsp = {
      async_or_timeout = 20000,
      jump_to_single_result = true,
      symbols = { symbol_style = 3 },
    },
    keymap = {
      fzf = {
        ["ctrl-n"] = "down",
        ["ctrl-p"] = "up",
        ["ctrl-j"] = "next-history",
        ["ctrl-k"] = "previous-history",
        ["ctrl-q"] = "select-all+accept",
      },
    },
  })
end

local function setup_format()
  local conform = require("conform")
  conform.setup({
    formatters_by_ft = {
      css = { "biome" },
      go = { "goimports" },
      java = { "google-java-format" },
      javascript = { "biome" },
      javascriptreact = { "biome" },
      lua = { "stylua" },
      nix = { "nixpkgs_fmt" },
      proto = { "buf" },
      python = { "ruff_format" },
      sh = { "shfmt" },
      sql = { "sql_formatter" },
      terraform = { "terraform_fmt" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
      yaml = { "prettier" },
    },
    format_on_save = {
      lsp_format = "fallback",
    },
    notify_on_error = false,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
      "*.c",
      "*.cpp",
      "*.css",
      "*.go",
      "*.h",
      "*.html",
      "*.java",
      "*.js",
      "*.json",
      "*.jsonc",
      "*.jsx",
      "*.lua",
      "*.nix",
      "*.py",
      "*.rs",
      "*.tf",
      "*.toml",
      "*.ts",
      "*.tsx",
      "*.yaml",
      "*.yml",
      "*.zig",
    },
    callback = function()
      conform.format()
    end,
  })

  -- Manually format.
  -- "*.proto", -- buf
  -- "*.sh", -- shfmt
  -- "*.sql", -- sql-formatter
  vim.keymap.set("n", "<A-F>", conform.format)
end

local function setup_lint()
  local lint = require("lint")

  lint.linters_by_ft = {
    go = { "golangcilint" },
    java = { "checkstyle" },
    proto = { "buf_lint" },
    python = { "ruff" },
    yaml = { "yamllint" },
  }

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
  lint.linters.codespell.args = { "-L", "crate,flate,inout,lits,ot,ser,statics,te,wit" }

  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
      lint.try_lint()
      lint.try_lint("codespell")
    end,
  })
end

local function setup_lsp()
  local lspconfig = require("lspconfig")
  local fzf = require("fzf-lua")

  local default_config = {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gr", function()
        fzf.lsp_references({ includeDeclaration = false })
      end, opts)
      vim.keymap.set("n", "gi", fzf.lsp_implementations, opts)
      vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>s", fzf.lsp_document_symbols, opts)
      vim.keymap.set("n", "<leader>S", fzf.lsp_live_workspace_symbols, opts)
      vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    end,
  }

  local function extend_default(config)
    if next(config) == nil then return default_config end
    return vim.tbl_deep_extend("force", default_config, config)
  end

  for server, config in pairs({
    ["bashls"] = {},
    ["bufls"] = {},
    ["clangd"] = {
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
    },
    ["cssls"] = {},
    ["eslint"] = {},
    ["gopls"] = {},
    ["html"] = {},
    ["jsonls"] = {},
    ["lua_ls"] = {
      settings = {
        Lua = {
          workspace = {
            library = { vim.fn.expand("$VIMRUNTIME/lua") },
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
    ["vtsls"] = {},
    ["zls"] = {},
  }) do
    lspconfig[server].setup(extend_default(config))
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
      local root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "mvnw" })
      local root_dir_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      require("jdtls").start_or_attach(extend_default({
        cmd = {
          "jdtls",
          "-data",
          vim.fs.normalize("~/.cache/jdtls/workspace/") .. root_dir_name,
        },
        root_dir = root_dir,
      }))
    end,
  })
end

local function setup_completion()
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

  vim.keymap.set({ "i", "s" }, "<Tab>", function()
    feedkey(has_words_before() and "<C-x><C-o>" or "<Tab>")
  end)

  local snippy = require("snippy")

  vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if snippy.can_expand_or_advance() then snippy.expand_or_advance() end
  end)

  vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if snippy.can_jump(-1) then
      snippy.previous()
    else
      feedkey("<C-h>")
    end
  end)
end

local function setup_test()
  vim.g["test#custom_strategies"] = {
    tmux_pane = function(cmd)
      local function send_command()
        vim.fn.jobstart({ "tmux", "send-key", "-t", ".2", cmd .. "\n" })
      end
      vim.fn.jobstart({ "tmux", "list-panes" }, {
        stdout_buffered = true, -- get all stdout rather than line by line
        on_stdout = function(_, data)
          if #data >= 3 then -- at least 2 lines for pane info and 1 empty string for EOF
            send_command()
          else
            vim.fn.jobstart({ "tmux", "split-window" }, {
              on_stdout = send_command,
            })
          end
        end,
      })
    end,
  }

  vim.g["test#strategy"] = "tmux_pane"

  vim.g["test#go#runner"] = "gotest"
  vim.g["test#go#gotest#options"] = "-v -race -failfast --count=1"

  vim.g["test#rust#runner"] = "cargotest"
  vim.g["test#rust#cargotest#options"] = "-- --nocapture --include-ignored"

  vim.g["test#python#runner"] = "pyunit"

  vim.keymap.set("n", "<leader>tn", vim.cmd.TestNearest)
  vim.keymap.set("n", "<leader>tf", vim.cmd.TestFile)
  vim.keymap.set("n", "<leader>tl", vim.cmd.TestLast)
  vim.keymap.set("n", "<leader>tv", vim.cmd.TestVisit)
end

setup_basic()
setup_colorscheme()
setup_treesitter()
setup_statusline()
setup_tree()
setup_git()
setup_search()
setup_format()
setup_lint()
setup_lsp()
setup_completion()
setup_test()
